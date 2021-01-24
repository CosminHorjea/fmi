#include <bits/stdc++.h>

using namespace std;

vector<int> G[100];
vector<int> grad(27, 0);
int visited[100];

int colors[6] = {1, 2, 3, 4, 5, 6};

int main()
{
  ifstream f("color.in");
  string line;
  for (int i = 1; i <= 26; i++)
  {
    getline(f, line);
    stringstream s(line.substr(3));
    int x;
    while (s >> x)
    {
      G[i].push_back(x);
      grad[i]++;
    }
  }
  queue<int> colorq;
  stack<int> nodesToColor;
  vector<int> nodeColor(27, 0);
  for (int i = 1; i < 27; i++)
  {
    if (grad[i] <= 5)
    {
      colorq.push(i);
      visited[i] = 1;
      // cout << i << " ";
    }
  }
  while (!colorq.empty())
  {
    int curr = colorq.front();
    visited[curr] = 1;
    nodesToColor.push(curr);
    colorq.pop();
    for (int u : G[curr])
    {
      grad[u]--;
      if (grad[u] <= 5 && !visited[u])
      {
        colorq.push(u);
        visited[u] = 1;
      }
    }
  }

  while (!nodesToColor.empty())
  {
    int curr = nodesToColor.top();
    nodesToColor.pop();
    vector<int> used(7, 0);
    for (int u : G[curr])
    {
      used[nodeColor[u]] = 1;
    }
    for (int i = 1; i < 7; i++)
    {
      if (!used[i])
      {
        nodeColor[curr] = i;
        break;
      }
    }
  }
  for (int i = 1; i < 27; i++)
  {
    cout << i << " : " << nodeColor[i] << endl;
  }
}