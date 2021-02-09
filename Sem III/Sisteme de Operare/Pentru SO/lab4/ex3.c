#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/errno.h>

int main(int argc, char *argv[])
{
  printf("Starting parent %d\n", getpid());
  pid_t pids[argc];
  // printf("argc: %d",argc);
  for (int i = 0; i < argc; i++)
  {
    if ((pids[i] = fork()) < 0)
      return -1;
    else if (pids[i] == 0)
    {
      int n = atoi(argv[i + 1]);
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
      printf("Done Parent: %d Me: %d\n", getppid(), getpid());
      exit(0);
    }
  }
  pid_t pid;
  while (argc > 0)
  {
    pid = wait(NULL);
    --argc;
  }
  printf("Done Parent: %d Me: %d\n", getppid(), getpid());
}