#include <bits/stdc++.h>

using namespace std;

int dsu[100];
int find(int x);

void combina(int x, int y)
{
  dsu[find(x)] = find(dsu[y]);
}
int find(int x)
{
  if (dsu[x] != x)
    dsu[x] = find(dsu[x]);
  return dsu[x];
}
int costuri[20][20];
int visited[100];
int dfs(vector<list<int>> graf, int currentNode, int startNode, int desieredNode, int maxCost)
{
  visited[currentNode] = 1;
  if ((currentNode == desieredNode) && (currentNode != startNode))
  {
    return maxCost;
  }
  for (int u : graf[currentNode])
  {
    if ((currentNode == startNode) && (u == desieredNode))
      continue;
    if (!visited[u])
      return dfs(graf, u, startNode, desieredNode, max(maxCost, costuri[currentNode][u]));
  }
  return 0;
}
int main()
{
  int n, m, x, y, c;
  vector<list<int>> graf;
  set<pair<int, pair<int, int>>> muchii;
  ifstream f("grafDinamic.in");
  f >> n >> m;
  graf.resize(n + 1, {});
  for (int i = 1; i <= m; i++)
  {
    f >> x >> y >> c;
    muchii.insert({c, {x, y}});
    costuri[x][y] = c;
    costuri[y][x] = c;
  }
  for (int i = 0; i < n; i++)
  {
    dsu[i] = i;
  }
  int sz = n;
  int cost = 0;
  while (sz > 1)
  {
    auto p = *muchii.begin();
    muchii.erase(muchii.begin());
    int n1 = p.second.first;
    int n2 = p.second.second;
    if (find(n1) != find(n2))
    {
      sz--;
      combina(n1, n2);
      cout << n1 << " " << n2 << endl;
      cost += p.first;
      graf[n1].push_back(n2);
      graf[n2].push_back(n1);
    }
  }
  cout << cost << endl;
  cin >> x >> y >> c;
  // x = 3;
  // y = 5;
  // c = 4;
  graf[x].push_back(y);
  graf[y].push_back(x);
  costuri[x][y] = c;
  costuri[y][x] = c;
  visited[x] = 1;
  int costMuchieInCiclu = dfs(graf, x, x, y, 0);
  cout << costMuchieInCiclu << endl;
  cout << cost - costMuchieInCiclu + c;
  // idee pentru 6, probabil acelasi lucru doar ca in loc sa adaug eu o muchie,
  // o pun pe urmatoarea care venea la rand in constructia apcm
}