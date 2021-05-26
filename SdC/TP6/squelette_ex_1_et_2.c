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

void exercice2() {
	int taillepage = sysconf(_SC_PAGESIZE);
	int desc = open("newfilee.txt", O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
	if(desc < 0) {
		printf("Could not openn \"newfile.txt\"\n");
		exit(EXIT_FAILURE);
	}
	ftruncate(desc, 3*taillepage);

	char buff[3*taillepage];
	garnir(buff, 3*taillepage, 'a');
	printf("Wrote %d of buff in desc\n", write(desc, buff, sizeof(buff)));

	char *base = (char*)mmap ( NULL, 3*taillepage, PROT_READ|PROT_WRITE, MAP_SHARED, desc, 0 );
	if(base == MAP_FAILED) {
		perror("mmap");
		exit(EXIT_FAILURE);
	}

	int pid = fork();
	if(pid == 0) {
		char *basechild = (char*)mmap ( NULL, 3*taillepage, PROT_READ|PROT_WRITE, MAP_PRIVATE, desc, 0 );
		lister(basechild, 10);

		sleep(4);

		printf("10 premiers caractères de chaque page:\n");
		lister(basechild, 10);
		lister(basechild+taillepage, 10);
		lister(basechild+2*taillepage, 10);
		garnir(basechild+taillepage, taillepage, 'd');
		
		sleep(8);

		printf("10 premiers caractères de chaque page:\n");
		lister(basechild, 10);
		lister(basechild+taillepage, 10);
		lister(basechild+2*taillepage, 10);
		exit(EXIT_SUCCESS);
	}

	sleep(1);
	garnir(base, taillepage, 'b');
	garnir(base+taillepage, taillepage, 'b');

	sleep(6);
	garnir(base+2*taillepage, taillepage, 'c');

	wait(NULL);
	if(munmap(base, 2*taillepage) != 0) {
		perror("munmap");
		exit(EXIT_FAILURE);
	}
	close(desc);
}

void exercice1() {
	int taillepage = sysconf(_SC_PAGESIZE);
	int desc = open("newfilee.txt", O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
	if(desc < 0) {
		printf("Could not openn \"newfile.txt\"\n");
		exit(EXIT_FAILURE);
	}
	ftruncate(desc, 2*taillepage);

	char buff[2*taillepage];
	for(int i = 0; i < 2*taillepage; i++) {
		buff[i] = 'a';
	}
	printf("Wrote %d of buff in desc\n", write(desc, buff, sizeof(buff)));

	char *base = (char*)mmap ( NULL, 2*taillepage, PROT_READ|PROT_WRITE, MAP_SHARED, desc, 0 );
	if(base == MAP_FAILED) {
		perror("mmap");
		exit(EXIT_FAILURE);
	}

	int pid = fork();
	if(pid == 0) {
		sleep(2);
		lister(base, 10);
		lister(base+taillepage, 10);
		garnir(base, taillepage, 'c');
		exit(EXIT_SUCCESS);
	}

	garnir(base+taillepage, taillepage, 'b');

	wait(NULL);
	printf("père: ");
	lister(base, 10);
	if(munmap(base, 2*taillepage) != 0) {
		perror("munmap");
		exit(EXIT_FAILURE);
	}
	close(desc);
}

main(int argc,char *argv[]) {
	exercice2();
}