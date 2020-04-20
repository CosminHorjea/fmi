#include <iostream>
#include <map>
#include <string>
#include <set>
#include <fstream>
#include <unordered_map>

using namespace std;

class DFA
{
	set<int> Q, F;
	set<char> Sigma;
	int q0;
	map<pair<int, char>, int> delta;

public:
	DFA() { this->q0 = 0; }
	DFA(set<int> Q, set<char> Sigma, map<pair<int, char>, int> delta, int q0, set<int> F)
	{
		this->Q = Q;
		this->Sigma = Sigma;
		this->delta = delta;
		this->q0 = q0;
		this->F = F;
	}
	set<int> getQ() const { return this->Q; }
	set<int> getF() const { return this->F; }
	set<char> getSigma() const { return this->Sigma; }
	int getInitialState() const { return this->q0; }
	map<pair<int, char>, int> getDelta() const { return this->delta; }

	friend istream &operator>>(istream &, DFA &);

	bool isFinalState(int);
	int deltaStar(int, string);
};

bool DFA::isFinalState(int q)
{
	return F.find(q) != F.end();
}

int DFA::deltaStar(int q, string w)
{
	if (w.length() == 1)
		return delta[{q, (char)w[0]}];
	int new_q = delta[{q, (char)w[0]}];
	return deltaStar(new_q, w.substr(1, w.length() - 1));
}

istream &operator>>(istream &f, DFA &M)
{
	int noOfStates;
	f >> noOfStates;
	for (int i = 0; i < noOfStates; ++i)
	{
		int q;
		f >> q;
		M.Q.insert(q);
	}
	int noOfLetters;
	f >> noOfLetters;
	for (int i = 0; i < noOfLetters; ++i)
	{
		char ch;
		f >> ch;
		M.Sigma.insert(ch);
	}
	int noOfTransitions;
	f >> noOfTransitions;
	for (int i = 0; i < noOfTransitions; ++i)
	{
		int s, d;
		char ch;
		f >> s >> ch >> d;
		M.delta[{s, ch}] = d;
	}
	f >> M.q0;
	int noOfFinalStates;
	f >> noOfFinalStates;
	for (int i = 0; i < noOfFinalStates; ++i)
	{
		int q;
		f >> q;
		M.F.insert(q);
	}
	return f;
}
class DisjointSet
{
	unordered_map<int, int> parent;

public:
	void makeSet(set<int> const &wholeset)
	{
		//perform makeset operation
		for (int i : wholeset) // create n disjoint sets
			parent[i] = i;
	}
	int find(int l)
	{						// Find the root of the set in which element l belongs
		if (parent[l] == l) // if l is root
			return l;
		return find(parent[l]); // recurs for parent till we find root
	}
	void Union(int m, int n)
	{ // perform Union of two subsets m and n
		int x = find(m);
		int y = find(n);
		parent[x] = y;
	}
	bool operator==(DisjointSet rhs)
	{
		return this->parent == rhs.parent;
	}
	unordered_map<int, int> getMap()
	{
		return this->parent;
	}
};
DFA minimizareDFA(DFA M)
{
	map<pair<set<int>, char>, set<int>> mappingTable;
	map<pair<int, char>, int> initialTable = M.getDelta();
	set<set<int>> equiv;
	DisjointSet multime;
	multime.makeSet(M.getQ());
	for (auto i : M.getQ())
	{

		for (auto j : M.getQ())
			if (!M.isFinalState(i) && !M.isFinalState(j))
				multime.Union(i, j);
		break;
	}
	int ok = 1;
	while (ok)
	{
		DisjointSet newForest;
		newForest.makeSet(M.getQ());
		for (auto i : M.getQ())
		{
			for (auto j : M.getQ())
			{
				int areInSameSet = 1;
				for (char c : M.getSigma())
				{
					if (multime.find(initialTable[{i, c}]) != multime.find(initialTable[{j, c}]))
					{
						areInSameSet = 0;
					}
				}
				if (areInSameSet)
				{
					newForest.Union(i, j);
				}
			}
		}
		if (multime == newForest)
		{
			ok = 0;
		}
		multime = newForest;
	}
	for (pair<int, int> i : multime.getMap())
	{
		cout << i.first << " " << i.second << endl;
	}
	//converting the disjoint sets into tha DFA
	set<int> newQ, newF;
	int newQ0;
	map<pair<int, char>, int> newDelta;
	// cout << "NewQ:";
	for (int i : M.getQ())
	{
		newQ.insert(multime.find(i));
		// cout << multime.find(i) << " ";
	}
	// cout << "\nNewF:";
	for (int i : M.getF())
	{
		newF.insert(multime.find(i));
		// cout << multime.find(i) << " ";
	}
	newQ0 = multime.find(M.getInitialState());
	// cout << "\nTable:\n";
	for (int i : M.getQ())
	{
		newDelta[{multime.find(i), 'a'}] = multime.find(initialTable[{multime.find(i), 'a'}]);
		newDelta[{multime.find(i), 'b'}] = multime.find(initialTable[{multime.find(i), 'b'}]);
		// cout << "newDela[" << multime.find(i) << "\'a\']=" << multime.find(initialTable[{multime.find(i), 'a'}]) << "\n";
		// cout << "newDela[" << multime.find(i) << "\'b\']=" << multime.find(initialTable[{multime.find(i), 'b'}]) << "\n";
	}
	DFA r(newQ, M.getSigma(), newDelta, newQ0, newF);
	return r;
}

int main()
{
	DFA M, N;

	ifstream fin("minimizareDFA.in");
	fin >> M;
	fin.close();
	N = minimizareDFA(M);
	int lastState = M.deltaStar(M.getInitialState(), "ababa");
	if (M.isFinalState(lastState))
		cout << "Cuvant acceptat\n";
	else
		cout << "Cuvant neacceptat";
	lastState = N.deltaStar(N.getInitialState(), "ababa");
	if (N.isFinalState(lastState))
		cout << "Cuvant acceptat\n";
	else
		cout << "Cuvant neacceptat";
	return 0;
}