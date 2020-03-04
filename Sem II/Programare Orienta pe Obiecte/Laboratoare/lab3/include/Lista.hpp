#pragma once

#include "Nod.hpp"

class Lista
{
    Nod *start, *end;
    unsigned int size;

public:
    Lista();
    Lista(int);
    Lista(int, int);
    ~Lista();
    void insert(int);
    void insertAt(int, int);
    int get(int);
    int length();
    void remove(int);
    void afis();
    Lista reverse();
    void removeFirst();
    void removeLast();
    bool hasDuplicate();
    bool has(int);

    friend void f(Lista &, int);
};
