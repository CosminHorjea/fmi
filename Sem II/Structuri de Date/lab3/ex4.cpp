#include <iostream>
#include <fstream>
using namespace std;
#define NMAX 1000020

int v[NMAX], f[NMAX], res[NMAX], n;

ifstream fin("ex4.in");

int cifre(int n)
{
    if (n)
        return 1 + cifre(n / 10);
}
void CountSort(int p)
{
    int j, aux, i[10] = {0};
    for (j = 0; j < n; j++)
    {
        aux = (v[j] / p) % 10;
        i[aux]++;
    }
    for (j = 1; j <= 9; j++)
        i[j] += i[j - 1];
    for (j = n - 1; j >= 0; j--)
    {
        aux = (v[j] / p) % 10;
        res[i[aux] - 1] = v[j];
        i[aux]--;
    }
    for (j = 0; j < n; j++)
        v[j] = res[j];
}
void radix(int nr)
{
    int i, p = 1;
    for (i = 0; i < nr; i++)
    {
        CountSort(p);
        p *= 10;
    }
}

int main()
{
    int nr = 0, aux;
    fin >> n;
    for (int i = 0; i < n; i++)
    {
        fin >> v[i];
        aux = cifre(v[i]);
        if (nr < aux)
            nr = aux;
    }
    radix(nr); //nr-nr maxim de cifre;
    for (int i = 0; i < n; i++)
        cout << v[i] << " ";
}