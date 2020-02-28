#include <stdio.h>

int main()
{
    char s[100] = "Ana are mere\n", n;
    int i = 0;
    // printf("%s", s);
    // printf("Doriti o noua executie?\n");
    // n = getchar();
    // while (n != 'N')
    // {
    //     // printf("n este %i\n", n);
    //     if (n == 'D')
    //         printf("%s", s);
    //     if (n != '\n')
    //         printf("Doriti o noua executie?\n");
    //     n = getchar();
    // }
    for (i = 5; i >= 0; i--)
    {
        printf("%c", s[i]);
    }
}