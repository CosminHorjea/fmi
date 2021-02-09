#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/errno.h>

int main()
{
  pid_t pid = fork();
  if (pid < 0)
    return errno;
  if (pid == 0)
  {
    // printf("Me Child: %d",getpid());
    // printf("Me PAPA: %d",getppid());
    char *argv[] = {"ls", NULL};
    execve("/bin/ls", argv, NULL);
  }
  else
  {
    printf("My PID=%d, Child PID=%d.\n", getpid(), pid);
    wait(NULL);
    printf("Child %d finished.\n", pid);
  }
  return 0;
}