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

void test_monotonicity(vector<point> &polygon)
{
  // prima data x monoton
  int left_most = 0;
  int n = polygon.size();
  for (int i = 1; i < n; i++)
  {
    if (polygon[i].first < polygon[left_most].first)
    {
      left_most = i;
    }
  }
  int currentPoint = left_most;
  int nextPoint;
  int okX = 1;
  int increasing = 1; //  prima data ne uitam dupa puncte care cres si punctele pot sa scada doar o singura data
  for (int i = 0; i < n - 1; i++)
  {
    nextPoint = (currentPoint + 1) % n;

    if (polygon[nextPoint].first > polygon[currentPoint].first && !increasing)
    {
      okX = 0;
    }
    if (polygon[nextPoint].first < polygon[currentPoint].first)
    {
      if (increasing)
        increasing = 0;
    }
    currentPoint = nextPoint;
  }
  if (!okX)
  {
    cout << "Poligonul nu este x-monoton\n";
  }
  else
  {
    cout << "Poligonul este x-monoton\n";
  }
  // acum cu y monoton
  int lowest = 0;
  for (int i = 1; i < n; i++)
  {
    if (polygon[i].second < polygon[lowest].second)
    {
      lowest = i;
    }
  }
  currentPoint = lowest;
  int okY = 1;
  increasing = 1;
  for (int i = 0; i < n - 1; i++)
  {
    nextPoint = (currentPoint + 1) % n;

    if (polygon[nextPoint].second > polygon[currentPoint].second && !increasing)
    {
      okY = 0;
    }
    if (polygon[nextPoint].second < polygon[currentPoint].second)
    {
      if (increasing)
        increasing = 0;
    }
    currentPoint = nextPoint;
  }
  if (okY)
  {
    cout << "Poligonul este y-monoton\n";
  }
  else
  {
    cout << "Poligonul nu este y-monoton\n";
  }
}

int main()
{
  int n;
  double x, y;

  ifstream f("ex2.in");
  int nr = 1;
  while (f >> n)
  {
    vector<point> polygon;
    cout << "Poligon " << nr++ << endl;
    for (int i = 0; i < n; i++)
    {
      f >> x >> y;
      polygon.push_back({x, y});
    }
    test_monotonicity(polygon);
  }
}