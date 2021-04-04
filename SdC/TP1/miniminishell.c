#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <stdbool.h>
#include <string.h>


bool exec_cmd(char cmd[]) {
    pid_t pidFils, idFils;

    pidFils = fork();

    if (pidFils == -1)
        return false;

    if (pidFils == 0) {
        execlp(cmd, cmd, NULL);
        exit(EXIT_FAILURE);
    }
    else {
        int codeTerm;
        idFils = wait(&codeTerm);
        if (idFils == -1)
            return false;
        
        if (WIFEXITED(codeTerm) && codeTerm == 0)
            return true;
    }
    return false;
}

int main () {
    char buf[30];
    int ret;

    while(1) {
        printf(">>>");
        if(scanf("%s", &buf) == EOF || !strcmp(buf, "exit"))
            break;
        
        if(exec_cmd(buf))
            printf("SUCCESS\n");
        else
            printf("ECHEC\n");
    }
    
    printf("Salut");
    return EXIT_SUCCESS;
}
