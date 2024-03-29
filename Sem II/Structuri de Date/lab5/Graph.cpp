#include <iostream>
#include <list>
#include <vector>
#include <queue>
#include <set>
#include <stack>
using namespace std;

class directedGraph
{
	vector<list<int>> adiacenta;

public:
	void addNode(int a)
	{
		if (a >= adiacenta.size())
		{
			adiacenta.resize(a + 1, list<int>());
		}
		adiacenta[a] = list<int>();
	}
	void addEdge(int source, int target)
	{
		adiacenta[source].push_back(target);
	}
	int hasEdge(int source, int target)
	{
		for (list<int>::iterator it = adiacenta[source].begin(); it != adiacenta[source].end(); ++it)
		{
			if (*it == target)
			{
				return true;
			}
		}
		return false;
	}
	void BFS(int startNode)
	{
		int v;
		queue<int> q;
		set<int> visited;
		q.push(startNode);
		visited.insert(startNode);
		while (q.size())
		{
			v = q.front();
			q.pop();
			cout << v << " ";
			for (int i : adiacenta[v])
			{
				if (visited.find(i) == visited.end())
				{
					q.push(i);
					visited.insert(i);
				}
			}
		}
	}
	void DFS(int startNode)
	{
		vector<bool> visited(adiacenta.size(), false);
		DFSrec(startNode, visited);
	};
	void DFSrec(int n, vector<bool> visited)
	{
		visited[n] = true;
		cout << n << " ";

		for (int i : adiacenta[n])
		{
			if (!visited[i])
			{
				DFSrec(i, visited);
			}
		}
	}
	int twoCycles()
	{
		int res = 0;
		for (int i = 0; i < adiacenta.size(); i++)
		{
			for (int j : adiacenta[i])
				if (i != j && this->hasEdge(j, i))
					res++;
		}
		return res / 2;

	}; //numara cele doua cicluri din graf (ex 3->5 si 5->3 e un 2-ciclu)

	//TODO Imbunatatiti performanta lui hasEdge
	// * se presupune ca numarul si id-urile nodurilor sunt marginite la 10000
};

int main()
{
	directedGraph g;
	g.addNode(0);
	g.addNode(1);
	g.addNode(2);
	g.addNode(3);
	g.addEdge(1, 2);
	g.addEdge(2, 1);
	g.addEdge(1, 3);
	g.addEdge(3, 1);
	g.addEdge(3, 0);
	cout << "DFS(1): ";
	g.DFS(3);
	cout << endl
		 << "BFS(1): ";
	g.BFS(1);
	cout << endl;
	// cout << g.hasEdge(1, 3);
	cout << "Cicluri de lungime 2: ";
	cout << g.twoCycles();
}