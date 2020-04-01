#include <iostream>
#include <fstream>
using namespace std;
#define NMAX 1000020

int v[NMAX], f[NMAX], res[NMAX];

ifstream fin("ex3.in");
ofstream fout("ex3.out");
int main()
{
	int n, i, k;
	fin >> n >> k; // vector de lungine n si elemente pana in valoarea k
	for (i = 0; i < n; i++)
	{
		fin >> v[i]; // citesc valori
		f[v[i]]++;	 //le incrementez frecventa
	}
	fin.close();
	for (i = 1; i <= k; i++)
		f[i] += f[i - 1]; // adun elementul dinaintea elementului la i-ul curent
						  // astfel stiu cate elemente sunt mai mici decat o valoare din vecotr

	for (i = 0; i < n; ++i) // pr fiecare numar din v[i]
	{
		res[f[v[i]] - 1] = v[i]; // in vectorul rezultatnt pun numarul pe pozitia numerelor mai mici decat el -1(incepem de la 0)
		f[v[i]]--;				 //scad frecventa elementului
	}
	for (i = 0; i < n; i++)
	{
		fout << res[i] << " ";
	}
	fout.close();
}