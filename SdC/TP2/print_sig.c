#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <signal.h>

char *cur = "père";
char secs = 0;

void sighandler(int signum) {
    printf("%s: Signal %d intercepté\n", cur, signum);
}

void alarmhandler(int signum) {
    secs += 5;
    if(secs > 60) {
        exit(1);
    }

    printf("%s: Program actif pour %d sec!\n", cur, secs);

    alarm(5);
}

int main () {
    //signal(SIGINT, sighandler);
    signal(SIGTSTP, sighandler);

    signal(SIGALRM, alarmhandler);
    alarm(5);

    int pidFils=fork();
    if (pidFils == -1) {
        printf("Erreur fork\n");
        exit(1);
    }
    if (pidFils == 0) {		/* fils */
        printf("Fils invoqué\n");
        cur = "fils";
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

    while(1) {
        sleep(1);
    }

    return EXIT_SUCCESS;
}