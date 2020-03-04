#pragma once

class Nod
{
    int info;
    Nod *next;

public:
    Nod();
    Nod(int);
    Nod(int, Nod *);
    ~Nod();
    void setInfo(int);
    int getInfo();
    void setNext(Nod *);
    Nod *getNext();
};
