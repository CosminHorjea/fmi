#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main()
{
    char s[100];
    int i;
    gets(s);
    for (i = 0; i < 10; i++)
    {
        s[i] = toupper(s[i]);
        s[i] = (s[i] - 'A' + 10) % 26 + 'A';
    }
}