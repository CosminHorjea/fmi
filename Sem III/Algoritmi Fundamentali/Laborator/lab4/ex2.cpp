
#include <bits/stdc++.h>

using namespace std;

vector<vector<int>> graf;
vector<vector<int>> cost;
int k;
set<int> control;

int s = 1; //pct din care incep;

int n, m;

int before[100];

int x, y, c;

int Djikstra()
{
  set<int> done;
  set<pair<int, int>> pq;
  int d[100];
  for (int i = 1; i < 100; i++)
    d[i] = 10000;
  pq.insert({0, s});
  d[s] = 0;
  before[s] = 0;
  while (pq.size())
  {
    // for (auto p : pq)
    // {
    //   cout << p.first << "-" << p.second << endl;
    // }
    // cout << "-----\n";
    int u = pq.begin()->second;
    if (control.find(u) != control.end())
    {
      cout << "Costul: " << d[u] << endl;
      return u;
    }
    pq.erase(pq.begin());
    if (done.find(u) == done.end())
    {
      for (int v : graf[u])
      {

        if (d[u] + cost[u][v] < d[v])
        {
          d[v] = d[u] + cost[u][v];
          before[v] = u;
          pq.insert({d[v], v});
        }
      }
      done.insert(u);
    }
  }

  for (int i = 1; i <= 5; i++)
  {
    cout << i << " " << d[i] << endl;
  }
  return 0;
}

int main()
{
  ifstream f("grafpondex2.in");
  f >> n >> m;
  graf.resize(n + 1, {});
  cost.resize(n + 1, {});
  for (int i = 1; i <= n; i++)
  {
    cost[i].resize(n + 1);
  }
  for (int i = 1; i <= m; i++)
  {
    f >> x >> y >> c;
    graf[x].push_back(y);
    graf[y].push_back(x);
    cost[x][y] = cost[y][x] = c;
  }
  f >> k;
  for (int i = 0; i < k; i++)
  {
    f >> x;
    control.insert(x);
  }
  int closest = Djikstra();
  while (closest)
  {
    cout << closest << "->";
    closest = before[closest];
  }
  return 0;
}