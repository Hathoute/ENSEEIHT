#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <setjmp.h>

int main () {
    jmp_buf env;

    int loc = 0;
    setjmp(env);

    loc++;
    printf("%d\n", loc);

    longjmp(env, 0);

    return EXIT_SUCCESS;
}
