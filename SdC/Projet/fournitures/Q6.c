#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <signal.h> // SIGCHILD
#include <stdbool.h>
#include <string.h>
#include <errno.h>
#include "readcmd.h"
#include <sys/types.h>
#include <sys/wait.h>

typedef struct cmdline cmdline;

enum proc_state{NA, RUN, SPD, FIN};
char *proc_state_str[] = {"", "Running", "Suspended", "Finished"};

struct bg_proc_data {
    int pid;
    char *line;
    enum proc_state state;
    bool done;
};
typedef struct bg_proc_data bg_proc_data;
bg_proc_data *bg_procs;
int active_bg_procs = 0;
int sz_bg_procs = 4;
int cur_bg_id = 0;

int cur_fg_pid;
int fg_finished = false;

char* format_line(char** line) {
    char* fline = malloc(sizeof(char)*1);
    int sz = 1;
    fline[0] = 0;
    for(int i = 0; line[i] != NULL; i++) {
        sz = sz + strlen(line[i]) + 1;
        realloc(fline, sizeof(char)*sz);
        strcat(fline, line[i]);
        strcat(fline, " ");
        //sprintf(fline, "%s%s ", fline, line[i]);
    }

    return fline;
}

void print_proc_info(int id) {
    if(bg_procs[id].state != FIN) {
        printf("[%i]\t%s\t\t\t%s\n", id+1, proc_state_str[bg_procs[id].state], bg_procs[id].line);
    }
    else {
        printf("[%i]\t%s\t\t\t%s\n", id+1, bg_procs[id].done ? "Done" : "Exit", bg_procs[id].line);
    }
}

void add_bg_process(int pid, char **line) {
    if(cur_bg_id == sz_bg_procs) {
        sz_bg_procs *= 2;
        realloc(bg_procs, sizeof(bg_proc_data)*sz_bg_procs);
    }

    bg_procs[cur_bg_id].line = format_line(line);
    bg_procs[cur_bg_id].pid = pid;
    bg_procs[cur_bg_id].state = RUN;
    bg_procs[cur_bg_id].done = false;
    active_bg_procs++;
    cur_bg_id++;
}
void sigchild_handler(int sig) {
    int codeTerm;
    pid_t chpid = wait(&codeTerm);

    if(chpid == cur_fg_pid) {
        fg_finished = true;
        return;
    }

    int id = 0;
    for(id = 0; id < sz_bg_procs; id++) {
        if (bg_procs[id].pid == chpid) {
            break;
        }
    }

    if(id == sz_bg_procs) {       
        // Fils d'une commande executée en foreground...
        return;
    }

    bg_procs[id].state = FIN;
    bg_procs[id].done = WIFEXITED(codeTerm) && WEXITSTATUS(codeTerm) == 0;
}

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
    // Ici on est sur que c'est le parent qui execute.

    if(cmd.backgrounded != NULL) {
        add_bg_process(pidFils, cmd.seq[0]);
        printf("[%i] %i\n", cur_bg_id, pidFils);
        return;
    }

    fg_finished = false;
    cur_fg_pid = pidFils;
    while(!fg_finished) {
        sleep(5);
    }
}

void show_jobs() {
    if (active_bg_procs == 0) {
        return;
    }
    
    for(int i = 0; i < sz_bg_procs; i++) {
        if (bg_procs[i].state != NA && bg_procs[i].state != FIN) {
            print_proc_info(i);
        }
    }
}

void stop_proc(char* str_id) {
    int id = atoi(str_id);
    if(--id < 0) {
        printf("stop: job id must be a number > 0\n");
    }

    if(id >= sz_bg_procs || (bg_procs[id].state != RUN && bg_procs[id].state != SPD)) {
        printf("stop: job #%i does not exist\n", id+1);
        return;
    }

    if(bg_procs[id].state == SPD) {
        printf("stop: job #%i already suspended\n", id+1);
        return;
    }

    kill(bg_procs[id].pid, SIGSTOP);
    bg_procs[id].state = SPD;
    printf("pid: %i\n", bg_procs[id].pid);
}

void post_exec_cmd() {
    for(int i = 0; i < sz_bg_procs; i++) {
        if (bg_procs[i].state != FIN) {
            continue;
        }
        
        active_bg_procs--;
        print_proc_info(i);
        bg_procs[i].state = NA;
    }

    if(active_bg_procs == 0) {
        cur_bg_id = 0;
    }
}

void pre_exec_cmd(cmdline cmd) {
    if(cmd.seq[0] == NULL) {
        // Pas de commande...
        return;
    }

    char* tmp = cmd.seq[0][0];
    if (strcmp(tmp, "cd") == 0) {
        call_cd(cmd);
    }
    else if(strcmp(tmp, "exit") == 0) {
        exit(EXIT_SUCCESS);
    }
    else if(strcmp(tmp, "jobs") == 0) {
        show_jobs();
    }
    else if(strcmp(tmp, "stop") == 0) {
        stop_proc(cmd.seq[0][1]);
    }
    else {
        exec_cmd(cmd);
    }
}

int main () {
    cmdline *p_cmd;

    signal(SIGCHLD, sigchild_handler);
    signal(SIGSTOP, sigchild_handler);
    bg_procs = malloc(sizeof(bg_proc_data)*sz_bg_procs);

    while(1) {
        printf("sh-3.2$ ");
        p_cmd = readcmd();
        if (p_cmd != NULL) {
            pre_exec_cmd(*p_cmd);
            post_exec_cmd();
        }
    }
    
    return EXIT_SUCCESS;
}
