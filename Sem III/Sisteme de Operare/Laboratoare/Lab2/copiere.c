#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char **argv)
{
  if (argc > 3)
  {
    printf("Comanda utilizata incorect");
    return -1;
  }
  int fisier1 = open(argv[1], O_RDONLY);
  int fisier2 = open(argv[2], O_WRONLY | O_CREAT, 777);

  struct stat info = {0};
  chmod(argv[2], 777);
  stat(argv[1], &info);
  printf("%d\n", info.st_size);
  size_t size = info.st_size;
  char buff[size + 1];
  read(fisier1, buff, size);
  close(fisier1);
  printf("%s\n", buff);
  write(fisier2, buff, size);
  close(fisier2);
}