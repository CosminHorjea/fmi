#include <iostream>
#include <map>
#include <string>
#include <set>
#include <fstream>
#include <unordered_map>

using namespace std;

class DFA
{
	// Implementarea DFA este aceeasi ca la laborator
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
	unordered_map<int, int> parent; // fac un vector de tati pentru multimi

public:
	void makeSet(set<int> const &wholeset)
	{
		// creez un set pentru fiecare element
		for (int i : wholeset)
			parent[i] = i;
	}
	int find(int l)
	{							// gasesc reprezentantul multimii
		if (parent[l] == l)		// daca nodul este radacina
			return l;			// acela este reprezentant
		return find(parent[l]); // merg recursiv din nod in parinte si tot asa
	}
	void Union(int m, int n)
	{ // unesc doua multimi
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
	/*
		Pentru algoritmul implementat am folosit tutorialul https://www.youtube.com/watch?v=0XaGAkY09Wc
		

		@param M - DFA-ul pentru care fac minimizarea
		@returns DFA - un DFA nou care e minimizarea lui M
	*/
	map<pair<int, char>, int> initialTable = M.getDelta();
	DisjointSet multime;	   // fac n obiect de paduri disjuncte
	multime.makeSet(M.getQ()); // fiecare nod sta in propria multime
	for (auto i : M.getQ())	   // pentru fiecare nod
	{
		for (auto j : M.getQ())
		{
			if (!M.isFinalState(i) && !M.isFinalState(j)) // daca nu sunt stari finale
				multime.Union(i, j);					  // de pun in aceeasi multime
			if (M.isFinalState(i) && M.isFinalState(j))
				multime.Union(i, j); // daca sunt stari finale
									 // ?break;
		}
	} // acum am starile nefinale intr-o multiem si cele finale in alta
	int ok = 1;
	while (ok)
	{
		// realizez k-echivalenta pana ajung la doua seturi de multimi disjuncte care sunt egale
		DisjointSet newForest;
		newForest.makeSet(M.getQ()); // fac multimi noi din starile automatului
		for (auto i : M.getQ())
		{
			for (auto j : M.getQ())
			{
				int areInSameSet = 1; // presupun ca sunt in acelasi set unde fiecare nod e intr-o singura multime
				for (char c : M.getSigma())
				{
					if (multime.find(initialTable[{i, c}]) != multime.find(initialTable[{j, c}])) // daca o stare cu o tranzitie ajunge intr-o stare care se afla in alta multime
					{
						areInSameSet = 0; // nu sunt in aceeasi multime si le las asa
					}
				}
				if (areInSameSet)
				{
					newForest.Union(i, j); // daca ajung in stari care sunt in aceeasi multime, le unesc
				}
			}
		}
		if (multime == newForest)
		{
			ok = 0; // daca multime nou formata este aceeasi cu cea anterioara ma opresc
		}
		multime = newForest; //schimb multimea de baza cu cea nou formata
	}
	//convertesc seturile disjuncte in DFA
	set<int> newQ, newF;
	int newQ0;
	map<pair<int, char>, int> newDelta; // variabilele pentru creeare noului DFA
	// cout << "NewQ:";
	for (int i : M.getQ())
	{
		newQ.insert(multime.find(i)); // inserez doar reprezentantul multimii in care se afla o stare
									  // cout << multime.find(i) << " ";
	}
	// cout << "\nNewF:";
	for (int i : M.getF())
	{
		newF.insert(multime.find(i)); //inserez reprezentantul fiecarei stari finale
									  // cout << multime.find(i) << " ";
	}
	newQ0 = multime.find(M.getInitialState()); // inserez reprezentatnul starii finale
	// cout << "\nTable:\n";
	for (int i : M.getQ()) // pentru fiecare stare
	{
		for (char c : M.getSigma()) // iau fiecare caracter
		{
			newDelta[{multime.find(i), c}] = multime.find(initialTable[{multime.find(i), c}]);
			// in noul delta tranzitionez doar intre reprezentantii multimilor
			//si starilor in care fac tranzitia cu caracterul c
		}
	}
	DFA r(newQ, M.getSigma(), newDelta, newQ0, newF); //construiesct noul DFA si il returnez
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