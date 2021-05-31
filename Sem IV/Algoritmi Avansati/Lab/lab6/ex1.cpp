#include <bits/stdc++.h>

using namespace std;

typedef pair<double, double> point;

double testTurn(point p, point q, point r)
{
  double a = q.first * r.second;
  a += p.second * r.first;
  a += p.first * q.second;
  a -= q.first * p.second;
  a -= p.first * r.second;
  a -= q.second * r.first;
  return a;
}
ostream &operator<<(ostream &out, point x)
{
  out << x.first << " " << x.second;
  return out;
}
void isInside(vector<point> poligon, point p)
{
  int countIntersections = 0;
  int n = poligon.size();
  for (int i = 0; i < n; i++)
  {
    int j = (i + 1) % n;
    if (p.first == poligon[i].first && p.second == poligon[i].second)
    {
      cout << "Punctul " + to_string(p.first) + " " + to_string(p.second) + " este un punct care formeaza poligonul\n";
      return;
    }
    if (p.second == poligon[i].second && p.second == poligon[j].second)
    {
      // daca e o linie orizontala verificam daca ne aflam pe ea
      if (p.first > min(poligon[i].first, poligon[j].first) && p.first < max(poligon[i].first, poligon[j].first))
      {
        //testam sa vedem daca ne aflam pe linie
        // cout << "Punctul " + to_string(p.first) + " " + to_string(p.second) + " este pe linia poligonului\n";
        cout << setw(3) << p << "  Se afla pe o latura a poligonului\n";
        return;
      }
    }
    if ((p.first < poligon[i].first ||
         p.first < poligon[j].first) &&
        p.second >= min(poligon[i].second, poligon[j].second) && // daca trec printr-un punct, il iau in considerare doar daca este in josul laturii
        p.second < max(poligon[i].second, poligon[j].second))
    {
      // cout << "pentru linia " << i << " avem\n";
      // cout << "Punctele \n";
      // cout << poligon[i] << endl;
      // cout << poligon[j] << endl;
      countIntersections++;
    }
  }
  // cout << setw(3) << p << " " << countIntersections << setw(10);
  cout << setw(3) << p << " " << setw(10);
  if (countIntersections % 2)
    cout << " Se afla in interior";
  else
    cout << " Se afla in exterior";
  cout << endl;
  return;
}
int main()
{
  int n;
  double x, y;
  vector<point> poligon;
  vector<point> tests;
  // ifstream f("ex1_nu_din_enunt.in");
  // am facut un model putin diferit in care sa testez alte cazuri
  // http://prntscr.com/12xep58
  // https://www.geogebra.org/calculator/cen9ybnj

  ifstream f("ex1.in");
  f >> n;
  for (int i = 0; i < n; i++)
  {
    f >> x >> y;
    poligon.push_back({x, y});
  }
  while (f >> x >> y)
  {
    tests.push_back({x, y});
  }
  for (point p : tests)
    isInside(poligon, p);
}