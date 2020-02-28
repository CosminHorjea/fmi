#include <iostream>
#include <cmath>
using namespace std;

class Numar_Complex
{
    double re, im;

public:
    Numar_Complex()
    {
        re = 0;
        im = 0;
    }
    Numar_Complex(double a, double b)
    {
        re = a;
        im = b;
    }
    Numar_Complex(Numar_Complex &nr)
    {
        re = nr.re;
        im = nr.im;
    }
    ~Numar_Complex()
    {
        re = im = 0;
    }
    double getRe()
    {
        return re;
    }
    double getIm()
    {
        return im;
    }
    void setIm(double val)
    {
        im = val;
    }
    void setRe(double val)
    {
        re = val;
    }
    void afisare()
    {
        cout << re << "+" << im << "i\n";
    }
    double absoluteValue()
    {
        return sqrt(re * re + im * im);
    }
    Numar_Complex operator+(Numar_Complex &n)
    {
        Numar_Complex aux;
        aux.re = this->re + n.re;
        aux.im = this->im + n.im;
        return aux;
    }
    Numar_Complex operator*(Numar_Complex &n)
    {
        Numar_Complex aux;
        aux.re = this->re * n.re;
        aux.im = this->im * n.im;
        return aux;
    }
};

int main()
{
    Numar_Complex n1(1, 2), n2(2, 3);
    n1.afisare(); //good
    // cout << n1.absoluteValue();//good
    (n1 + n2).afisare(); //good i think
    (n1 * n2).afisare(); //good i think
}