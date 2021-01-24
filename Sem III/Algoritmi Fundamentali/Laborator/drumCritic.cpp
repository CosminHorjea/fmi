#include <bits/stdc++.h>

using namespace std;

int d[100];
int cost[100];
bool visited[100];
vector<int> topologicalSort;
stack<int> stackTopological;

vector<int> G[100];

void dfs(int i)
{
  visited[i] = 1;
  for (int j : G[i])
  {
    if (!visited[j])
      dfs(j);
  }
  stackTopological.push(i);
}

int main()
{
  int n, x, y, m;
  ifstream f("drumCritic.in");
  f >> n;
  for (int i = 1; i <= n; i++)
  {
    f >> x;
    cost[i] = x;
  }
  f >> m;
  for (int i = 0; i < m; i++)
  {
    f >> x >> y;
    G[x].push_back(y);
  }
  for (int i = 1; i <= n; i++)
  {
    if (!visited[i])
    {
      dfs(i);
    }
  }
  while (stackTopological.size())
  {
    topologicalSort.push_back(stackTopological.top());
    stackTopological.pop();
  }

  for (int i : topologicalSort)
  {
    d[i] += cost[i];
    for (int j : G[i])
      d[j] = max(d[i], d[j]);
  }
  for (int i = 1; i <= n; i++)
    cout << d[i] << " ";
  cout << endl;
}