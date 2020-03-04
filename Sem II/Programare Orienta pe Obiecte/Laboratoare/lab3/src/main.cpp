#include <iostream>
#include "Lista.hpp"

int main()
{
    Lista l;
    for (int i = 0; i < 10; i++)
        l.insert(i);
    // l.reverse().afis();
    // l.removeLast();
    std::cout << l.has(3) << std::endl;
    l.afis();
}