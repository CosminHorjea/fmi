#ifndef _LISTA_H
#define _LISTA_H

#include <limits>
#include "Nod.h"

class Lista
{
	Nod *start, *end;
	unsigned size;
public:
	Lista();
	Lista(int);
	Lista(int, int);
	Lista(Lista&);
	void insertAt(int, int);
	void insert(int);
	void print();
	int get(int);
	unsigned length();
	void remove(int);
	Lista reverse();
	void removeFirst();
	void removeLast();
	bool isEmpty();
	bool has(int);
	bool hasDuplicates();
	~Lista();
};

#endif // !_LISTA_H

