#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/errno.h>

int main(int argc, char *argv[])
{
  pid_t p = fork();
  if (p < 0)
    return errno;
  if (p == 0)
  {
    int n = atoi(argv[1]);
    printf("%d: ", n);
    while (n != 1)
    {
      printf("%d ", n);
      if (n % 2 == 0)
        n = n / 2;
      else
        n = 3 * n + 1;
    }
    printf("%d\n", n);
  }
  else
  {
    wait(NULL);
    printf("Child %d finished", p);
  }
}