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
  if (currentNode == desieredNode)
  {
    return maxCost;
  }
  int minim;
  for (int u : graf[currentNode])
  {
    if ((currentNode == startNode) && (u == desieredNode))
      continue;
    if (visited[u] == 0)
    {
      // cout << "Sunt in nodul " << currentNode << " si vizitez " << u << " cu max cost: " << maxCost << endl;
      minim = dfs(graf, u, startNode, desieredNode, max(maxCost, costuri[currentNode][u]));
    }
  }
  return minim;
}
int main()
{
  int n, m, x, y, c;
  vector<list<int>> graf;
  set<pair<int, pair<int, int>>> muchii;
  ifstream f("secondBest.in");
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
      cout << n1 << " " << n2 << " " << p.first << endl;
      cost += p.first;
      graf[n1].push_back(n2);
      graf[n2].push_back(n1);
    }
  }
  cout << cost << endl;
  vector<list<int>> cpGraf = graf;
  int minSecCost = cost * cost;
  while (muchii.size()) // it aint pretty at all, e explicat mult mai bine si cred ca e implementarea mai usoara in Seminar_3_apcm.pdf
  {
    auto nextEdge = *muchii.begin();
    muchii.erase(muchii.begin());
    x = nextEdge.second.first;
    y = nextEdge.second.second;
    c = nextEdge.first;
    graf[x].push_back(y);
    graf[y].push_back(x);
    costuri[x][y] = c;
    costuri[y][x] = c;
    cout << x << " " << y << " " << c << endl;
    int costMuchieInCiclu = dfs(graf, x, x, y, 0);
    cout << costMuchieInCiclu << endl;
    graf = cpGraf;
    // cout << "Marime graf" << graf.size() << endl;
    // cout << costMuchieInCiclu << endl;
    minSecCost = min(minSecCost, cost - costMuchieInCiclu + c);
    for (int i = 0; i <= n; i++)
      visited[i] = 0;
  }
  cout << minSecCost;
}