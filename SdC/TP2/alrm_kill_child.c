#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <signal.h>

char *cur = "père";
int id_fils = 0;
int count = 0;

void sighandler(int signum) {
    printf("%s: Signal %d intercepté\n", cur, signum);
}

void exitprgm(int signum) {
    printf("Signal ALARM recu\n");
    if(++count == 5) {
        kill(id_fils, 9);
    }
}

int main () {
    signal(SIGALRM, exitprgm);

    id_fils=fork();
    if (id_fils == -1) {
        printf("Erreur fork\n");
        exit(1);
    }
    if (id_fils == 0) {		/* fils */
        signal(SIGALRM, SIG_IGN);
        printf("Fils invoqué\n");
        printf("Processus %d (fils), de père %d\n", getpid(), getppid());
        while(1) {
            sleep(1);
        }
    }
    else {
        int codeTerm;
        int idFils = wait(&codeTerm);
        if (idFils == -1) {
            perror("wait ");
            exit(2);
        }
        if (WIFEXITED(codeTerm)) {
            printf("Fin du fils par exit %d\n", WEXITSTATUS(codeTerm));
        } else {
            printf("Fin du fils par signal %d\n", WTERMSIG(codeTerm));
        }
    }

    return EXIT_SUCCESS;
}