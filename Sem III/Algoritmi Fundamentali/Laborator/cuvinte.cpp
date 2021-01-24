#include <bits/stdc++.h>

using namespace std;

map<string, string> dsu;
string find(string x);

void combina(string x, string y)
{
  dsu[x] = find(dsu[y]);
}
string find(string x)
{
  if (dsu[x] != x)
    dsu[x] = find(dsu[x]);
  return dsu[x];
}

int distanta(string s1, string s2)
{
  int n1 = s1.length();
  int n2 = s2.length();
  vector<int> ci1(n2 + 1);
  vector<int> ci(n2 + 1);
  for (int j = 0; j <= n2; j++)
    ci1[j] = j;
  for (int i = 1; i <= n1; i++)
  {
    ci[0] = 1;
    for (int j = 1; j <= n2; j++)
    {
      if (s1[i - 1] == s2[j - 1])
        ci[j] = ci1[j - 1];
      else
        ci[j] = 1 + min(min(ci1[j], ci[j - 1]), ci1[j - 1]);
    }
    for (int j = 0; j <= n2; j++)
      ci1[j] = ci[j];
  }
  return ci[n2];
}

int main()
{
  int k = 3;
  string s;
  vector<string> cuv;
  ifstream f("cuvinte.in");
  while (f >> s)
  {
    cuv.push_back(s);
    dsu[s] = s;
  }
  for (int i = 0; i < cuv.size(); i++)
  {
    for (int j = i + 1; j < cuv.size(); j++)
    {
      if (find(cuv[i]) != find(cuv[j]))
        if (distanta(cuv[i], cuv[j]) <= k)
        {
          combina(cuv[i], cuv[j]);
        }
    }
  }
  map<string, vector<string>> grupe;
  for (auto p : dsu)
  {
    grupe[p.second].push_back(p.first);
  }
  for (auto p : grupe)
  {
    for (auto s : p.second)
    {
      cout << s << " ";
    }
    cout << endl;
  }
}