
#include <bits/stdc++.h>

using namespace std;

vector<vector<int>> graf;
const int Inf = 1e9 + 5;

int n, m;
int x, y, c;
int cost[100][100];
int d[100];
int s = 1;

int main()
{
  ifstream f("grafpond.in");
  f >> n >> m;
  graf.resize(n + 1, {});
  for (int i = 0; i < 100; i++)
  {
    d[i] = Inf;
  }
  for (int i = 0; i < 100; i++)
  {
    for (int j = 0; j < 100; j++)
    {
      cost[i][j] = Inf;
    }
  }
  while (f >> x >> y >> c)
  {
    graf[x].push_back(y);
    graf[y].push_back(x);
    cost[x][y] = cost[y][x] = c;
  }
  d[s] = 0;
  for (int iter = 1; iter < n; iter++)
  {
    bool flag = false;
    for (int i = 1; i <= n; i++)
    {
      for (int v : graf[i])
      {
        if (d[i] + cost[i][v] < d[v])
        {
          d[v] = d[i] + cost[i][v];
          flag = true;
        }
      }
    }
    if (!flag)
      break;
  }
  for (int i = 1; i <= n; i++)
  {
    cout << d[i] << " ";
  }
}
