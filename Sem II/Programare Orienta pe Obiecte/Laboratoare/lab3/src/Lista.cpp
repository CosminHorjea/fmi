#include <iostream>
#include "Lista.hpp"
#include "Nod.hpp"

Lista::Lista()
{
    this->start = 0;
    this->end = 0;
    this->size = 0;
}
Lista::Lista(int x)
{
    Nod *new_nod = new Nod(x);
    this->start = new_nod;
    this->end = new_nod;
    this->size = 1;
}

Lista::Lista(int x, int y)
{
    this->size = x;
    Nod *lista = new Nod(y);
    this->start = lista;
    this->end = lista;
    for (int i = 0; i < x - 1; i++)
    {
        Nod *aux = new Nod(y);
        this->end->setNext(aux);
        this->end = aux;
    }
}
Lista::~Lista()
{
    this->size = 0;
    Nod *p = this->start;
    while (p != 0)
    {
        this->start = this->start->getNext();
        delete p;
        p = start;
    }
}

void Lista::insert(int x)
{
    if (size == 0)
    {
        this->start = this->end = new Nod(x);
        ++size;
        return;
    }
    Nod *aux = new Nod(x);
    this->end->setNext(aux);
    this->end = aux;
    ++size;
}

void Lista::insertAt(int x, int i)
{
    if (i >= size)
        insert(x);
    else if (i == 0)
    {
        Nod *newNod = new Nod(x);
        newNod->setNext(this->start);
        this->start = newNod;
        ++size;
    }
    else
    {
        Nod *copie = this->start;
        while (i-- > 0)
            copie = copie->getNext();
        Nod *after = copie->getNext();
        Nod *new_nod = new Nod(x);
        copie->setNext(new_nod);
        new_nod->setNext(after);
        ++size;
    }
}

int Lista::get(int i)
{
    if (i < 0 || i > this->size)
        return INT8_MAX;

    Nod *copie = start;
    while (i-- > 0)
        copie = copie->getNext();
    return copie->getInfo();
}
int Lista::length()
{
    return this->size;
}

void Lista::remove(int i)
{
    if (size <= i)
        throw - 1;
    if (i == 0)
    {
        Nod *p = start;
        start = start->getNext();
        delete p;
        return;
    }
    Nod *copie = start;
    while (i-- > 1)
    {
        copie = copie->getNext();
    }
    Nod *p = copie;
    copie->setNext(copie->getNext()->getNext());
    delete p->getNext();
}

void Lista::afis()
{
    if (size == 0)
        return;
    Nod *copy = this->start;
    while (copy)
    {
        std::cout << copy->getInfo() << " ";
        copy = copy->getNext();
    }
}

Lista Lista::reverse()
{
    if (this->size == 0)
    {
        Lista *l = new Lista();
        return *l;
    }
    Nod *aux = this->start;
    Lista *newLista = new Lista(aux->getInfo());
    aux = aux->getNext();
    while (aux)
    {
        newLista->insertAt(aux->getInfo(), 0);
        aux = aux->getNext();
    }
    return *newLista;
}

void Lista::removeFirst()
{
    if (!size)
        throw - 1;
    Nod *p = this->start;
    start = start->getNext();
    delete p;
    --size;
}
void Lista::removeLast()
{
    Nod *p = this->start;
    while (p->getNext() != this->end)
        p = p->getNext();
    p->setNext(0);
    delete end;
    this->end = p;
}
bool Lista::hasDuplicate()
{
    Nod *i = start;
    while (i->getNext())
    {
        Nod *j = i->getNext();
        while (j->getNext())
        {
            if (i->getInfo() == j->getInfo())
                return true;
            j = j->getNext();
        }
        i = i->getNext();
    }
    return false;
}

bool Lista::has(int val)
{
    Nod *i = start;
    while (i)
    {
        if (i->getInfo() == val)
            return true;
        i = i->getNext();
    }
    return false;
}