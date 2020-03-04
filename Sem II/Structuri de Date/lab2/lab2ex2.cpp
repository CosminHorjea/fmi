#include <iostream>

using namespace std;

struct coada
{
    int info;
    coada *prev, *next;
} * pointer_global_prim_element, *pointer_global_ultim_element;

void push_left(int val)
{
    coada *aux = new coada;
    aux->info = val;
    aux->next = pointer_global_prim_element;
    aux->prev = 0;
    if (pointer_global_prim_element)
        pointer_global_prim_element->prev = aux;
    else
        pointer_global_ultim_element = aux;
    pointer_global_prim_element = aux;
}
void push_right(int val)
{
    coada *aux = new coada;
    aux->info = val;
    aux->next = 0;
    aux->prev = pointer_global_ultim_element;
    if (pointer_global_ultim_element)
        pointer_global_ultim_element->next = aux;
    else
        pointer_global_prim_element = aux;
    pointer_global_ultim_element = aux;
}

int pop_left()
{
    if (pointer_global_prim_element)
    {
        coada *aux = pointer_global_prim_element;
        int val = aux->info;
        pointer_global_prim_element = pointer_global_prim_element->next;
        if (pointer_global_prim_element)
            pointer_global_prim_element->prev = 0;
        else
            pointer_global_ultim_element = 0;
        delete aux;
        return val;
    }
    throw - 1;
}

int pop_right()
{
    if (pointer_global_ultim_element)
    {
        coada *aux = pointer_global_ultim_element;
        int val = aux->info;
        pointer_global_ultim_element = pointer_global_ultim_element->prev;
        if (pointer_global_ultim_element)
            pointer_global_ultim_element->next = 0;
        else
            pointer_global_prim_element = 0;
        delete aux;
        return val;
    }
    throw - 1;
}

int main()
{
    push_left(1);
    push_right(2);
    cout << pop_right();
    cout << pop_left() << endl;
    push_right(3);
    cout << pop_right();
}
