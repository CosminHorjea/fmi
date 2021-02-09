#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void * invers(void *v)
{
    char *sir = (char *)v;
    char *sir_invers;
    sir_invers = (char*) malloc(strlen(sir) + 1);
    int i;
    for (i = 0; i < strlen(sir); i++)
        sir_invers[strlen(sir) - 1 - i] = sir[i];
    sir_invers[strlen(sir)] = '\0';
    return sir_invers;
}

int main(int argc, char **argv){
    pthread_t thread;
    char *result;
    pthread_create(&thread, NULL, invers, argv[1]);
    pthread_join(thread, &result);
    printf("%s", result);
    free(result);
    return 0;
}