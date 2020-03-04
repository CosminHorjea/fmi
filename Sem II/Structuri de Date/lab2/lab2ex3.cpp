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

int peek()
{
    if (pointer_global_varf)
        return pointer_global_varf->info;
    return 0;
}

int main()
{
    int v[100], n;
    cin >> n;
    for (int i = 1; i <= n; i++)
        cin >> v[i];
    for (int i = 1; i <= n; i++)
    {
        if (v[i] == peek())
            pop();
        else
            push(v[i]);
    }
    if (peek())
    {
        cout << "Configuratie gresita";
    }
    else
    {
        cout << "Configuratie acceptata";
    }
}