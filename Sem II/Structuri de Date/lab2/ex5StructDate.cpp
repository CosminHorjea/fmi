#include <iostream>

using namespace std;

int main()
{
    int n, v[100];
    cin >> n;
    for (int i = 0; i < n; i++)
        cin >> v[i];
    int maj_index = 0, count = 1;
    for (int i = 1; i < n; i++)
    {
        if (v[maj_index] == v[i])
            ++count;
        else
            --count;
        if (count == 0)
        {
            maj_index = i;
            count = 1;
        }
    }
    int apperences = 0;
    for (int i = 0; i < n; i++)
    {
        if (v[maj_index] == v[i])
            ++apperences;
    }
    if (apperences > n / 2)
    {
        cout << v[maj_index];
    }
    else
    {
        cout << "Nu exista";
    }
    return 0;
}