#include <iostream>
#include <fstream>
#include <list>
#include <vector>
#include <queue>
#include <stack>
using namespace std;

vector<int> visited;
stack<int> recStack;
int backEdge;

void citeste(vector<list<int>> &graf)
{
    int n,m,x,y;
    ifstream f("grafC.in");
    f>>n>>m;
    graf.resize(n+1);
    visited.resize(n+1);
    for(int i=0;i<m;i++){
        f>>x>>y;
        graf[x].push_back(y);
        graf[y].push_back(x);
    }

}

bool dfs(vector<list<int>>& graf,int n,int parent){
    if(visited[n])
        return false;
    visited[n]=true;
    recStack.push(n);
    for(int i:graf[n]){
        if(!visited[i]){
            if(dfs(graf,i,n))
                return true;
        }
        else if (i!=parent){
            backEdge=i;
            return true;    
        }
    }
    recStack.pop();
    return false;
}

int main(){
    vector<list<int>> graf;
    citeste(graf);
    if(!dfs(graf,1,-1)){
        cout<<"Nu avem cicluri";
        return 0;
    }
    cout<<backEdge<<" ";
    while(backEdge!=recStack.top()){
        cout<<recStack.top()<<" ";
        recStack.pop();
    }
    cout<<recStack.top();
    // ofstream g("grafC.out");
    // for(int i:solutie)
    //     g<<i<<" ";
    // g.close();
}