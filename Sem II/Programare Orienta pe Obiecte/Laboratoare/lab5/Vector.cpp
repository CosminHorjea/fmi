#include <iostream>
#include "Fraction.h"
#include "Vector.h"

Vector::Vector()
{
    this->size = 10;
    this->top = 0;
    elements = new Fraction[10];
}
Vector::~Vector()
{
    this->size = 0;
    this->top = -1;
    delete[] elements;
}
void Vector::push(Fraction f)
{
    if (top == size)
    {
        Fraction *new_elems = new Fraction[size + 10];
        for (int i = 0; i < size; i++)
        {
            new_elems[i] = elements[i];
        }
        size += 10;
        delete[] elements;
        elements = new_elems;
    }
    elements[top++] = f;
}
void Vector::remove(unsigned int index)
{
    if (size == 0)
        throw - 1;
    for (int i = index; i < size; i++)
        elements[i] = elements[i + 1];
    top--;
}
bool Vector::contains(Fraction f)
{
    for (int i = 0; i < size; i++)
        if (elements[i] == f)
            return true;
    return false;
}

Vector &Vector::operator=(const Vector &v)
{
    this->size = v.size;
    this->top = v.top;
    copy(v.elements, v.elements + size, this->elements); //??? Does it work
}

Vector Vector::operator+(const Vector &v)
{
    Vector *result = new Vector();
    int i;
    int minTop = (v.top < this->top) ? v.top : this->top;
    for (i = 0; i < minTop; i++)
    {
        result->push(this->elements[i] + v.elements[i]);
    }
    if (minTop != this->top)
    {
        while (i < this->top)
        {
            result->push(this->elements[i]);
            i++;
        }
    }
    else
    {
        while (i < v.top)
        {
            result->push(v.elements[i]);
            i++;
        }
    }
    return *result;
}
Vector Vector::operator*(const int scalar)
{
    Vector *res = new Vector();
    for (int i = 0; i < top; i++)
    {
        res->push(elements[i] * scalar);
    }
    return *res;
}
Fraction Vector::operator[](const unsigned int i)
{
    return elements[i];
}
ostream &operator<<(ostream &out, const Vector &v)
{
    for (int i = 0; i < v.top; i++)
    {
        out << v.elements[i] << " ";
    }
    return out;
}
istream &operator>>(istream &input, Vector &v)
{
    int n;
    Fraction f;
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> f;
        v.push(f);
    }
    return input;
}