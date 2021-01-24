#include <bits/stdc++.h>

using namespace std;
const int Inf = 1e9 + 5;

vector<int> g[100];
int flow[100][100];
int cap[100][100];
int x, y, n, m;

int main()
{
  vector<int> group(100, -1);
  vector<int> visited(100, 0);
  ifstream f("bipartit.in");
  f >> n >> m;
  while (f >> x >> y)
  {
    g[x].push_back(y);
    g[y].push_back(x);
    cap[x][y] = 1;
    cap[y][x] = 1;
  }
  queue<int> q;
  q.push(1);
  group[1] = 0;
  while (!q.empty())
  {
    int u = q.front();
    visited[u] = 1;
    q.pop();
    for (int v : g[u])
    {
      if (group[v] == group[u])
      {
        cout << "Graful nu este bipartit";
        return 0;
      }
      group[v] = !group[u];
      if (!visited[v])
        q.push(v);
    }
  }

  int s = 0, t = n + 1;

  for (int i = 0; i <= n + 1; i++)
  {
    if (group[i] == 0)
    {
      g[s].push_back(i);
      // g[i].push_back(s);
      cap[s][i] = 1;
    }
    if (group[i] == 1)
    {
      g[i].push_back(t);
      g[t].push_back(i);
      cap[i][t] = 1;
    }
  }

  int amPompat = 1;
  vector<int> used(100, 0);
  while (amPompat)
  {
    // cout << amPompat;
    int minFlow = Inf;
    amPompat = 0;
    queue<int> bfs;
    vector<int> path(100, 0);
    vector<int> visited(100, 0);
    bfs.push(s);
    path[s] = 0;
    visited[s] = 1;
    while (bfs.size())
    {
      int curr = bfs.front();
      visited[curr] = 1;
      bfs.pop();
      for (int next : g[curr])
      {
        if (flow[curr][next] == 0 && !visited[next] && !used[next])
        {
          path[next] = curr;
          bfs.push(next);
        }
      }
    }
    if (path[t])
    {
      amPompat = 1;
      int father = t;
      while (path[father])
      {
        used[path[father]] = 1;
        flow[path[father]][father] += 1;
        cout << "am pus pe " << path[father] << " si " << father << endl;
        father = path[father];
      }
      flow[0][father] += 1;
      cout << "am pus pe " << 0 << " si " << father << endl;
    }
  }
  for (int i : g[s])
  {
    cout << flow[s][i] << " ";
  }
  cout << endl;
  // for (int i = 0; i <= n + 1; i++)
  // {
  //   for (int j = 0; j <= n + 1; j++)
  //   {
  //     if (flow[i][j])
  //       cout << i << "-" << j << "->" << flow[i][j] << ' ';
  //   }
  //   cout << endl;
  // }

  return 0;
}