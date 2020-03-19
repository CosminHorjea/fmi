#include <iostream>
#include "Fraction.h"

Fraction::Fraction()
{
    n = m = 0;
}
Fraction::Fraction(int n, int m)
{
    // if (m == 0)
    // {
    //     throw - 1;
    // }
    this->n = n;
    this->m = m;
}
Fraction &Fraction::operator=(const Fraction &f)
{
    if (this == &f)
    {
        return *this;
    }
    this->n = f.n;
    this->m = f.m;
    return *this;
}
Fraction Fraction::operator+(const Fraction &f)
{
    if (this->m == f.m)
        return *(new Fraction(this->n + f.n, this->m));
    Fraction *result = new Fraction(this->n * f.m + f.n * this->m, this->m * f.m);
    return *result;
}
Fraction Fraction::operator-(const Fraction &f)
{
    if (this->m == f.m)
        return *(new Fraction(this->n - f.n, f.m));
    Fraction *result = new Fraction(this->n * f.m - f.n * this->m, this->m * f.m);
    return *result;
}
Fraction Fraction::operator*(const Fraction &f)
{
    return *(new Fraction(this->n * f.n, this->m * f.m));
}
Fraction Fraction::operator/(const Fraction &f)
{
    return *(new Fraction(this->n * f.m, this->m * f.n));
}
Fraction Fraction::operator*(int exp)
{
    this->n *= exp;
    this->m *= exp;
    return *this;
}
bool Fraction::operator==(const Fraction &f)
{
    return this->n == f.n && this->m == f.m;
}
ostream &operator<<(ostream &out, const Fraction &f)
{
    out << f.n << '/' << f.m;
    return out;
}
istream &operator>>(istream &input, Fraction &f)
{
    input >> f.n >> f.m;
    return input;
}