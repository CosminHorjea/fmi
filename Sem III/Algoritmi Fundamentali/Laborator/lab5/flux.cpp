#include <bits/stdc++.h>

//! nu e sursa mea
//! https://www.infoarena.ro/job_detail/2699214?action=view-source

using namespace std;

ifstream f("flux.in");

int c[1005][1005], flow[1005][1005], t[1005]; // capacitati, flux si vector de tati
int n, m, maxFlow;

queue<int> coada;
vector<int> G[1005], GRev[1005]; // graf si graf rezidual

bool bfs()
{
  memset(t, 0, sizeof(t)); //initializez t cu 0
  t[1] = -1;               //1 e sursa si nu are tata
  coada.push(1);           // primul nod e sursa

  while (!coada.empty()) //cat timp am noduri prin care pot sa merg
  {
    int node = coada.front(); // iau primul nod
    coada.pop();

    for (auto it = G[node].begin(); it != G[node].end(); ++it) //in vecinii acestuia
    {
      if (t[*it] == 0 && (c[node][*it] != 0 && flow[node][*it] < c[node][*it])) // daca nu are tata(nu am mes in el)
                                                                                // avem capacitate si fluxul care merge este mai mic decat capacitatea
      {
        t[*it] = node;   // actualizam tatal nodului curent
        coada.push(*it); // il punem in coada
      }
      else if (t[*it] == 0 && (c[*it][node] != 0 && flow[*it][node] > 0)) // iara, daca nu am vizitati nodul
                                                                          // daca avem capacitate si flowul este mai mare ca 0
      {
        t[*it] = -node; //??tatal este inversul nodului ??
                        // presupun ca zice, daca vede un flux incearca sa-l micsorezi
        coada.push(*it);
      }
    }
  }
  return (t[n] != 0); //retureneza tru daca am ajuns la final
}
int main()
{
  f >> n >> m;
  for (int i = 1; i <= m; i++) //citim graful cu capacitati
  {
    int x, y, capacitatea;
    f >> x >> y >> capacitatea;

    G[x].push_back(y);
    G[y].push_back(x);
    c[x][y] = capacitatea;
  }

  while (bfs()) //cat timp gasesc un grum rezidual
  {
    for (auto it = G[n].begin(); it != G[n].end(); it++) //in lista vecinilor lui t
    {
      if (flow[*it][n] < c[*it][n] && t[*it]) // daca mai am loc de flow, si am gasit o retea reziduala prin nodul curent
      {
        int u = *it, val = c[*it][n] - flow[*it][n]; // u este nodul curent, valoare este fluxul pe care as putea sa-l bag de la el la finish
        while (u != 1)                               // cat timp u nu e start
        {
          if (t[u] < 0)                                //daca tatal este negativ
            val = min(val, flow[u][-t[u]]), u = -t[u]; // iau fluxul invers
          else
            val = min(val, c[t[u]][u] - flow[t[u]][u]), u = t[u]; // iau fluxul normal
        }                                                         // practic calculez fluxul maxim din drumul rezidual

        u = *it;             // ma intorc la vecinul lui n (finish)
        flow[*it][n] += val; // adun in flow pe acea muchie

        while (u != 1) //pana cand ajung la start
        {
          if (t[u] < 0)                       // daca tatal e negativ
            flow[u][-t[u]] -= val, u = -t[u]; //scad fluxul, pentu ca il dau inapoi
          else
            flow[t[u]][u] += val, u = t[u]; // adun fluxul
        }

        maxFlow += val; // adun la valoarea maxima
      }
    }
  }
  cout << maxFlow << endl;
  return 0;
}