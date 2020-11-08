//Nu stiu daca se pot afla altfel ciclurile alea dar am ales sa gasesc componentele tare conexe
//https://www.youtube.com/watch?v=RpgcYiky7uw&ab_channel=TusharRoy-CodingMadeSimple

#include <iostream>
#include <fstream>
#include <list>
#include <vector>
#include <queue>
#include <stack>

using namespace std;

vector<bool> visited;
stack<int> stackByFinish;
void citeste(vector<list<int>> &graf)
{
  int n, m, x, y;
  ifstream f("graf.in");
  f >> n >> m;
  graf.resize(n + 1);
  visited.resize(n + 1);
  for (int i = 0; i < m; i++)
  {
    f >> x >> y;
    graf[x].push_back(y);
  }
}
void dfs(vector<list<int>> &graf, int i)
{
  if (!visited[i])
  {
    visited[i] = true;
    for (int j : graf[i])
      if (!visited[j])
        dfs(graf, j);
    stackByFinish.push(i);
  }
}
void reverseGraph(vector<list<int>> &graf)
{
  int n, m, x, y;
  ifstream f("graf.in");
  f >> n >> m;
  graf.clear();
  graf.resize(n + 1);
  for (int i = 0; i < m; i++)
  {
    f >> x >> y;
    graf[y].push_back(x);
  }
}
void dfs2(vector<list<int>> &graf, int i, vector<int> &path)
{
  if (!visited[i])
  {
    visited[i] = true;
    path.push_back(i);
    for (int j : graf[i])
      if (!visited[j])
        dfs2(graf, j, path);
  }
}
void connected(vector<list<int>> &graf)
{
  int ok = 0;
  visited.clear();
  visited.resize(graf.size());
  while (stackByFinish.size())
  {
    int i = stackByFinish.top();
    if (!visited[i])
    {
      vector<int> path;
      dfs2(graf, i, path);
      if (path.size() > 1)
      {
        ok = 1;
        for (int node : path)
          cout << node << " ";
        cout << endl;
      }
    }
    stackByFinish.pop();
  }
  if (!ok)
  {
    cout << "Proiect realizabil";
  }
}
int main()
{
  vector<list<int>> graf;
  citeste(graf);
  dfs(graf, 1);
  reverseGraph(graf);
  connected(graf);
}