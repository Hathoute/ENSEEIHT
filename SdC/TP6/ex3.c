#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/types.h>

int *base;

void sigsegv_handler(int signo) {
    printf("***sigsegv_handler***\n");
    if(mprotect(base, 10*sizeof(int), PROT_WRITE) == -1) {
        perror("mprotect");
        exit(EXIT_FAILURE);
    }
}

main(int argc,char *argv[]) {
    
    signal(SIGSEGV, sigsegv_handler);

	base = mmap ( NULL, 10*sizeof(int), PROT_NONE, MAP_SHARED|MAP_ANONYMOUS, 0, 0);
    if(base == MAP_FAILED) {
        perror("mmap");
        exit(EXIT_FAILURE);
    }

    base[0] = 3;

    printf("base[0] = %d\n", base[0]);
}