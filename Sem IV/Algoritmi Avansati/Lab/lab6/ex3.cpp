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

  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      cout << tetha[i][j] << ' ';
    }
    cout << endl;
  }
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
  int x, y;
  point D;
  vector<point> puncte;
  ifstream f("ex3.in");
  for (int i = 0; i < 3; i++)
  {
    f >> x >> y;
    puncte.push_back({x, y});
  }
  vector<int> pos = {0, 1, 2};
  while (testTurn(puncte[pos[0]], puncte[pos[1]], puncte[pos[2]]) < 0)
  {
    next_permutation(pos.begin(), pos.end());
  }
  f >> D.first >> D.second;
  if (detTheta(puncte[pos[0]], puncte[pos[1]], puncte[pos[2]], D) < 0)
  {
    cout << "D nu este in cerc";
  }
  else
  {
    cout << "D este in cerc";
  }
  f.close();
}