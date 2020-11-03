#include <iostream>
#include <fstream>
#include <queue>
#include <vector>
#include <algorithm>
#include <cstring>
#include <iomanip>
using namespace std;
#define inf 1e5+5;

ifstream f("rj.in");
ofstream g("rj.out");
int n,m,a[101][101],romeo[101][101],julieta[101][101];
int di[8] = {0,  0, -1, -1, -1,  1, 1,  1};
int dj[8] = {1, -1, -1,  1,  0, -1, 0,  1};

void fill(pair<int,int> pos , int matrice[101][101]){
    int nextX,nextY;
    queue<pair<int,int>> q;
    matrice[pos.first][pos.second] = 1;
    q.push(pos);
    while(!q.empty()){
        pair<int,int> p = q.front();
        q.pop();
        for(int i =0;i<8;i++){
            nextX = p.first+di[i];
            nextY = p.second+dj[i];
            if((nextX >= 1 && nextX<=n && nextY >=1 && nextY<=m)  && matrice[nextX][nextY]==0){
                matrice[nextX][nextY]=matrice[p.first][p.second]+1;
                q.push({nextX,nextY});
            }
        }
    }
}


int main(){
    pair<int,int> posRomeo,posJulieta;
    f>>n>>m;
    char s[101];
    f.get();
    for(int i=1;i<=n;i++){
        f.getline(s,101);
        for(int j =0;j<strlen(s);j++)
        {
            switch(s[j]){
                case 'R':
                    posRomeo={i,j+1};
                    // a[i][j]=-101;
                    break;
                case 'J':
                    posJulieta={i,j+1};
                    // a[i][j]=-101;
                    break;
                case 'X':
                    a[i][j+1]=-1;
                    break;
            }
            romeo[i][j+1]=julieta[i][j+1]=a[i][j+1];
        }
    }

    fill(posRomeo,romeo);
    fill(posJulieta,julieta);

    // for(int i=1;i<=n;i++){
    //     for(int j=1;j<=m;j++){
    //         cout<<setw(3)<<julieta[i][j]<<" ";
    //     }
    //     cout<<endl;
    // }
    pair<int,int> res;
    int min = inf;
    for(int i=1;i<=n;i++){
        for(int j=1;j<=m;j++){
            if((romeo[i][j]==julieta[i][j] )&& (romeo[i][j]<min) && (romeo[i][j]>=1)){
                res.first=i;
                res.second=j;
                min=romeo[i][j];
            }
        }
    }
    g<<min<<" "<<res.first<<" "<<res.second;
}