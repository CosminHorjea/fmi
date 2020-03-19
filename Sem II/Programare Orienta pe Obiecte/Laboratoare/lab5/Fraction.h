#pragma once

using namespace std;
class Fraction
{
    int n, m;

public:
    Fraction();
    Fraction(int, int);

    Fraction operator+(const Fraction &);
    Fraction operator-(const Fraction &);
    Fraction operator*(const Fraction &);
    Fraction operator/(const Fraction &);
    Fraction operator*(const int);
    Fraction &operator=(const Fraction &);
    bool operator==(const Fraction &);
    friend ostream &operator<<(ostream &, const Fraction &);
    friend istream &operator>>(istream &, Fraction &);
};