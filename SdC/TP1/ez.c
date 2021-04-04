#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */

int main(int argc, char *argv[]) {
    int tempsPere, tempsFils;
    int v=5; /* utile pour la section 2.3 */
    pid_t pidFils;

    tempsPere=40;
    tempsFils=20;
    pidFils=fork();
    /* bonne pratique : tester systématiquement le retour des appels système */
    if (pidFils == -1) {
        printf("Erreur fork\n");
        exit(1);
        /* par convention, renvoyer une valeur > 0 en cas d'erreur,
         * différente pour chaque cause d'erreur
         */
    }
    if (pidFils == 0) {		/* fils */
        printf("processus %d (fils), de père %d\nv=%d\n", getpid(), getppid(), v);
        v = 100;
        sleep(tempsFils);
        printf("fin du fils\nv=%d\n", v);
        exit(EXIT_SUCCESS); /* 	bonne pratique : 
        						terminer les processus par un exit explicite */
    }
    else {		/* père */
        printf("processus %d (père), de père %d\nv=%d\n", getpid(), getppid(), v);
        v = 10;
        sleep(tempsPere);
        printf("fin du père\nv=%d\n", v);        
    }
    return EXIT_SUCCESS; /* -> exit(EXIT_SUCCESS); pour le père */
}