#include <bits/stdc++.h>

using namespace std;

ifstream f("ex2.in");
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
struct Point
{
  float x, y;
};

void areaOfRectangle(Point q, vector<Plane> planes)
{
  float x_min = -inf, x_max = inf, y_min = -inf, y_max = inf;
  for (Plane p : planes)
  {
    if (p.a) //plan vertical
    {
      if (q.x > p.getExtremity() && p.a > 0 || q.x < p.getExtremity() && p.a < 0) // daca planul nu acopera punctul, nu ne intereseaza
        continue;
      if (p.a > 0) //daca planul este nemarginit la stanga
      {
        if (abs(p.getExtremity() - q.x) < abs(x_min - q.x)) //actualizez muciile doar daca distanta fata de punctul ales se micsoreaza
          x_min = p.getExtremity();
      }
      else //daca planul este nemarginit la dreapta
      {
        if (abs(p.getExtremity() - q.x) < abs(x_max - q.x))
          x_max = p.getExtremity();
      }
    }
    else
    { //plan orizontal
      if (q.y > p.getExtremity() && p.b > 0 || q.y < p.getExtremity() && p.b < 0)
        continue;
      if (p.b > 0) // daca planul este nemarginit in jos
      {
        if (abs(p.getExtremity() - q.y) < abs(y_min - q.y))
          y_min = p.getExtremity();
      }
      else // daca planul este nemarginit in sus
      {
        if (abs(p.getExtremity() - q.y) < abs(y_max - q.y))
          y_max = p.getExtremity();
      }
    }
  }
  if (x_min < x_max && y_min < y_max)
  {
    cout << "nu exista un dreptunghi cu proprietatea ceruta" << endl;
  }
  else if (x_min == -inf || x_max == inf ||
           y_min == -inf || y_max == inf)
  {
    cout << "nu exista un dreptunghi cu proprietatea ceruta " << endl;
  }
  else
  {
    cout << "Aria minima este " << (abs(y_max - y_min) * abs(x_max - x_min)) << endl;
  }
}

int main()
{
  int n, idx = 1;
  Point q;
  while (f >> q.x >> q.y)
  {
    f >> n;
    vector<Plane> planes;
    for (int i = 0; i < n; i++)
    {
      Plane aux;
      f >> aux.a >> aux.b >> aux.c;
      planes.push_back(aux);
    }
    cout << "Testcase " << idx++ << " : ";
    areaOfRectangle(q, planes);
  }
}