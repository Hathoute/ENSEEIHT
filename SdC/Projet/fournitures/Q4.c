#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <stdbool.h>
#include <string.h>
#include <errno.h>
#include "readcmd.h"

typedef struct cmdline cmdline;

void call_cd(cmdline cmd) {
    char **line = cmd.seq[0];

    if (line[1] == NULL) {
        return;
    }
    else if(line[2] != NULL) {
        printf("cd: too many arguments\n");
        return;
    }
    
    char *arg = cmd.seq[0][1];
    int res = chdir(arg);
    if (res != 0) {
        perror(arg);
        //return res == ENOTDIR || res == ENOENT;
    }
}

void exec_cmd(cmdline cmd) {
    pid_t pidFils, idFils;

    pidFils = fork();

    if (pidFils == -1)  // Anomalie
        return;

    if (pidFils == 0) {
        execvp(cmd.seq[0][0], cmd.seq[0]);
        exit(EXIT_FAILURE);
    }
    else {
        int codeTerm;
        idFils = wait(&codeTerm);
        if (idFils == -1)   // Anomalie
            return;
        
        if (WIFEXITED(codeTerm) && codeTerm == 0)   // Travail fait
            return;
    }
}

void pre_exec_cmd(cmdline cmd) {
    char* tmp = cmd.seq[0][0];
    if (strcmp(tmp, "cd") == 0) {
        call_cd(cmd);
    }
    else if(strcmp(tmp, "exit") == 0) {
        exit(EXIT_SUCCESS);
        return;
    }
    else {
        exec_cmd(cmd);
    }
    
}

int main () {
    cmdline *p_cmd;

    while(1) {
        printf("sh-3.2$ ");
        p_cmd = readcmd();
        if (p_cmd != NULL) {
            pre_exec_cmd(*p_cmd);
        }
    }
    
    return EXIT_SUCCESS;
}
