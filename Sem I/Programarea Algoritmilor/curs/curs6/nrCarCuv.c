#include <stdio.h>
#include <string.h>

int main()
{
    char s[100], voc[21] = "AEIOUaeiou";
    gets(s);
    int nrChr = 0, nrVoc = 0, nrCons = 0, nrCuv = 0;
    for (int i = 0; i < strlen(s); i++)
    {
        printf("%c", s[i]);
    }
}