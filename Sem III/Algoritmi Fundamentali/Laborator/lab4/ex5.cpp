
#include <bits/stdc++.h>

using namespace std;

vector<vector<int>> graf;
vector<vector<int>> cost;
const int Inf = 1e9 + 5;

int n, m;
int x, y, c;
int cost[100][100];
int main()
{
  ifstream f("grafpond.in");
  f >> n >> m;
  for (int i = 0; i < 100; i++)
  {
    for (int j = 0; j < 100; j++)
    {
      cost[i][j] = Inf;
    }
  }
  while (f >> x >> y >> c)
  {
    cost[x][y] = cost[y][x] = c;
  }
  for (int i = 1; i <= n; i++)
  {
    for (int j = 1; j <= n; j++)
    {
      for (int k = 1; k <= n; k++)
      {
        if (cost[i][j] > cost[i][k] + cost[k][j])
        {
          cost[i][j] = cost[i][k] + cost[k][j];
        }
      }
    }
  }
  for (int i = 1; i <= n; i++)
  {
    for (int j = 1; j <= n; j++)
    {
      cout << setw(3) << cost[i][j] << " ";
    }
    cout << endl;
  }
}