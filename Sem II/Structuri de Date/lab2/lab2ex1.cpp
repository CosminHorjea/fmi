#include <iostream>

using namespace std;

struct stiva
{
    int info;
    stiva *next;
} * pointer_global_varf;

void push(int val)
{
    stiva *new_stiva = new stiva;
    new_stiva->info = val;
    new_stiva->next = pointer_global_varf;
    pointer_global_varf = new_stiva;
}

int pop()
{
    if (pointer_global_varf)
    {
        int val = pointer_global_varf->info;
        stiva *aux = pointer_global_varf;
        pointer_global_varf = pointer_global_varf->next;
        delete aux;
        return val;
    }
    throw - 1;
}

int main()
{
    push(1);
    cout << pop();
    push(2);
    push(3);
    cout << pop();
    cout << pop();
}