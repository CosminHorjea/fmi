#include <bits/stdc++.h>

using namespace std;

int main()
{
    int N, k, suma = 0;
    int S[100];
    cout << "N= ";
    cin >> N;
    cout << "K= ";
    cin >> k;
    cout << "S= ";
    for (int i = 0; i < N; i++)
        cin >> S[i];
    for (int i = 0; i < N; i++) //mergem prin fiecare element
    {
        if (S[i] < k) //daca nu depasim spatiul ramas
        {
            suma += S[i]; // adunam la suma
            k -= S[i];    // "ocupam" saptiul
        }
        else
        {
            suma = max(suma, S[i]); // definitivam suma
            break;
        }
    }
    cout << "Suma: " << suma;
}
