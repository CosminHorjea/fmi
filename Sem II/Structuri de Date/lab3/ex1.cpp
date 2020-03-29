#include <iostream>

using namespace std;
#define NMAX 1000020

int minHeap[NMAX]; // asta e tot vectorul cu care reprezint heapul
int top = 0;       // pana unde e un heap in vectorul ala de mai sus
void upHeap(int);  // doar headere pt functii
void downHeap(int);
void add(int val) // cand adaug
{
    minHeap[top] = val; // pun valoarea pe ultima pozitie
    upHeap(top);        // duc valoarea din poz top(care e ultima) in sus
    top++;              // maresc top pt a trece la urmatorul "slot"
}
void upHeap(int poz) //cand duc valoarea in sus
{
    // (poz-1)/2 sunt coord pentru tata, incep de la 0 in vecotr
    while (minHeap[(poz - 1) / 2] > minHeap[poz]) //daca tatal e mai mare decat nodul curent
    {
        //trebuei sa-i schimb
        int aux = minHeap[(poz - 1) / 2];
        minHeap[(poz - 1) / 2] = minHeap[poz];
        minHeap[poz] = aux;
        poz = (poz - 1) / 2; // poz mea este acum pozitia tatalui
        //si fac asa pana tatal(nodul parinte in fine) este mai mic decat fiul
    }
}
int get() // cand vreau sa iau o valoare
{
    if (!top) //verific daca nu e heap-ul gol
        throw - 1;
    int rez = minHeap[0];        //rezultatul e mereu pe prima pozitie
    minHeap[0] = minHeap[--top]; // si valoare pe care o pun in cap acum este ultima din minHeap si scad top
    minHeap[top + 1] = 0;        // fac pozitia aia anterioara 0 pt ca nu mai face parte din heap
    downHeap(0);                 // duc in jos nodul 0 ( ala unde l-am pus pe ultimul)
    return rez;                  //returnez valoarea
}
void downHeap(int poz)
{
    int fiu = poz * 2 + 1;                                // asta e pozitia nodului fiu din stanga
    if (fiu + 1 < top && minHeap[fiu] > minHeap[fiu + 1]) // daca nodul din dreapta e mai mic tho, lucrez cu el
        fiu++;                                            // adaug 1 la fiu
    if (fiu < top && minHeap[poz] > minHeap[fiu])         // daca fiul e mai mic decat pozitia pe care sunt acum
    {
        //trebuie sa-i schimb
        int aux = minHeap[fiu];
        minHeap[fiu] = minHeap[poz];
        minHeap[poz] = aux;
        downHeap(fiu); // trec pe pozitia urmatorului nod
    }
}

int main()
{
    int v[7] = {43, 22, 54, 10, 32, 41, 15};
    for (int i = 0; i < 7; i++)
    {
        add(v[i]);
    }

    for (int i = 0; i < 7; i++)
    {
        cout << get() << ",";
        // for (int i = 0; i < 7; i++)
        // {
        //     cout << minHeap[i] << " ";
        // }
        // cout << endl;
    }
}