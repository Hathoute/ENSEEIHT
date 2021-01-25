# Définition des Variables (à compléter)
CC = c99
CFLAGS = -Wextra -pedantic -c
LDFLAGS = 

# Règles (à compléter avec des variables automatiques)
all: test_file exemple_file

test_file: test_file.o file.o
	$(CC) $(LDFLAGS) $? -o test_file

exemple_file: exemple_file.o file.o
	$(CC) $(LDFLAGS) $? -o exemple_file

depend:
	makedepend *.c -Y.

clean:
	rm *.o test_file exemple_file

.PHONY: clean all depend

# DO NOT DELETE

exemple_file.o: file.h
file.o: file.h
test_file.o: file.h
