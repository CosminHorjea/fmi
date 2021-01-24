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

float euclidianDistance(pair<int, int> p1, pair<int, int> p2)
{
  return sqrt(pow(p1.first - p2.first, 2) + pow(p1.second - p2.second, 2));
}
int main()
{
  ifstream f("retea2.in");
  int N, M, E, x, y;
  f >> N >> M >> E;
  int powered[N + M + 1] = {0};
  vector<pair<int, int>> cladiri(N + M + 1);
  for (int i = 1; i <= N + M; i++)
  {
    f >> x >> y;
    cladiri[i] = {x, y};
    dsu[i] = i;
  }
  for (int i = 1; i <= N; i++)
  {
    powered[i] = 1;
  }
  set<pair<float, pair<int, int>>> possibleEdges;
  for (int i = 1; i <= E; i++)
  {
    f >> x >> y;
    possibleEdges.insert({euclidianDistance(cladiri[x], cladiri[y]), {x, y}});
  }
  int sz = N + M;
  float cost = 0;
  vector<pair<int, int>> selectedEdges;
  while (sz > N)
  {
    auto minimumEdge = *possibleEdges.begin();
    int e1 = minimumEdge.second.first;
    int e2 = minimumEdge.second.second;
    possibleEdges.erase(possibleEdges.begin());
    if (find(e1) != find(e2))
    {
      if (powered[e1] == 0 || powered[e2] == 0)
      {
        powered[e1] = 1;
        powered[e2] = 1;
        sz--;
        cost += minimumEdge.first;
        combina(e1, e2);
        selectedEdges.push_back({e1, e2});
      }
    }
  }
  cout << cost << endl;
  for (auto e : selectedEdges)
  {
    cout << e.first << " " << e.second << endl;
  }
}