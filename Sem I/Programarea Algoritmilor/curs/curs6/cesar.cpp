#include <stdio.h>
#include <cctype>
#include <string.h>

int main()
{
    char s[100] = "Ana are mere";
    for (int i = 0; i < strlen(s); i++)
    {
        if (s[i] != ' ')
            if (isupper(s[i]))
                s[i] = (s[i] - 'A' + 10) % 26 + 'A';
            else
                s[i] = (s[i] - 'a' + 10) % 26 + 'a';
    }
    printf("%s", s);
}