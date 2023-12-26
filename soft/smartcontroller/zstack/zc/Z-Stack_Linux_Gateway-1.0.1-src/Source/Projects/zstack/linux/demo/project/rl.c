#include <stdio.h>
#include <stdlib.h>

int readAndProcess()
{
    int rc = 1;
    char *buffer = NULL;
    int read;
    unsigned int len;
    read = getline(&buffer, &len, stdin);
    if (-1 != read) {
       fprintf(stderr, "%s\n", buffer);
       if(strcmp("X\n", buffer) == 0) {
          fprintf(stderr, "X Restarting true\n");
       }
       else 
       if(strcmp("x\n", buffer) == 0) {
          fprintf(stderr, "X Restarting false\n");
       }
       else
       if(strcmp("q\n", buffer) == 0) {
          fprintf(stderr, "c Quitting.\n");
          rc = 0;
       }
    }
    free(buffer);
    return rc;
}

int main()
{
    while(readAndProcess()) {
    }
    return 0;
}
