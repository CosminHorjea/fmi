// #include <bits/stdc++.h>
#include <fstream>
#include <iostream>
#include <vector>
#include <utility>
#include <map>

using namespace std;

int dsu[100], n, m;
int cost[20][20];

int find(int x);

void combina(int x, int y)
{
  dsu[x] = find(dsu[y]);
}
int find(int x)
{
  if (dsu[x] != x)
    dsu[x] = find(dsu[x]);
  return dsu[x];
}

int main()
{
  ifstream f("grafpond.in");
  vector<vector<int>> graf;
  map<int, pair<int, int>> muchii;
  f >> n >> m;
  for (int i = 1; i <= n; i++)
  {
    dsu[i] = i;
  }
  graf.resize(n + 1, {});
  for (int i = 1; i <= n; i++)
    graf[i].resize(m);
  int x, y, c;
  for (int i = 0; i < m; i++)
  {
    f >> x >> y >> c;
    graf[x].push_back(y);
    graf[y].push_back(x);
    muchii[c] = {x, y};
    cost[x][y] = c;
  }
  f.close();

  for (pair<int, pair<int, int>> m : muchii)
  {
    if (find(m.second.first) != find(m.second.second))
    {
      combina(m.second.first, m.second.second);
      cout << "c: " << cost[m.second.first][m.second.second] << " "
           << m.second.first << " " << m.second.second << endl;
    }
  }
  return 0;
}