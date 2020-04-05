/*
	2. (1p) Folositi un arbore binar de cautare ca sa sortati n siruri de caractere. 
	Puteti folosi strcmp din string.h pentru comparare lexicografica intre siruri de caractere.
*/
#include <iostream>
#include <string.h>

using namespace std;

struct arbore
{
	string info;
	arbore *stang, *drept;
} * radacina;
void insert(string sir)
{
	arbore *aux = radacina;
	arbore *last = aux;

	while (aux)
	{
		if (strcmp(sir.c_str(), aux->info.c_str()) < 0)
		{
			last = aux;
			aux = aux->stang;
		}
		else if (strcmp(sir.c_str(), aux->info.c_str()) > 0)
		{
			last = aux;
			aux = aux->drept;
		}
	}
	arbore *p = new arbore();
	p->info = sir;
	if (radacina == 0)
	{
		radacina = p;
		return;
	}
	if (last->info < sir)
	{
		last->drept = p;
	}
	else
	{
		last->stang = p;
	}
}
void SRD(arbore *aux)
{
	if (aux)
	{
		SRD(aux->stang);
		cout << aux->info << " ";
		SRD(aux->drept);
	}
}

int main()
{
	string values[4] = {"a", "c", "d", "b"};
	for (int i = 0; i < 4; i++)
		insert(values[i]);
	SRD(radacina);
	cout << endl;
}