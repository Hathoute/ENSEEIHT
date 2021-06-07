/* version 0.2.1f (PM, 18/5/21) :
	Le serveur de conversation
	- crée un tube (fifo) d'écoute (avec un nom fixe : ./ecoute)
	- gère un maximum de maxParticipants conversations : attente (select) sur
		* tube d'écoute : accepter le(s) nouveau(x) participant(s) si possible
			-> initialiser et ouvrir les tubes de service (entrée/sortie) fournis
		* tubes (fifo) de service en entrée -> diffuser sur les tubes de service en sortie
	- détecte les déconnexions lors du select
	- se termine lorsqu'un client de pseudo "fin" se connecte
	Protocole
	- suppose que les clients ont créé les tubes d'entrée/sortie avant la demande de connexion,
		et que ces tubes sont nommés par le nom du client, suffixé par _C2S/_S2C.
	- les échanges par les tubes se font par blocs de taille fixe, dans l'idée d'éviter
	  le mode non bloquant
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#include <stdbool.h>
#include <sys/stat.h>
#include <stdarg.h>

#define DEBUG

#define MAXPARTICIPANTS 5		/* seuil au delà duquel la prise en compte de nouvelles
								 						 	   connexions sera différée */
#define TAILLE_MSG 128			/* nb caractères message complet (nom+texte) */
#define TAILLE_NOM 25			/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1		/* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_RECEPTION 512	/* capacité du tampon de messages reçus */

typedef struct ptp { 			/* descripteur de participant */
    bool actif; /* indique si le descripteur correspond à un client effectivement connecté */
    char nom [TAILLE_NOM];
    int in;		/* tube d'entrée (C2S) */
    int out;	/* tube de sortie (S2C) */
} participant;


participant participants [MAXPARTICIPANTS];
int fd_to_id[MAXPARTICIPANTS];

char buf[TAILLE_RECEPTION]; 	/* tampon de messages reçus/à rediffuser */
int nbactifs = 0;				/* nombre de clients effectivement connectés */
int curcount = 0;

void dprint(const char *format, ...) {
#ifdef DEBUG
	char formated[1024];

	va_list args;
	va_start(args, format);
	vsprintf(formated, format, args);
	printf("**DEBUG**: %s", formated);
	va_end(args);
#endif
}

void proper_shutdown(int code) {
	dprint("Shutdown!\n");
	exit(code);
}

void reorganize() {
	curcount = 0;
	for(int i = 0; i < MAXPARTICIPANTS; i++) {
		if(!participants[i].actif) {
			continue;
		}
		else if(i != curcount) {
			participants[curcount].actif = true;
			strcpy(participants[curcount].nom, participants[i].nom);
			participants[curcount].in = participants[i].in;
			participants[curcount].out = participants[i].out;
			fd_to_id[participants[curcount].out] = curcount;
		}

		curcount++;
	}
}

void effacer(int i) { /* efface le descripteur pour le participant i */
    participants[i].actif = false;
    bzero(participants[i].nom, TAILLE_NOM*sizeof(char));
    participants[i].in = -1;
    participants[i].out = -1;
}

void diffuser(char *dep) { 
/* envoi du message référencé par dep à tous les actifs */
	for(int i = 0; i < curcount; i++) {
		if(!participants[i].actif) {
			continue;
		}

		write(participants[i].out, dep, TAILLE_MSG*sizeof(char));
	}
}


void ajouter(char *dep) { // traite la demande de connexion du pseudo référencé par dep
/*  Si le participant est "fin", termine le serveur (et gère la terminaison proprement)
	Sinon, ajoute un participant actif, de pseudo référencé par dep
*/
    dprint("Ajout de \"%s\"...\n", dep);

	if(curcount == MAXPARTICIPANTS) {
		reorganize();
	}

	if(strcmp(dep, "fin") == 0) {
		proper_shutdown(0);
	}

	participants[curcount].actif = true;
	strcpy(participants[curcount].nom, dep);

	// Ouverture les FIFO créés par le client...
	char s2c[TAILLE_NOM+5], c2s[TAILLE_NOM+5];
	sprintf(s2c, "./%s_s2c", dep);
	sprintf(c2s, "./%s_c2s", dep);
	
    dprint("Opening %s & %s...\n", c2s, s2c);
	
	participants[curcount].out = open(s2c, O_WRONLY);
    participants[curcount].in = open(c2s, O_RDONLY | O_NONBLOCK);		//hack pour select()
	fd_to_id[participants[curcount].in] = curcount;
	
    dprint("FIFOs opened; in = %d, out = %d!\n", 
		participants[curcount].out, participants[curcount].in);

	char strbuf[TAILLE_MSG];
	sprintf(strbuf, "[service] %s rejoint la conversation", participants[curcount].nom);

	nbactifs++;
	curcount++;
	diffuser(strbuf);

}

