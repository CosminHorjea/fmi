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

double detTheta(point A, point B, point C, point D)
{
  vector<vector<double>> tetha = {{A.first, A.second, pow(A.first, 2) + pow(A.second, 2), 1},
                                  {B.first, B.second, pow(B.first, 2) + pow(B.second, 2), 1},
                                  {C.first, C.second, pow(C.first, 2) + pow(C.second, 2), 1},
                                  {D.first, D.second, pow(D.first, 2) + pow(D.second, 2), 1}};

  // for (int i = 0; i < 4; i++)
  // {
  //   for (int j = 0; j < 4; j++)
  //   {
  //     cout << tetha[i][j] << ' ';
  //   }
  //   cout << endl;
  // }
  vector<vector<double>> tethaPrime;
  for (int linie = 1; linie < 4; linie++)
  {
    tethaPrime.push_back({});
    for (int col = 0; col < 3; col++)
    {
      tetha[linie][col] -= tetha[0][col];
      tethaPrime[linie - 1].push_back(tetha[linie][col]);
    }
  }
  double determinant = 0;
  determinant += tethaPrime[0][0] * tethaPrime[1][1] * tethaPrime[2][2];
  determinant += tethaPrime[0][1] * tethaPrime[1][2] * tethaPrime[2][0];
  determinant += tethaPrime[1][0] * tethaPrime[2][1] * tethaPrime[0][2];
  determinant -= tethaPrime[0][2] * tethaPrime[1][1] * tethaPrime[2][0];
  determinant -= tethaPrime[0][1] * tethaPrime[1][0] * tethaPrime[2][2];
  determinant -= tethaPrime[2][1] * tethaPrime[1][2] * tethaPrime[0][0];
  return -determinant;
}

int main()
{
  double x, y;
  vector<point> puncte;
  ifstream f("ex4.in");
  for (int i = 0; i < 4; i++)
  {
    f >> x >> y;
    puncte.push_back({x, y});
  }
  if (detTheta(puncte[0], puncte[1], puncte[2], puncte[3]) > 0)
  {
    cout << "Muchia AC este ilegala\n";
  }
  if (detTheta(puncte[1], puncte[2], puncte[3], puncte[0]) > 0)
  {
    cout << "Muchia BD este ilegala\n";
  }
  f.close();
}