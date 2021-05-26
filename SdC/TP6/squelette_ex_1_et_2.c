#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>

void garnir(char zone[], int lg, char motif) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		zone[ind] = motif ;
	}
}

void lister(char zone[], int lg) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		printf("%c",zone[ind]);
	}
	printf("\n");
}

int main(int argc,char *argv[]) {
	int taillepage = sysconf(_SC_PAGESIZE);
	int desc = open("newfile.txt", O_WRONLY|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
	if(desc < 0) {
		printf("Could not openn \"newfile.txt\"\n");
		exit(EXIT_FAILURE);
	}
	int *base = mmap ( NULL, taillepage*2*sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED, desc, 0 );
	if(base == MAP_FAILED) {
		printf("Mapping failed\n");
		exit(EXIT_FAILURE);
	}

	for(int i = 0; i < 2*taillepage; i++) {
		base[i] = 'a'; 
	}


}
