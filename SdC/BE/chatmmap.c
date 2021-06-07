/* version 0.2.1f (PM, 18/5/21) :
	La discussion est un tableau de messages, couplé en mémoire partagée.
	Un message comporte un auteur, un texte et un numéro d'ordre (croissant).
	Le numéro d'ordre permet à chaque participant de détecter si la discussion a évolué
	depuis la dernière fois qu'il l'a affichée.
	La discussion est couplée à un fichier dont le nom est fourni en premier argument
	de la commande, le second étant le pseudo du participant.
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h> /* définit mmap  */
#include <signal.h>

#include <stdarg.h>
//  #define DEBUG

#define TAILLE_AUTEUR 25
#define TAILLE_TEXTE 128
#define NB_LIGNES 20

/* message : numéro d'ordre, auteur (25 caractères max), texte (128 caractères max) */
struct message {
    int numero;
    char auteur [TAILLE_AUTEUR];
    char texte [TAILLE_TEXTE];
};

/* discussion (20 derniers messages) (la mémoire nécessaire est allouée via mmap(-)) */
struct message * discussion;

/* dernier message en position 0 */
int dernier0 = -1;

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

/* afficher la discussion */
void afficher() {
    int i;
    if(discussion[0].numero == dernier0) {
        return;
    }
    else {
        dernier0 = discussion[0].numero;
    }

    system("clear");  /* nettoyage de l'affichage simple, à défaut d'être efficace */
    printf("==============================(discussion)==============================\n");
    for (i=0; i<NB_LIGNES; i++) {
        if(discussion[i].numero) {
            printf("[%s] : %s\n", discussion[i].auteur, discussion[i].texte);
        }
        else {
            printf("\n");
        }
        
    }
    printf("------------------------------------------------------------------------\n");
}

void traitant (int sig) {
	/* traitant : rafraîchir la discussion, s'il y a lieu, toutes les secondes */
    afficher();
    alarm(1);
}

int main (int argc, char *argv[]) {
    struct message m;
    int i,taille,fdisc;
    FILE * clavier;

#ifdef DEBUG
    argc = 3;
    char* args[] = {"chatmmap", "desc", "usr1"};
    argv = args;
#endif

    if (argc != 3) {
        printf("usage: %s <discussion> <participant>\n", argv[0]);
        exit(1);
    }

    /* ouvrir et coupler discussion */
    if ((fdisc = open (argv[1], O_RDWR | O_CREAT, 0666)) == -1) {
        printf("erreur ouverture discussion\n");
        exit(2);
    }

    /*	mmap ne spécifie pas quel est le résultat d'une écriture *après* la fin d'un fichier
    	couplé (l'envoi de SIGBUS est un effet possible, fréquent). 
    	Il faut donc fixer la taille du fichier couplé à la taille de la discussion
     	*avant* le couplage. Le plus simple serait d'utiliser truncate, mais ici on préfère
     	lseek(à la taille de la discussion) suivi de l'écriture d'un octet (write),
     	qui sont déjà connus.
    */    
    taille = sizeof(struct message)*NB_LIGNES;
    lseek (fdisc, taille, SEEK_SET);
    write (fdisc, &i, 1);

    signal(SIGALRM, traitant);
    alarm(1);

 	/*
 			- couplage et initialisations
 			- boucle : 
 				lire une ligne au clavier, 
 				décaler la discussion d'une ligne vers le haut
				et insérer la ligne saisie en fin. 
      Notes : 
      	- le rafraîchissement peut être géré par un traitant.
      	- la saisie d'un message fixé ("au revoir", par exemple) 
      	  doit permettre de sortir de la boucle, et du programme
     */

    discussion = (struct message*)mmap(NULL, taille, PROT_READ | PROT_WRITE, MAP_SHARED, fdisc, 0);
    while(1) {
        char input[128];
        int len = read(STDIN_FILENO, input, sizeof(input));
        input[len-1] = '\0';
        dprint("stdin: %s\n", input);

        int next_id = discussion[0].numero;
        memmove(discussion+1, discussion, sizeof(struct message)*(NB_LIGNES-1));
        memset(discussion, 0, sizeof(discussion));
        discussion[0].numero = ++next_id;
        strcpy(discussion[0].texte, input);
        strcpy(discussion[0].auteur, argv[2]);
        
        if(strcmp(input, "au revoir") == 0) {
            break;
        }
        traitant(0);
    }

    close(fdisc);
    exit(0);
}