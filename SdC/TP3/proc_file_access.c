#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

char *str = "Pere\n";


void scruter() {
    int fdesc = open("temp", O_WRONLY|O_TRUNC);
    for (int i = 1; i < 31; i++) {
        write(fdesc, &i, sizeof(i));
        if(i % 10 == 0) {
            lseek(fdesc, 0, SEEK_SET);
        }
        sleep(1);
    }

    close(fdesc);
}

int main (int argc, char *argv[]) {

    /*int fdesc = open("temp.txt", O_WRONLY);

    int child = fork();
    if (child == 0) {
        str = "Fils\n";
    }
    
    for(int i = 0; i < 10; i++) {
        write(fdesc, str, 5);
        sleep(1);
    }
    

    int child = fork();
    int fdesc = open("temp.txt", O_WRONLY);
    if (child == 0) {
        str = "Fils\n";
    }

    for(int i = 0; i < 10; i++) {
        write(fdesc, str, 5);
        sleep(1);
    }
    
    close(fdesc);*/

    scruter();

    return EXIT_SUCCESS;
}
