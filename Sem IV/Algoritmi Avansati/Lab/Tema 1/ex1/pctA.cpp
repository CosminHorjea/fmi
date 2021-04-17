#include <bits/stdc++.h>

using namespace std;

int main()
{
    int N, k;
    int S[100];
    cout << "N= ";
    cin >> N;
    cout << "K= ";
    cin >> k;
    cout << "S= ";
    for (int i = 0; i < N; i++)
        cin >> S[i];
    vector<int> lastProfit(k, 0);
    vector<int> nowProfit(k, 0);
    //consideram ca fiecare obiect are valoare si greutatea egale
    for (int i = 0; i < N; i++) //fiecare obiect
    {
        for (int j = 0; j < k; j++) // fiecare greutate
        {
            if (S[i] <= j) //daca ob curent e mai mic decat greutatea
            {
                nowProfit[j] = max(S[i] + lastProfit[j - S[i]], // iau maximul dintre profitul anterior cu obiectul actual si fara el
                                   lastProfit[j]);
            }
            else
            {
                nowProfit[j] = lastProfit[j]; // altfel avem acelasi profit pt greutatea j
            }
        }
        lastProfit = nowProfit;
    }
    cout << "Profit: " << nowProfit[k - 1] << endl;
}