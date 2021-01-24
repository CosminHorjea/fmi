#include <bits/stdc++.h>

using namespace std;
int n, m, s, t;
int capacity[100][100];
int flow[100][100];
int rezid[100][100];
int x, y, c, f;
const int Inf = 1e9 + 5;

vector<int> g[100];
int main()
{
  ifstream fin("retea.in");
  fin >> n >> s >> t >> m;
  for (int i = 1; i <= n; i++)
  {
    for (int j = 1; j <= n; j++)
    {
      rezid[i][j] = Inf;
    }
  }
  for (int i = 1; i <= m; i++)
  {
    fin >> x >> y >> c >> f;
    capacity[x][y] = c;
    capacity[y][x] = 0;
    flow[x][y] = f;
    rezid[x][y] = capacity[x][y] - f;
    g[x].push_back(y);
    g[y].push_back(x);
  }
  //*1. verificam daca fluxul dat este corect
  // for (int i = 2; i < n; i++) //fara s si t
  // {
  //   int costOut = 0;
  //   for (int v : g[i])
  //     costOut += flow[i][v];
  //   for (int j = 1; j <= n; j++)
  //   {
  //     for (int v : g[j])
  //     {
  //       if (v == i)
  //       {
  //         costOut -= flow[j][v];
  //       }
  //     }
  //   }
  //   if (costOut != 0)
  //   {
  //     cout << "NU";
  //     return 0;
  //   }
  // }
  cout << "E corect" << endl;
  int amPompat = 1;
  while (amPompat)
  {
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
      // cout << "nod: " << curr << endl;
      bfs.pop();
      for (int next : g[curr])
      {
        // cout << next;
        // cout << capacity[curr][next] - flow[curr][next];
        if (rezid[curr][next] > 0 && !visited[next])
        {

          // minFlow = min(minFlow, capacity[curr][next] - flow[curr][next]);
          path[next] = curr;
          bfs.push(next);
        }
      }
      // cout << endl;
    }
    if (path[t])
    {
      amPompat = 1;
      int father = t;
      while (path[father])
      {
        minFlow = min(minFlow, rezid[path[father]][father]);
        father = path[father];
      }
      father = t;
      while (path[father])
      {
        flow[path[father]][father] += minFlow;
        if (rezid[path[father]][father] == Inf) // asta e in cazul in care dau cancel la un anumit flux deca pompat
        {                                       // idk how, but it works
          flow[father][path[father]] -= minFlow;
        }
        rezid[path[father]][father] -= minFlow;
        father = path[father];
      }
      // cout << "added: " << minFlow << endl;
    }
  }
  for (int i : g[s])
  {
    cout << flow[s][i] << " ";
  }
  cout << endl;
  for (int i = 1; i <= n; i++)
  {
    for (int j = 1; j <= n; j++)
    {
      if (flow[i][j])
        cout << i << '-' << j << "->" << flow[i][j] << ' ';
    }
    cout << endl;
  }
  cout << endl;
}