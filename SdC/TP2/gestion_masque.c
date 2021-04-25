#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <signal.h>

void sighandler(int signum) {
    printf("Reception %d\n", signum);
}

int main () {
    signal(SIGUSR1, sighandler);
    signal(SIGUSR2, sighandler);
    
    sigset_t masks[] = {SIGUSR1, SIGINT};
    sigprocmask(SIG_SETMASK, masks, NULL);

    sleep(10); 

    kill(getpid(), SIGUSR1);
    kill(getpid(), SIGUSR1);

    sleep(5);

    kill(getpid(), SIGUSR2);
    kill(getpid(), SIGUSR2);

    sigset_t unmask1[] = {SIGUSR1};
    sigprocmask(SIG_UNBLOCK, unmask1, NULL);

    sleep(5);

    sigset_t unmask2[] = {SIGINT};
    sigprocmask(SIG_UNBLOCK, unmask2, NULL);

    printf("Salut\n");
    return EXIT_SUCCESS;
}
