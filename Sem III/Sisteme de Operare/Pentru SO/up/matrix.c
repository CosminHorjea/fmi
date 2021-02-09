#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

struct args
{
  int len;
  int *row;
  int *col;
};

void *calcul(void *arg)
{
  struct args *argumente = arg;
  int *sum = (int *)malloc(sizeof(int));
  for (int i = 0; i < argumente->len; i++)
  {
    *sum += argumente->row[i] * argumente->col[i];
  }
  return sum;
}
int main()
{
  int **A;
  int **B;
  int n1, m1, n2, m2;
  // printf("Dimensiune matrice 1:\n");
  scanf("%d %d ", &n1, &m1);
  // printf("Dimensiune matrice 2:\n");
  scanf("%d %d", &n2, &m2);
  if (m1 != n2)
  {
    perror("Dimensiuni incorecte");
    return errno;
  }
  A = (int **)malloc(sizeof(int *) * n1);
  for (int i = 0; i < n1; i++)
  {
    A[i] = (int *)malloc(sizeof(int) * m1);
    for (int j = 0; j < m1; j++)
    {
      scanf("%d", &A[i][j]);
    }
  }
  B = (int **)malloc(sizeof(int *) * n2);
  for (int i = 0; i < n2; i++)
  {
    B[i] = (int *)malloc(sizeof(int) * m2);
    for (int j = 0; j < m2; j++)
    {
      scanf("%d", &B[i][j]);
    }
  }
  pthread_t threads[n1 * m2 + 1];
  int nr = 0;
  for (int i = 0; i < n1; i++)
  {
    for (int j = 0; j < m2; j++)
    {
      struct args *arg = (struct args *)malloc(sizeof(struct args));
      arg->len = n2;
      arg->row = A[i];
      arg->col = B[j];
      if (pthread_create(&threads[nr++], NULL, calcul, arg))
      {
        perror("Eroare la creearea thredurilor");
        return errno;
      }
    }
  }
  int **R;
  R = (int **)(int **)malloc(sizeof(int *) * n1);
  nr = 0;
  for (int i = 0; i < n1; i++)
  {
    R[i] = (int *)malloc(sizeof(int) * m2);
    for (int j = 0; j < m2; j++)
    {
      int *result = malloc(sizeof(int));
      if (pthread_join(threads[nr++], &result))
      {
        perror("Eroare la oprirea thredurilor");
        return errno;
      }
      R[i][j] = *result;
    }
  }
  for (int i = 0; i < n1; i++)
  {
    for (int j = 0; j < m2; j++)
    {
      printf("%d ", R[i][j]);
    }
    printf("\n");
  }
}