#include <iostream>
#include <list>
#include <vector>
#include <queue>
#include <set>
#include <stack>
#include "BST.h"
#include "Node.h"
using namespace std;

class directedGraph
{
	// Daca folosim un BST in loc de o lista de adiacenta ,atunci timpul necesar pentru
	//a verifica daca exista o muchie exista este (in medie) O(logN)
	vector<BST *> adiacenta;

public:
	void addNode(int a)
	{
		if (a >= adiacenta.size())
		{
			adiacenta.resize(a + 1, NULL);
		}
		adiacenta[a] = new BST();
	}
	void addEdge(int source, int target)
	{
		adiacenta[source]->insert(target);
	}
	int hasEdge(int source, int target)
	{
		if (adiacenta[source]->findNode(target) != NULL)
		{
			return true;
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
			for (int i : adiacenta[v]->getNodes())
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

		for (int i : adiacenta[n]->getNodes())
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
			for (int j : adiacenta[i]->getNodes())
				if (i != j && this->hasEdge(j, i))
					res++;
		}
		return res / 2;
	};
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
	cout << "Cicluri de lungime 2: ";
	cout << g.twoCycles();
	cout << endl
		 << "Muchie intre 3 si 2: ";
	cout << g.hasEdge(3, 2);
}