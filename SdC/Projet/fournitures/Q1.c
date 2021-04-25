#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <stdbool.h>
#include <string.h>
#include "readcmd.h"

typedef struct cmdline cmdline;

bool exec_cmd(cmdline cmd) {
    pid_t pidFils;

    pidFils = fork();

    if (pidFils == -1)
        return false;

    if (pidFils == 0) {
        execvp(cmd.seq[0][0], cmd.seq[0]);
        exit(EXIT_FAILURE);
    }
    
    return true;
}

int main () {
    cmdline *p_cmd;

    while(1) {
        printf("sh-3.2$ ");
        p_cmd = readcmd();
        if (p_cmd != NULL)
        {
            exec_cmd(*p_cmd);
        }
    }
    
    return EXIT_SUCCESS;
}
