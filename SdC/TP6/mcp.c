#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

//#define DEBUG

int main(int argc,char *argv[]) {
    #ifdef DEBUG
    argc = 3;
    char *args[] = {"a", "newfilee.txt", "new.txt"};
    argv = args;
    #endif

    if(argc != 3) {
        printf("mcp: Argument mismatch\n");
        exit(EXIT_FAILURE);
    }
    
    int src = open(argv[1], O_RDONLY);
	if(src < 0) {
		printf("mcp: ");
        perror("open");
		exit(EXIT_FAILURE);
	}

	int dest = open(argv[2], O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
	if(dest < 0) {
		printf("mcp: ");
        perror("open");
		exit(EXIT_FAILURE);
	}

    struct stat buf;
    if(fstat(src, &buf) == -1) {
        printf("mcp: ");
        perror("fstat");
        exit(EXIT_FAILURE);
    }

	ftruncate(dest, buf.st_size);
    
	char *base_src = (char*)mmap ( NULL, buf.st_size, PROT_READ, MAP_PRIVATE, src, 0 );
	char *base_dest = (char*)mmap ( NULL, buf.st_size, PROT_WRITE, MAP_SHARED, dest, 0 );
	if(base_src == MAP_FAILED || base_dest == MAP_FAILED) {
		perror("mmap");
		exit(EXIT_FAILURE);
	}

    memcpy(base_dest, base_src, buf.st_size);

	if(munmap(base_dest, buf.st_size) == -1 || munmap(base_src, buf.st_size) == -1) {
		perror("munmap");
		exit(EXIT_FAILURE);
	}
	close(dest);
    close(src);
}