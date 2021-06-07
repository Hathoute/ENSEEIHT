/* version 0.1.1f (PM, 18/5/21) :
	Le client de conversation
	- crée deux tubes (fifo) d'E/S, nommés par le nom du client, suffixés par _C2S/_S2C
	- demande sa connexion via le tube d'écoute du serveur (nom supposé connu),
		 en fournissant le pseudo choisi (max TAILLE_NOM caractères)
	- attend la réponse du serveur sur son tube _C2S
	- effectue une boucle : select sur clavier et S2C.
	- sort de la boucle si la saisie au clavier est "au revoir"
	Protocole
	- les échanges par les tubes se font par blocs de taille fixe TAILLE_MSG,
	- le texte émis via C2S est préfixé par "[pseudo] ", et tronqué à TAILLE_MSG caractères
Notes :
	-le  client de pseudo "fin" n'entre pas dans la boucle : il permet juste d'arrêter
		proprement la conversation.
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>

#include <stdarg.h>
//#define DEBUG

#define TAILLE_MSG 128			/* nb caractères message complet ([nom]+texte) */
#define TAILLE_NOM 25			/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1		/* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_RECEPTION 512	/* capacité du tampon de messages reçus */
#define NB_LIGNES 20
#define TAILLE_SAISIE 512		/* capacité du tampon pour les lignes saisies 
									 (hypothèse : pas de caractère de plus de 4 octets) */

char discussion [NB_LIGNES] [TAILLE_MSG]; /* derniers messages reçus */

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

void afficher(int depart) {
    /* affiche les lignes de discussion[] en commençant par la plus ancienne (départ+1 % nbln)
       et en finissant par la plus récente (départ) */
    int i;
    system("clear");  /* nettoyage de l'affichage simple, à défaut d'être efficace (1) */
    printf("==============================(discussion)==============================\n");
    for (i=1; i<=NB_LIGNES; i++) {
        printf("%s\n", discussion[(depart+i)%NB_LIGNES]);
    }
    printf("------------------------------------------------------------------------\n");
}

int main (int argc, char *argv[]) {
    int i,nlus,necrits;
    char * prochainMessage;		 /* pour parcourir le contenu reçu d'un tube */

    int ecoute, S2C, C2S;		 /* descripteurs tubes de service*/
    int curseur = 0;			 /* position (affichage) dernière ligne reçue et affichée */

    fd_set readfds;				 /* ensemble de descripteurs écoutés par le select */

    char tubeC2S [TAILLE_NOM+5]; /* chemin tube de service client -> serveur = pseudo_c2s */
    char tubeS2C [TAILLE_NOM+5]; /* chemin tube de service serveur -> client = pseudo_s2c */
    char pseudo [TAILLE_NOM];
    char message [TAILLE_MSG];
    char saisie [TAILLE_SAISIE]; /* tampon recevant la ligne saisie au clavier */
    char buf [TAILLE_RECEPTION]; /* tampon recevant les messages du tube s2c */

    int code_retour = 0;

    if (!((argc == 2) && (strlen(argv[1]) < TAILLE_NOM*sizeof(char)))) {
        printf("utilisation : %s <pseudo>\n", argv[0]);
        printf("Le pseudo ne doit pas dépasser 25 caractères\n");
        exit(1);
    }

    /* ouverture du tube d'écoute */
    dprint("Opening FIFO...\n");
    
    ecoute = open("./ecoute", O_WRONLY | O_NONBLOCK);
    if (ecoute==-1) {
        printf("Le serveur doit être lance, et depuis le meme repertoire que le client\n");
        exit(2);
    }
    
    dprint("FIFO opened!\n");
    
    /* création des tubes de service */
    strcpy(pseudo, argv[1]);
    sprintf(tubeC2S, "./%s_c2s", pseudo);
    sprintf(tubeS2C, "./%s_s2c", pseudo);
    mkfifo(tubeC2S, S_IRUSR|S_IWUSR);
    mkfifo(tubeS2C, S_IRUSR|S_IWUSR);
    sleep(1);

    dprint("Attempting connection to server...\n");
    
    /* demande de connexion au serveur*/
    write(ecoute, pseudo, strlen(pseudo)+1);

    dprint("Connected to server!\n");

    if (strcmp(pseudo,"fin")!=0) { /* "console fin" provoque la terminaison du serveur */
        /* client "normal" */

    /* initialisations */
        /* ouverture des tubes de service seulement ici (après la demande de connexion) au serveur)
          car il faut que la connexion au serveur ait eu lieu auparavant, pour que le 
          serveur puisse effectuer l'ouverture des tubes de service de son côté, et ainsi
          permettre au client d'ouvrir les tubes sans être bloqué  (voir sujet, §3.2 )*/
        dprint("Opening client & server FIFOs...\n");
        
        if((S2C = open(tubeS2C, O_RDONLY | O_NONBLOCK)) == -1) {
            perror("open");
        }
        if((C2S = open(tubeC2S, O_WRONLY)) == -1) {
            perror("open");
        }

        dprint("client & server opened; s2c = %d, c2s = %d!\n", S2C, C2S);
        
        fcntl(STDIN_FILENO, F_SETFL, fcntl(STDIN_FILENO, F_GETFL) | O_NONBLOCK);

        while (strcmp(saisie,"au revoir")!=0) {
     /* boucle principale  :
            * récupérer les messages reçus éventuels, puis les afficher.
              	- tous les messages comportent TAILLE_MSG caractères, et les constantes
				  sont fixées pour qu'il n'y ait pas de message tronqué, ce qui serait
				  pénible à gérer.
				- un tampon peut contenir plusieurs messages (et prochainMessage est destiné
				  à repérer le prochain message du tampon à afficher)
            	- lors de l'affichage, penser à effacer les lignes avant de les affecter
            	  pour éviter l'affichage de caractères parasites si l'ancienne ligne est
            	  plus longue que la nouvelle.
            * récupérer la ligne saisie éventuelle, puis l'envoyer
            */
            FD_ZERO(&readfds);
            FD_SET(STDIN_FILENO, &readfds);
            FD_SET(S2C, &readfds);
            if(select(S2C+1, &readfds, NULL, NULL, NULL) < 0) {
                perror("select");
                code_retour = 10;
                goto terminate;
		    }
            if(FD_ISSET(STDIN_FILENO, &readfds)) {
                bzero(saisie, sizeof(saisie));
                read(STDIN_FILENO, saisie, sizeof(saisie));
                saisie[strlen(saisie)-1] = '\0';
                dprint("Saisie: %s\n", saisie);
                write(C2S, saisie, strlen(saisie)+1);   
            }
            if(FD_ISSET(S2C, &readfds)) {
                read(S2C, buf, sizeof(buf));
                dprint("Message reçu: %s\n", buf);
                strcpy(discussion[curseur], buf);
                afficher(curseur);
                curseur++;
                curseur %= NB_LIGNES;
            }
        }
    }
    /* nettoyage des tubes de service */

terminate:
    close(S2C);
    close(C2S);
    printf("fin client\n");
    exit (0);
}

/* Note : Pour éviter un appel de system() à chaque affichage, une solution serait,
		  à l'initialisation du main(), d'appeler system("clear > nettoie"), pour récupérer
		  la séquence spécifique au terminal du client permettant d'effacer l'affichage,
          puis d'ouvrir nettoie en écriture, pour en écrire le contenu à chaque affichage.
          Cependant, le surcoût n'est pas vraiment critique ici pour l'application.
          Le principe (donné dans le sujet) est que tous les processus ouvrent les tubes
          dans le même ordre, pour éviter un interblocage (méthode des classes ordonnées).
 */