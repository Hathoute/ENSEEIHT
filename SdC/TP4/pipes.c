#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void scenario_1() {
    int p[2];

    int child_id = fork();
    pipe(p);
    if (child_id == 0) {
        close(p[1]);
        int rd;
        read(p[0], &rd, sizeof(int));
        close(p[0]);
        printf("Entier lu: %d\n", rd);
    }
    else {
        close(p[0]);
        int e = 10;
        write(p[1], &e, sizeof(e));
        close(p[1]);
    }
    
}

void scenario_2() {
    int p[2];

    pipe(p);
    int e = 100;
    write(p[1], &e, sizeof(e));
    close(p[1]);
    int child_id = fork();
    if (child_id == 0) {
        close(p[1]);
        int rd;
        read(p[0], &rd, sizeof(int));
        close(p[0]);
        printf("Entier lu: %d\n", rd);
    }
    else {
        close(p[0]);
    }
    
}

void scenario_3() {
    int p[2];

    pipe(p);
    if(fork() == 0) {
        close(p[1]);
        int ret;
        while(1) {
            read(p[0], &ret, sizeof(ret));
            if(ret < 0)
                break;
            
            printf("%d\n", ret);
        }
        printf("Sortie de boucle\n");
    }
    else {
        close(p[0]);
        int buff[] = {1, 333, 51, 100, 13, 1, -1};
        write(p[1], buff, sizeof(buff));
        close(p[1]);
        pause();
    }
}

void scenario_4() {
    int p[2];

    pipe(p);
    if(fork() == 0) {
        close(p[1]);
        int ret;
        while(1) {
            read(p[0], &ret, sizeof(ret));
            if(ret < 0)
                break;
            
            printf("%d\n", ret);
        }
        printf("Sortie de boucle\n");
    }
    else {
        close(p[0]);
        int buff[] = {1, 333, 51, 100, 13, 1, -1};
        write(p[1], buff, sizeof(buff));
        close(p[1]);
        sleep(10);
    }
}

int main (int argc, char* argv[]) {
    scenario_4();

    return EXIT_SUCCESS;
}
