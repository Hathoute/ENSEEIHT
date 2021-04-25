#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define BUFSIZE 4096

char buffer[BUFSIZE];

void exit_on_error(char* err, int err_code) {
    perror(err);
    exit(err_code);
}

int main (int argc, char *argv[]) {
    if(argc < 3) {
        printf("Usage: copy fichier1 fichier2\n");
        return EXIT_FAILURE;
    }
    
    int fsrc = open(argv[1], O_RDONLY);
    if (fsrc == -1) {
        exit_on_error("open(src): ", 100);
    }
    printf("Descripteur du fichier source: %d\n", fsrc);

    int fdest = open(argv[2], O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IRGRP|S_IROTH);
    if(fdest == -1) {
        exit_on_error("open(dest): ", 101);
    }
    printf("Descripteur du fichier crée: %d\n", fdest);
    while(1) {
        int sz = read(fsrc, buffer, BUFSIZE);
        if (sz == -1) {
            exit_on_error("read: ", 102);
        }
        else if (sz == 0) {
            break;
        }
        else {
            if (write(fdest, buffer, sz) == -1) {
                exit_on_error("write: ", 103);
            }
        }
    }
    
    close(fdest);
    close(fsrc);
    
    return EXIT_SUCCESS;
}
