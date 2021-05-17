#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main (int argc, char* argv[]) {
    if(argc != 2) {
        printf("Argument mismatch\n");
        return EXIT_FAILURE;
    }

    int desc = open(argv[1], O_WRONLY|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
    if(desc == -1) {
        perror("open");
        return EXIT_FAILURE;
    }
    int ret = dup2(desc, STDOUT_FILENO);

    int child_pid = fork();
    if(child_pid == -1) {
        return EXIT_FAILURE;
    }

    if(child_pid == 0) {
        execlp("ls", "ls", "-alt");
    }
    else {
        wait();
        close(desc);
    }

    return EXIT_SUCCESS;
}
