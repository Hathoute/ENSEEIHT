#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h> /* wait */

int main(int argc, char *argv[]) {
  pid_t pidFils, idFils;

  pidFils=fork();
  /* bonne pratique : tester systématiquement le retour des appels système */
  if (pidFils == -1) {
    printf("Erreur fork\n");
    exit(1);
    /* par convention, renvoyer une valeur > 0 en cas d'erreur,
     * différente pour chaque cause d'erreur
     */
  }


  if (pidFils == 0) {  /* fils */
    char pg_path[] = "/bin/ls";
    char pg_name[] = "ls";
    char arg0[] = "-l";
    char arg1[] = "weee.c";
    
    char * args[] = {pg_path, arg0, arg1, NULL};

    goto execve;

    execl: printf("execl: \n");
    execl(pg_path, pg_path, arg0, arg1, NULL);

    execlp: printf("execlp: \n");
    execlp(pg_name, pg_name, arg0, arg1, NULL);

    execv: printf("execv\n");
    execv(pg_path, args);
    
    execvp: printf("execvp\n");
    args[0] = pg_name;
    execvp(pg_name, args);

    execve: printf("execve\n");
    args[3] = "$FILE";
    char* const env[] = {"FILE=we.c"};
    execve(pg_path, args, env);


    printf("Failure!");
    exit(EXIT_FAILURE);
  }
  else {   /* père */
    int codeTerm;
    idFils=wait(&codeTerm);
    if (idFils == -1) {
      perror("wait ");
      exit(2);
    }
    if (WIFEXITED(codeTerm) && codeTerm == 0) {
        return EXIT_SUCCESS;
    } else {
        printf("Commande non correctement éxécutée...\n");
    }
  }
  return EXIT_FAILURE;
}
