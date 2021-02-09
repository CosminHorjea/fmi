#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/errno.h>
#include <sys/mman.h>
#include <sys/wait.h>
#define pg_sz getpagesize()

char* collatz(char* shm_ptr,int n){
    shm_ptr += sprintf(shm_ptr, "%d : %d ", n, n);
      while (n != 1)
      {
        if (n % 2)
          n = n * 3 + 1;
        else
          n /= 2;
        shm_ptr += sprintf(shm_ptr, "%d ", n);
      }
      return shm_ptr;
}

int main(int argc, char *argv[])
{
  printf("Starting Parent :%d \n", getpid());

  char *shm_name = "collatz";
  int shm_fd = shm_open(shm_name, O_RDWR | O_CREAT, 600);
  if (shm_fd < 0)
  {
    perror("Eroare la crearea memoriei partajate");
    shm_unlink(shm_name);
    return errno;
  }
  size_t shm_size = pg_sz * argc;
  if (ftruncate(shm_fd, shm_size) == -1)
  {
    perror("Eroare la alocarea memoriei");
    shm_unlink(shm_name);
    return errno;
  }
  char *shm_ptr;
  for (int i = 1; i < argc; i++)
  {
    shm_ptr = mmap(0, pg_sz, PROT_WRITE, MAP_SHARED, shm_fd, (i - 1) * pg_sz);
    if (shm_ptr == MAP_FAILED)
    {
      perror("Eroare la impartirea memoriei");
      shm_unlink(shm_name);
      return errno;
    }
    pid_t pid = fork();
    if (pid < 0)
    {
      perror("Nu am putut creea procesul");
      return errno;
    }
    else if (pid == 0)
    {
      int n = atoi(argv[i]);
      shm_ptr=collatz(shm_ptr,n);
      printf("Done Parent %d Me %d \n", getppid(), getpid());
      return 0;
    }

    munmap(shm_ptr, pg_sz);
  }
  while (wait(NULL) > 0)
    ;

  for (int i = 1; i < argc; i++)
  {
    shm_ptr = mmap(0, pg_sz, PROT_READ, MAP_SHARED, shm_fd, (i - 1) * pg_sz);
    printf("%s \n", (char *)shm_ptr);
    munmap(shm_ptr, pg_sz);
  }

  shm_unlink(shm_name);
  printf("Done Parent %d Me %d \n", getppid(), getpid());
  return 0;
}