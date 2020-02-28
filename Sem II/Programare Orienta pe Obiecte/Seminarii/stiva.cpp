/*
Seminar 1

Program simplu care implementeaza o clasa Stiva

Poate sa adauge sau sa scoata din stiva

*/
#include <iostream>

class Stiva
{
    int *p; //pointer la zona de memorie a stivei
    int size;
    int top;

public:
    Stiva()
    {
        p = new int[5];
        size = 5;
        top = -1;
    };
    Stiva(unsigned int s)
    {
        p = new int[s];
        size = s;
        top = -1;
    }
    Stiva(Stiva &s)
    {
        p = new int[s.size];
        size = s.size;
        top = s.top;
        for (int i = 0; i < size; i++)
            p[i] = s.p[i];
    }
    ~Stiva()
    {
        delete[] p;
        size = 0;
        top = -1;
    }
    void push(int val)
    {
        if (size - 1 == top)
        {
            int *new_zone = new int[size + 3];
            for (int i = 0; i < size; i++)
                new_zone[i] = p[i];
            size += 3;
            delete[] p;
            p = new_zone;
        }
        p[++top] = val;
    }

    int pop()
    {
        if (top == -1)
        {
            return -1; // Teoretic nu e corect, aici ar fi trebuit sa aruncam o eroare;
        }
        return p[top--];
    }
};

int main()
{
    Stiva s(10);
    s.push(2);
    std::cout << s.pop();
}

/*
Exercitiu:
    sa rescriem chestia asta folosind un vector in loc de *p;

    - cred ca e acelasi lucru , doar ca in loc sa declar cu new declar direct p[lungime]
*/