#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#define MAX_RESOURCES 5

int available_resources = MAX_RESOURCES;

static pthread_mutex_t mtx;

int decrease_count(int count)
{

    pthread_mutex_lock(&mtx);
    if (available_resources < count)
    {
        pthread_mutex_unlock(&mtx);
        return -1;
    }
    else
    {
        available_resources -= count;
        printf("Got %d resources %d remaining\n", count, available_resources);
    }
    pthread_mutex_unlock(&mtx);
    return 0;
}

int increase_count(int count)
{
    pthread_mutex_lock(&mtx);
    available_resources += count;
    printf("Released %d resources %d remaining\n", count, available_resources);
    pthread_mutex_unlock(&mtx);
    return 0;
}

void *f(void *args)
{
    int resources = (int) args;
    while(decrease_count(resources)==-1);
    increase_count(resources);

    return NULL;
}

int main()
{
    pthread_mutex_init(&mtx, NULL);

    printf("MAX_RESOURCES %d \n", MAX_RESOURCES);

    pthread_t p[10];
    for (int i=0;i<10;++i){
        
        pthread_create(&p[i],NULL,f,i%2+1);
    }
    for (int i=0;i<5;++i){
        pthread_join(p[i],NULL);
    }

    pthread_mutex_destroy(&mtx);
}