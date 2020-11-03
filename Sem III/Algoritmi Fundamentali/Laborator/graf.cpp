#include <iostream>
#include <fstream>
#include <list>
#include <vector>
#include <queue>
using namespace std;

int X,Y;

void citeste(vector<list<int>> &graf)
{
    int n,m,x,y;
    ifstream f("graf.in");
    f>>n>>m>>X>>Y;
    graf.resize(n+1);
    for(int i=0;i<m;i++){
        f>>x>>y;
        graf[x].push_back(y);
        graf[y].push_back(x);
    }

}

void calcDistante(int start,vector<list<int>>& graf,vector<int> &dist){
    dist.resize(graf.size());
    queue<int> q;
    q.push(start);
    dist[start]=1;
    while(!q.empty()){
        int acc = q.front();
        q.pop();
        for(int i : graf[acc]){
            if(!dist[i]){
                dist[i]=dist[acc]+1;
                q.push(i);
            }
        }
    }

}

int main(){
    vector<int>frecv;
    vector<int> solutie;
    vector<list<int>> graf;
    citeste(graf);
    frecv.resize(graf.size(),0);
    vector<int> distX,distY;

    calcDistante(X,graf,distX);
    calcDistante(Y,graf,distY);
    
    for(int i=1;i<graf.size();i++){
        if(distX[i]+distY[i]==distX[Y]+1)
            frecv[distX[i]]++;
    }
    for(int i =1;i<graf.size();i++){
        if(distX[i]+distY[i]==distX[Y]+1 && frecv[distX[i]]==1)solutie.push_back(i);
    }
    ofstream g("graf.out");
    g<<solutie.size()<<endl;
    for(int i:solutie)
        g<<i<<" ";
    g.close();
}