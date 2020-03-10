#include <iostream>
#include <exception>
using namespace std;

int main()
{
    string s;
    s = "100";
    try
    {
        int i;
        cin >> i;
        if (i % 2)
        {
            throw i;
        }
        cout << i << "este par";
    }
    catch (int x)
    {
        cout << x << " este impar ";
    }
    cout << endl;
    return 0;
}