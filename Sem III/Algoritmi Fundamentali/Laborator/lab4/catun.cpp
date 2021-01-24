#include <bits/stdc++.h>
// nu e sursa mea
//https://www.infoarena.ro/job_detail/2679182?action=view-source
using namespace std;

const int Inf = 1e9 + 5;
const int Dim = 5e4 + 5;

int d[Dim], ans[Dim]; // vector de distante si raspunsul pe care il afisez
int n, m, k;          // noduri muchii si catune

bool c[Dim], viz[Dim];                // vector daca e catun sau daca e deja vizitat
vector<pair<int, int>> G[Dim];        //graful prorpiu zis
priority_queue<pair<int, int>> coada; //coada pentru djikstra

ifstream f("catun.in");
int main()
{
  f >> n >> m >> k;

  for (int i = 1; i <= n; i++)
    d[i] = Inf; //toate distantele sunt initial infinit
  for (int i = 1; i <= k; i++)
  {
    int x;
    f >> x;
    coada.push({0, x}); //adaug nodul x, care e sursa si distanta 0

    ans[x] = x; // raspunsul este nodul in sine
    d[x] = 0;   //distanta este 0 deoarece e sursa
    c[x] = 1;   // este catun
  }
  for (int i = 1; i <= m; i++)
  {
    int x, y, cost;
    f >> x >> y >> cost;
    G[x].push_back({y, cost}); //in lista de adiaceta retin si costul inspre acel nod
    G[y].push_back({x, cost});
  }
  while (!coada.empty())
  {
    int node = coada.top().second; // iau nodul de sus
    coada.pop();                   //il sco pentru ca e clar ca am gasit ruta cu cel mai mic cost
    cout << "-------------" << endl;
    cout << node << endl;
    cout << "-------------" << endl;
    if (viz[node] == 0)
    {                                                            //daca nu l-am vizitat
      for (auto it = G[node].begin(); it != G[node].end(); ++it) //in lista lui de vecini
      {
        int aux = it->second + d[node];                        //distanta pana la nodul vecin daca aleg ruta prin nodul curent
        if (aux == d[it->first] && ans[node] < ans[it->first]) //daca distanta la nodul candidat este aceeasi ca pana la nodul curent (muchie 0) si deja exista un drum cu o alta fortareata
        {
          ans[it->first] = ans[node];             // o pun pe cea mai mica in ans (asa e enuntul)
          coada.push({-d[it->first], it->first}); // punem costul negativ si nodul vecin in coada
        }
        else
        {
          if (aux < d[it->first]) //daca distanata este mai mica decat ce aveam eu
          {
            ans[it->first] = ans[node];             // actualizez raspunsul
            d[it->first] = aux;                     // actualizez distanta
            coada.push({-d[it->first], it->first}); //adaug distanta negativa si nodul vecin
            //?? nu inteleg de ce aici e cu distanta negativa, dar daca pun cu + vad ca merge, pe cazul dat de site cel putin
            // !! priority_queue pune pe ala cu elementul de pe pozitia first mai mare in fata cozii, pentru ca are prioritate mai mare,
            // !! deci da, trebuie cu - prioritatea daca le vrem pe alea mai mici
          }
        }
      }
      viz[node] = 1;
    }
  }
  for (int i = 1; i <= n; i++)
  {
    if (c[i] == 1)
      ans[i] = 0;
    cout << ans[i] << " ";
  }
  return 0;
}