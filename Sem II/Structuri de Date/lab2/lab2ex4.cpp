#include <iostream>
#include <fstream>
#include <iomanip>
 
#define NMAX 1000020

using namespace std;

ifstream f("matrice.in");
ofstream g("matrice.out");

int TT[NMAX], RG[NMAX],matrice[100][100];

 
int find(int x)
{
	int R, y;
 
	//merg in sus pe arbore pana gasesc un nod care pointeaza catre el insusi
	for (R = x; TT[R] != R; R = TT[R]);
 
	//aplic compresia drumurilor
	while (TT[x]!=x)
	{
		y = TT[x];
		TT[x] = R;
		x = y;
	}
	return R;
}
 
void unite(int x, int y)
{
	//unesc multimea cu rang mai mic de cea cu rang mai mare
	if (RG[x] > RG[y])
		TT[y] = x;
    else 
        TT[x] = y;
 
	//in caz ca rangurile erau egale atunci cresc rangul noii multimi cu 1
	if (RG[x] == RG[y]) 
        RG[x]++;
}
 
int main()
{
    int N, M,k=1;

    f>>N>>M;
 
	int i, j;
 
    for( i = 1;i<=N;i++)
        for( j = 1;j<=M;j++){
            f>>matrice[i][j];
            if(matrice[i][j]){
                TT[i*N+j]=i*N+j;
                RG[i*N+j]=1;
            }
        }
    f.close();
    for(i = 1;i<=N;i++){
        for(j = 1;j<=M;j++){
            int cell = N*i+j;
            int val = matrice[i][j];
            if(val){
                if(matrice[i-1][j])
                    if(find(N*(i-1)+j)!=find(cell))
                        unite(N*(i-1)+j,cell);
                if(matrice[i][j-1])
                    if(find(N*i+j-1)!=find(cell))
                        unite(N*i+j-1,cell);
                if(matrice[i-1][j] && matrice[i][j-1])
                    if(find(N*(i-1)+j)!=find(N*i+j-1))
                        unite(N*(i-1)+j,N*i+j-1); 
            }
        }
    }
    for( i = 1;i<=N;i++)
        for( j = 1;j<=M;j++)
            if(matrice[i][j]!=0){
                int cell=i*N+j;
                matrice[i][j]=find(cell);
            }
    
    for( i = 1;i<=N;i++){
        for( j = 1;j<=M;j++){
            g<<setw(8)<<matrice[i][j];
        }
        g<<endl;
    }

    g.close();
	return 0;
}
