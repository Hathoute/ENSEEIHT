#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define NDEBUG 1

int main (int argc, char* argv[]) {
    char *usr = "hathoute";
    
    #if NDEBUG
    if(argc != 2) {
        printf("Argument mismatch\n");
        return EXIT_FAILURE;
    }
    usr = argv[1];
    #endif

    int p1[2];
    pipe(p1);
    if (fork() == 0) {
        close(p1[0]);
        dup2(p1[1], STDOUT_FILENO);
        execlp("who", "who", NULL);
    }
    
    close(p1[1]);
    int p2[2];
    pipe(p2);
    if (fork() == 0) {
        close(p2[0]);
        dup2(p1[0], STDIN_FILENO);
        dup2(p2[1], STDOUT_FILENO);
        execlp("grep", "grep", usr, NULL);
    }
    
    close(p1[0]);
    close(p2[1]);
    if (fork() == 0) {
        dup2(p2[0], STDIN_FILENO);
        execlp("wc", "wc", "-l", NULL);
    }

    close(p2[0]);
    wait(NULL);
    
}
