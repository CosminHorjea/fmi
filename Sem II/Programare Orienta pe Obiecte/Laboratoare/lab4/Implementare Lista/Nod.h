#pragma once
#ifndef _NOD_H
#define _NOD_H
#include <iostream>

class Nod {
	int info;
	Nod* next;
public:
	Nod();
	Nod(int, Nod*);
	void setInfo(int);
	void setNext(Nod*);
	int getInfo();
	Nod* getNext();
	// nu este nevoie de destructor
};


#endif // _NOD_H


