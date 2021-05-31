#include <bits/stdc++.h>

using namespace std;

ifstream f("ex1.in");
const float inf = 1000000;

struct Plane
{
  float a, b, c;
  // ax + by + c <= 0
  float getExtremity()
  {
    if (a == 0)
    {
      return -c / b;
    }
    else
    {
      return -c / a;
    }
  }
};

void intersection(vector<Plane> planes)
{
  float x_min = -inf, x_max = inf, y_min = -inf, y_max = inf;

  for (Plane p : planes)
  {
    if (p.a) //plan vertical
    {
      if (p.a > 0)
      {
        x_min = max(x_min, p.getExtremity());
      }
      else
      {
        x_max = min(x_max, p.getExtremity());
      }
    }
    else
    { //plan orizontal
      if (p.b > 0)
      {
        y_min = max(y_min, p.getExtremity());
      }
      else
      {
        y_max = min(y_max, p.getExtremity());
      }
    }
  }
  // cout << x_min << " " << x_max << " " << y_min << " " << y_max << endl;
  if (x_min < x_max && y_min < y_max)
  {
    cout << "Intersectie goala" << endl;
  }
  else if (x_min == -inf || x_max == inf ||
           y_min == -inf || y_max == inf)
  {
    cout << "Intersectie nevida,nemagrinita " << endl;
  }
  else
  {
    cout << "Intersectie nevida, marginita" << endl;
  }
}

int main()
{
  int n;
  while (f >> n)
  {
    vector<Plane> planes;
    for (int i = 0; i < n; i++)
    {
      Plane aux;
      f >> aux.a >> aux.b >> aux.c;
      planes.push_back(aux);
    }
    intersection(planes);
  }
}