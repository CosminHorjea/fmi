#include <iostream>
#include <set>
#include <bits/stdc++.h>
// #define INT_MAX 2147483647 // nu stiu de unde iau INT_MAX default din C++
using namespace std;

class Nod
{
    int info;
    Nod *next;

public:
    Nod()
    {
        info = 0;
        next = nullptr;
    }
    Nod(int val)
    {
        info = val;
        next = nullptr;
    }
    Nod(int val, Nod *n)
    {
        info = val;
        next = n;
    }
    ~Nod()
    {
        info = 0;
        next = 0;
    }
    void setInfo(int val)
    {
        info = val;
    }
    int getInfo()
    {
        return info;
    }

    void setNext(Nod *x)
    {
        next = x;
    }
    Nod *getNext()
    {
        return next;
    }
};

class Lista
{
    Nod *start, *end;
    unsigned int size;

public:
    Lista()
    {
        start = end = 0;
        size = 0;
    }
    Lista(int x)
    {
        Nod *new_nod = new Nod(x);
        start = new_nod;
        end = new_nod;
        size = 1;
    }
    Lista(int x, int y)
    {
        size = x;
        Nod *lista = new Nod(y);
        start = end = lista;
        for (int i = 0; i < x - 1; i++)
        {
            Nod *aux = new Nod(y);
            end->setNext(aux);
            end = aux;
        }
    }
    ~Lista()
    {
        size = 0;
        Nod *p = start;
        while (p != 0)
        {
            start = start->getNext();
            delete p;
            p = start;
        }
        cout << endl;
    }
    void insert(int x)
    {
        if (size == 0)
        {
            start = end = new Nod(x);
            ++size;
            return;
        }
        Nod *aux = new Nod(x);
        end->setNext(aux);
        end = aux;
        ++size;
    }
    void insertAt(int x, int i) // val x la pozitia i
    {
        if (i >= size)
            insert(x);
        else if (i == 0)
        {
            Nod *newNod = new Nod(x);
            newNod->setNext(start);
            start = newNod;
            size += 1;
        }
        else
        {
            // int contor = 0;
            Nod *copie = start;
            while (i-- > 1)
            {
                copie = copie->getNext();
            }
            Nod *after = copie->getNext();
            Nod *new_nod = new Nod(x);
            copie->setNext(new_nod);
            new_nod->setNext(after);
            size += 1;
        }
    }
    int get(int i)
    {
        if (i < 0 || i > size)
        {
            return INT_MAX;
        }
        Nod *copie = start;
        while (i-- > 0)
        {
            copie = copie->getNext();
        }
        return copie->getInfo();
    }
    int length()
    {
        return size;
    }
    void remove(int i)
    {
        if (size <= i)
        {
            // cout << "i prea mare";
            throw - 1;
        }
        size--;
        if (i == 0)
        {
            Nod *p = start;
            start = start->getNext();
            // free(p); // de ce merege cu free si nu cu delete ?????
            // start = end = nullptr;
            // start = 0;
            return;
        }
        Nod *copie = start;
        while (i-- > 1)
        {
            copie = copie->getNext();
        }
        // delete copie->getNext();
        copie->setNext(copie->getNext()->getNext());
    }
    void afis()
    {
        if (size == 0)
        {
            cout << " \n";
            return;
        }
        Nod *copy = start;
        while (copy->getNext())
        {
            cout << copy->getInfo() << " ";
            copy = copy->getNext();
        }
        cout << copy->getInfo() << endl;
    }

    Lista reverese()
    {
        if (size == 0)
        {
            Lista *l = new Lista();
            return *l;
        }
        Nod *aux = start;
        // aux = start;
        Lista *newLista = new Lista(aux->getInfo());
        aux = aux->getNext();
        while (aux != nullptr)
        {
            newLista->insertAt(aux->getInfo(), 0);
            aux = aux->getNext();
        }
        return *newLista;
    }

    void removeFirst()
    {
        // cout << size;
        if (size == 0)
        {
            cout << "Lista vida";
            throw - 1;
        }
        Nod *p = start;
        start = start->getNext();
        delete p;
        // free(p);
        // start = p;
        size--;
    }
    void removeLast()
    {
        // cout << size;
        if (size == 0)
        {
            cout << "Lista vida";
            throw - 1;
        }
        Nod *aux = start;
        if (aux == end)
        {
            // free(end);
            delete end;
            start = end = 0;
            size = 0;
            return;
        }
        while (aux->getNext()->getNext())
        {
            aux = aux->getNext();
        }
        Nod *p = end;
        end = aux;
        // free(p);
        delete p;
        aux->setNext(nullptr);
        // free(aux->getNext());
        // end = aux;
        size--;
    }

    bool hasDuplicate()
    {
        set<int> aux;
        Nod *p = start;
        while (p)
        {
            if (*aux.find(p->getInfo()) == p->getInfo())
                return true;
            aux.insert(p->getInfo());
            p = p->getNext();
        }
        return false;
    }
    bool has(int x)
    {
        if (this->isEmpty())
            return false;
        Nod *p = start;
        while (p)
        {
            if (p->getInfo() == x)
                return true;
            p = p->getNext();
        }
        return false;
    }
    bool isEmpty()
    {
        return (size == 0);
    }
};
void f(Lista &l, int x) // daca las definitia cum e in ex, modific o copie, nu lista a din main direct, deci pun &l (adresa lui l)
{
    l.afis();
    l.insert(x);
}

int main()
{
    Lista a, l;
    // a.insert(1);
    // a.afis();
    for (int i = 0; i < 5; ++i)
        a.insert(i + 1);
    a.afis();
    a.insert(4);
    a.afis();
    cout << a.get(4) << endl;
    a.removeLast();
    a.afis();
    a.remove(0);
    a.afis();
    a.reverese().afis();
}