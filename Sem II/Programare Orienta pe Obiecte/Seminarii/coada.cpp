#include <iostream>

/*
Coada facuta gen stiva de la seminar

*/

class Coada
{
    int *p;
    int size;
    int left, right;

public:
    Coada()
    {
        p = new int[5];
        size = 5;
        left = right = 0;
    }
    Coada(unsigned int s)
    {
        p = new int[s];
        size = s;
        left = 0;
        right = 0;
    }
    Coada(Coada &c)
    {
        p = new int(c.size);
        size = c.size;
        left = c.left;
        right = c.right;
        for (int i = left; i <= right; i++)
            p[i] = c.p[i];
    }
    void push(int x)
    {
        if (size - 1 == right)
        {
            int *new_zone = new int[size + 3];
            for (int i = left; i < size; i++)
                new_zone[i] = p[i];
            size += 3;
            delete[] p;
            p = new_zone;
        }
        p[right++] = x;
    }
    int pop()
    {
        if (left == right)
        { //coada e vida
            return -1;
        }
        return p[left++];
    }
};

int main()
{
    Coada c(3);
    c.push(1);
    c.push(2);
    c.push(3);
    c.push(4);
    std::cout << c.pop();
    std::cout << c.pop();
    std::cout << c.pop();
    std::cout << c.pop();
    std::cout << c.pop();
}