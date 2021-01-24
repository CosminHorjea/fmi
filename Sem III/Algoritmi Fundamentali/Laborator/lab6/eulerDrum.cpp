#include <bits/stdc++.h>

using namespace std;
//e implementarea recursiva de aici
//! https://infoarena.ro/problema/ciclueuler
vector<int> G[100];
int deg[100];
int n, m, x, y;
vector<int> cycle;
void euler(int v)
{
  while (deg[v])
  {
    int u = *G[v].begin();
    G[v].erase(G[v].begin());
    deg[v]--;
    deg[u]--;
    for (auto it = G[u].begin(); it != G[u].end(); it++)
    {
      if (*it == v)
      {
        G[u].erase(it);
        break;
      }
    }
    euler(u);
  }
  cycle.push_back(v);
}

int main()
{
  ifstream f("eulerDrum.in");
  f >> n >> m;
  while (f >> x >> y)
  {
    deg[x]++;
    deg[y]++;
    G[x].push_back(y);
    G[y].push_back(x);
  }
  // este ca cea de mai devreme
  // doar ca aici putem avea 2 noduri cu grad impar sau niciunul
  // aka nodurile din care incepe lantul si de unde iese
  // euler() se apeleaza pe unul cu grad impar, sau daca nu e, pe oricare, i guess
  int odd = 0;
  for (int i = 1; i <= n; i++)
  {
    if (deg[i] % 2)
    {
      odd++;
    }
  }
  if (odd != 2 && odd != 0)
  {
    cout << "NU";
    return -1;
  }
  euler(1);
  for (int i : cycle)
  {
    cout << i << ' ';
  }
}