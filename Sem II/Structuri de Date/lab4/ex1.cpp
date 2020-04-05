/*
	Tema 4 : Arbori Binari de Cutare

	1. (3p) Imnplementati arbore binar de cautare cu operatiile:

	-> inserarea unei chei x
	-> cautarea unei chei x (zice 0/1)
	-> afisarea cheilor din arbore dupa SRD (inordine) si RSD (preordine)
	-> (+3p) stergerea unei chei x (o aparitie) cu pastrarea proprietatii de arbor binar de cautare
*/
#include <iostream>

using namespace std;

struct arbore
{
	int info;
	arbore *stang, *drept;
} * radacina;
void insert(int val)
{
	arbore *aux = radacina;
	arbore *last = aux;

	while (aux)
	{
		if (val < aux->info)
		{
			last = aux;
			aux = aux->stang;
		}
		else if (val > aux->info)
		{
			last = aux;
			aux = aux->drept;
		}
	}
	arbore *p = new arbore();
	p->info = val;
	if (radacina == 0)
	{
		radacina = p;
		return;
	}
	if (last->info < val)
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
void RSD(arbore *aux)
{
	if (aux)
	{
		cout << aux->info << " ";
		RSD(aux->stang);
		RSD(aux->drept);
	}
}
bool search(int val)
{
	arbore *aux = radacina;
	while (aux)
	{
		if (aux->info == val)
		{
			return true;
		}
		if (aux->info < val)
		{
			aux = aux->drept;
		}
		else
		{
			aux = aux->stang;
		}
	}
	return false;
}
void remove(int val)
{
	if (!search(val))
		throw - 1;
	arbore *aux = radacina;
	arbore *parent = aux;
	while (aux)
	{
		if (aux->info > val)
		{
			parent = aux;
			aux = aux->stang;
		}
		else if (aux->info < val)
		{
			parent = aux;
			aux = aux->drept;
		}
		else
		{
			// they are equal
			if (!aux->drept && !aux->stang)
			{
				// daca nodul este frunza
				if (parent->stang == aux)
					parent->stang = nullptr;
				else
					parent->drept = nullptr;
				delete aux;
			}
			else if (!aux->stang)
			{
				//daca are doar fiul drept
				if (parent->stang == aux)
					parent->stang = aux->drept;
				else
					parent->drept = aux->drept;
				delete aux;
			}
			else if (!aux->drept)
			{
				//daca are doar fiul stang
				if (parent->stang == aux)
					parent->stang = aux->stang;
				else
					parent->drept = aux->stang;
				delete aux;
			}
			else
			{
				//am ajuns in cazul in care avem abii fii
				arbore *temp = aux;
				temp = aux->drept;
				while (temp->stang)
				{
					temp = temp->stang;
				}
				int value = temp->info;
				remove(temp->info);
				aux->info = value;
			}
			return;
		}
	}
	return;
}
int main()
{
	int values[9] = {6, 4, 9, 2, 1, 5, 3, 7, 8};
	for (int i = 0; i < 9; i++)
		insert(values[i]);
	SRD(radacina);
	cout << endl;
	RSD(radacina);
	cout << endl;
	cout << search(7) << endl;
	cout << search(17) << endl;
	remove(4);
	SRD(radacina);
}