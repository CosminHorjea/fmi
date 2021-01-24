#include <bits/stdc++.h>

using namespace std;

class mycomparison
{
  bool reverse;

public:
  mycomparison(const bool &revparam = false)
  {
    reverse = revparam;
  }
  bool operator()(const pair<int, pair<int, int>> &lhs, const pair<int, pair<int, int>> &rhs) const
  {
    if (reverse)
      return (lhs.first > rhs.first);
    else
      return (lhs.first < rhs.first);
  }
};
int main()
{
  int n, m, x, y, c;
  vector<vector<int>> g;
  ifstream f("apm.in");
  int muchii[20][20];
  f >> n >> m;
  g.resize(n + 1);
  for (int i = 1; i <= m; i++)
  {
    f >> x >> y >> c;
    muchii[x][y] = c;
    muchii[y][x] = c;
    g[x].push_back(y);
    g[y].push_back(x);
  }
  priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> q;
  set<int> newNodes;
  newNodes.insert(1);
  for (int i : g[1])
  {
    q.push({muchii[1][i], {1, i}});
  }
  int qty = 0;
  while (newNodes.size() < n)
  {
    pair<int, pair<int, int>> f = q.top();
    q.pop();
    if (newNodes.find(f.second.second) == newNodes.end())
    {
      qty += f.first;
      newNodes.insert(f.second.second);
      for (int i : g[f.second.second])
      {
        q.push({muchii[f.second.second][i], {f.second.second, i}});
      }
    }
  }
  cout << qty << endl;
}
