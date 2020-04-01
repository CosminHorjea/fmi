#include <iostream>
#include <fstream>
using namespace std;
#define NMAX 1000020

int v[NMAX], f[NMAX], res[NMAX], n;

ifstream fin("ex4Bonus.in");

void CountSortBiti(int p)
{
	int j, aux, i[256] = {0};

	for (int j = 0; j < n; j++)
	{
		i[(v[j] >> (p * 8)) & 255]++;
	}
	for (j = 1; j <= 255; j++)
		i[j] += i[j - 1];
	for (j = n - 1; j >= 0; j--)
	{
		aux = v[j] >> (p * 8) & 255;
		res[i[aux] - 1] = v[j];
		i[aux]--;
	}
	for (j = 0; j < n; j++)
		v[j] = res[j];
}
void radixBiti(int nr)
{
	int i;
	for (i = 0; i < sizeof(int); i++)
	{
		CountSortBiti(i);
	}
}

int main()
{
	fin >> n;
	for (int i = 0; i < n; i++)
	{
		fin >> v[i];
	}
	radixBiti(sizeof(int));
	for (int i = 0; i < n; i++)
		cout << v[i] << " ";
}