void desactiver (int p) {
/*  traitement d'un participant déconnecté */
	participants[p].actif = false;
	close(participants[p].in);
	close(participants[p].out);
	nbactifs--;

	char strbuf[TAILLE_MSG];
	sprintf(strbuf, "[service] %s a quité conversation", participants[p].nom);
	diffuser(strbuf);
}

int build_fd_sets(fd_set *readfds) {
	int maxfd = 0;
	FD_ZERO(readfds);
	for(int i = 0; i < curcount; i++) {
		if(participants[i].actif) {
			FD_SET(participants[i].in, readfds);
			maxfd = maxfd > participants[i].in ? maxfd : participants[i].in;
		}
	}

	return maxfd;
}

int main (int argc, char *argv[]) {
    int i,nlus,necrits,res;
    int ecoute;				/* descripteur d'écoute */
	fd_set readfds; 		/* ensemble de descripteurs écoutés par le select */
    char * prochainMessage; /* pour parcourir le contenu du tampon de réception */
	char bufDemandes [TAILLE_NOM*sizeof(char)*MAXPARTICIPANTS]; 
	/* tampon requêtes de connexion. Inutile de lire plus de MAXPARTICIPANTS requêtes */

    /* création (puis ouverture) du tube d'écoute */
    mkfifo("./ecoute",S_IRUSR|S_IWUSR); // mmnémoniques sys/stat.h: S_IRUSR|S_IWUSR = 0600
    ecoute = open("./ecoute", O_RDWR | O_NONBLOCK);

    for (i=0; i<= MAXPARTICIPANTS; i++) {
        effacer(i);
    }
	
	/* autres initialisations */

    while (true) {
    	printf("participants actifs : %d\n",nbactifs);
	/* boucle du serveur : traiter les requêtes en attente 
				 * 	sur le tube d'écoute : ajouter de nouveaux participants 
				 	(tant qu'il y a moins de MAXPARTICIPANTS actifs)
				 * 	sur les tubes d'entrée : lire les messages, et les diffuser.
		   			Note : 
		   			- tous les messages comportent TAILLE_MSG caractères, et les tailles sont
		   			  fixées pour qu'il n'y ait pas de message tronqué, pour simplifier la gestion. 
		   			- un tampon peut contenir plusieurs messages (et prochainMessage est destiné
				  	  à repérer le prochain message du tampon du tube c2s à diffuser)
					- Enfin, on ne traite pas plus de TAILLE_RECEPTION/TAILLE_MSG*sizeof(char)
					  à chaque itération.
    				- dans le cas où la terminaison d'un participant est détectée, gérer sa déconnexion
    				- Attention : le serveur doit fonctionner même lorsqu'aucun client n'est
    				 connecté (de nouveaux clients peuvent se connecter à tout moment)
	*/
		int fdmax = build_fd_sets(&readfds);
		FD_SET(ecoute, &readfds);
		if(ecoute > fdmax) fdmax = ecoute;

		dprint("Pre select...\n");

		if(select(fdmax+1, &readfds, NULL, NULL, NULL) < 0) {
			perror("select");
			proper_shutdown(10);
		}
		
		dprint("Post select...\n");
		
		if(FD_ISSET(ecoute, &readfds)) {
			nlus = read(ecoute, bufDemandes, sizeof(bufDemandes));
			bool send = true;
			for(int i = 0; i < nlus; i++) {
				if(send) {
					ajouter(bufDemandes+i);
					send = false;
					continue;
				}
				if(*(bufDemandes+i) == '\0') {
					send = true;
				}
			}
			FD_CLR(ecoute, &readfds);
		}

		for(int i = 0; i < fdmax+1; i++) {
			if(FD_ISSET(i, &readfds)) {
				nlus = read(i, buf, sizeof(buf));
				prochainMessage = buf;
				while(nlus > 0) {
					if(strcmp(prochainMessage, "au revoir") == 0) {
						desactiver(fd_to_id[i]);
					}
					char msg[TAILLE_MSG];
					sprintf(msg, "[%s] %s", participants[fd_to_id[i]].nom, prochainMessage);
					diffuser(msg);

					int len = strlen(prochainMessage);
					prochainMessage = prochainMessage + len + 1;
					nlus -= len + 1;
				}
			}
		}
	}
}