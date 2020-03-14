#include "Lista.h"

Lista::Lista() {
	start = end = NULL;
	size = 0;
}

Lista::Lista(int x)
{
	start = end = new Nod(x, NULL);
	size = 1;
}

Lista::Lista(int x, int y) {
	start = end = NULL;
	for (int i = 0; i < x; i++) {
		insert(y);
	}
}

Lista::Lista(Lista& l) {
	start = end = NULL;
	size = 0;
	Nod* p = l.start;
	while (p != NULL) {
		insert(p->getInfo());
		p = p->getNext();
	}
}

void Lista::insert(int x) {
	insertAt(x, size + 1);
}

void Lista::print() {
	Nod *p = start;
	while (p != NULL) {
		std::cout << p->getInfo() << " ";
		p = p->getNext();
	}
	std::cout << std::endl;
}

void Lista::insertAt(int x, int i) {
	if (start == NULL) {
		start = end = new Nod(x, NULL);
		size = 1;
		return;
	}
	Nod* p = new Nod(x, NULL);
	if (i == 0) {
		p->setNext(start);
		start = p;
		return;
	}
	if (i < 0 || i >= size) {
		end->setNext(p);
		end = p;
		size++;
		return;
	}
	Nod* o = start;
	for (int j = i; j > 1; j--) {
		o = o->getNext();
	}
	p->setNext(o->getNext());
	o->setNext(p);
	size++;
}

int Lista::get(int i) {
	if (i < 0 || i >= size) {
		return INT_MAX;
	}
	Nod* p = start;
	for (int j = i; j > 0; j--) {
		p = p->getNext();
	}
	return p->getInfo();
}

unsigned Lista::length() {
	return size;
}

void Lista::remove(int i) {
	if (i < 0 || i >= size) {
		return;
	}
	Nod* p = start;
	if (i == 0) {
		if (size == 1 || size == 0) {
			end = start = NULL;
		}
		else {
			start = start->getNext();
			delete p;
		}
	}
	else {
		for (int j = i; j > 1; j--) {
			p = p->getNext();
		}
		Nod* o = p->getNext();
		p->setNext(o->getNext());
		delete o;
	}
	size--;
}

Lista::~Lista()
{
	Nod *p = start, *o;
	while (p != NULL) {
		o = p;
		p = p->getNext();
		delete o;
	}
	start = end = NULL;
	size = 0;
}

Lista Lista::reverse() {
	Lista l;
	Nod *p = start;
	while (p != NULL) {
		l.insertAt(p->getInfo(), 0);
		p = p->getNext();
	}
	return l;
}

void Lista::removeFirst() {
	remove(0);
}

void Lista::removeLast() {
	remove(size - 1);
}

bool Lista::isEmpty() {
	if (size == 0) {
		return true;
	}
	return false;
}

bool Lista::has(int x) {
	Nod *p = start;
	while (p != NULL) {
		if (p->getInfo() == x) {
			return true;
		}
		p = p->getNext();
	}
	return false;
}

bool Lista::hasDuplicates() {
	Nod *p = start;
	while (p != NULL) {
		Nod *o = start;
		while (o != NULL) {
			if (o != p && o->getInfo() == p->getInfo()) {
				return true;
			}
			o = o->getNext();
		}
		p = p->getNext();
	}
	return false;
}