/*
Probleme laborator 5

Cuvinte Speciale

*/

#include <iostream>
#include <cstring>

using namespace std;

int main()
{
    int n, max = 0;
    char x[20], voc[11] = "AEIOUaeiou", cuvMax[20];
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> x;
        int vocale = 0;
        for (int j = 0; j < strlen(x); j++)
        {
            if (strchr(voc, x[j]))
                vocale++;
        }
        if (vocale % 2)
            if (strlen(x) > max)
            {
                strcpy(cuvMax, x);
                max = strlen(x);
            }
    }
    cout << cuvMax;
}