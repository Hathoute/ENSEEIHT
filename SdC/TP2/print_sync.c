#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <signal.h>

void sighandler(int sigid) {
    return;
}

int main () {
    signal(SIGUSR1, sighandler);

    int id_fils=fork();
    if (id_fils == -1) {
        printf("Erreur fork\n");
        exit(1);
    }
    if (id_fils == 0) {		/* fils */
        for(int i = 1; i < 101; i += 2) {
            printf("%d\n", i);
            kill(getppid(), SIGUSR1);
            pause();
        }
    }
    else {
        for(int i = 2; i < 101; i += 2) {
            pause();
            printf("%d\n", i);
            kill(id_fils, SIGUSR1);
        }
    }

    return EXIT_SUCCESS;
}