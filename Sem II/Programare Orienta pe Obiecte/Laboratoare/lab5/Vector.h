#pragma once
#include "Fraction.h"

using namespace std;

class Vector
{
    int size;
    int top;
    Fraction *elements;

public:
    Vector();
    ~Vector();
    void push(Fraction);
    void remove(unsigned int);
    bool contains(Fraction);
    Vector &operator=(const Vector &);
    Vector operator+(const Vector &);
    Vector operator-(const Vector &);
    Vector operator*(const int);
    Fraction operator[](const unsigned int);
    friend ostream &operator<<(ostream &, const Vector &);
    friend istream &operator>>(istream &, Vector &);
};