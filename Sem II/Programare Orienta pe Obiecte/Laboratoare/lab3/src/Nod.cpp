#include <iostream>
#include "Lista.hpp"
#include "Nod.hpp"

Nod::Nod()
{
    this->info = 0;
    this->next = 0;
}
Nod::Nod(int info)
{
    this->info = info;
    this->next = 0;
}
Nod::Nod(int info, Nod *next)
{
    this->info = info;
    this->next = next;
}
Nod::~Nod()
{
    this->info = 0;
    this->next = 0;
}
void Nod::setInfo(int info)
{
    this->info = info;
}
int Nod::getInfo()
{
    return this->info;
}
void Nod::setNext(Nod *next)
{
    this->next = next;
}
Nod *Nod::getNext()
{
    return this->next;
}