#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#define NTHRS 5

pthread_mutex_t mtx;
sem_t sem;
int n = NTHRS;
void barrier_point()
{

  n--;
  if (!n)
    for (int i = 0; i < NTHRS; i++)
      sem_post(&sem);
  pthread_mutex_unlock(&mtx);
  sem_wait(&sem);
}

void *tfun(void *v)
{

  int *tid = (int *)v;
  printf("%d reached the barrier \n", *tid);
  pthread_mutex_lock(&mtx);
  barrier_point();
  printf("%d passed the barrier \n", *tid);
  free(tid);
  return NULL;
}

int main()
{
  pthread_t t[NTHRS + 1];
  sem_init(&sem, 0, 0);
  pthread_mutex_init(&mtx, NULL);
  printf("NTHRS = %d\n", NTHRS);
  for (int i = 0; i < NTHRS; i++)
  {
    int *arg = malloc(sizeof(int));
    *arg = i;
    pthread_create(&t[i], NULL, tfun, arg);
  }
  for (int i = 0; i < NTHRS; i++)
  {
    pthread_join(t[i], NULL);
  }
  sem_destroy(&sem);
  pthread_mutex_destroy(&mtx);
}