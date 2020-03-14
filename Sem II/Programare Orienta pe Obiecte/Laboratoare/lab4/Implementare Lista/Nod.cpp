#include "Nod.h"

Nod::Nod()
{
	info = 0;
	next = NULL;
}

Nod::Nod(int i, Nod* n) {
	info = i;
	next = n;
}

void Nod::setInfo(int i) {
	info = i;
}

void Nod::setNext(Nod* n) {
	next = n;
}

int Nod::getInfo() {
	return info;
}

Nod* Nod::getNext() {
	return next;
}