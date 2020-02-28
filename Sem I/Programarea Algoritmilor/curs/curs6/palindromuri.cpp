/*
Problme laborator 5

Cuvinte Palindromuri(3p)
*/
#include <iostream>
#include <string.h>
#include <ctype.h>
using namespace std;

int main()
{
    int n;
    char x[101];
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> x;
        bool ok = 1;
        int l = strlen(x);
        for (int j = 0; j < l / 2; j++)
        {
            if (tolower(x[j]) != tolower(x[l - j - 1]))
            {
                ok = 0;
                break;
            }
        }
        if (ok)
            cout << x << " ";
    }
}