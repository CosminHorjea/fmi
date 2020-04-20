#include <fstream>
#include <iostream>
#include <map>
#include <set>
#include <vector>
#include <string>
#include <unordered_map>
#include <iomanip>

using namespace std;

class DFA
{
	set<int> Q, F;
	set<char> Sigma;
	int q0;
	map<pair<int, char>, int> delta;

public:
	DFA() { this->q0 = 0; }
	DFA(set<int> Q, set<char> Sigma, map<pair<int, char>, int> delta, int q0,
		set<int> F)
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
	friend ostream &operator<<(ostream &, DFA &);
	friend string DFAtoRegEX(DFA &);

	bool isFinalState(int);
	int deltaStar(int, string);
};

bool DFA::isFinalState(int q) { return F.find(q) != F.end(); }

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
ostream &operator<<(ostream &m, DFA &M)
{
	for (map<pair<int, char>, int>::const_iterator it = M.delta.begin();
		 it != M.delta.end(); ++it)
	{
		std::cout << it->first.first << " " << it->first.second << " " << it->second << "\n";
	}
}
string DFAtoRegEX(DFA &M)
{
	/*
	 @param M - dfa-ul pe care il transform in expresie regulata
	 
	 @return string - expresia regulata 
	
	*/
	// !    # - lambda
	int size = M.getQ().size();
	map<pair<int, char>, int> transitions = M.getDelta();
	vector<vector<string>> extendedTransitions; //? should i do this with map? map<pair<int,int>,string>
	for (int i = 0; i <= size + 1; i++)
	{
		vector<string> row;
		for (int j = 0; j <= size + 1; j++)
		{
			row.push_back(" ");
		}
		extendedTransitions.push_back(row);
	}

	for (int stare : M.getQ())
	{
		for (int i = 0; i <= size + 1; i++)
		{
			for (char c : M.getSigma())
				if (transitions.count({stare, c}) > 0 && (transitions[{stare, c}] == i))
					if (extendedTransitions[stare][i] != " ")
					{
						extendedTransitions[stare][i] += "+";
						extendedTransitions[stare][i] += c;
					}
					else
						extendedTransitions[stare][i] = c;
		}
	}

	//fac starile q0(cea care se duce in cea initial) si q(size+1) in care se duc starile finale, nu modific M
	extendedTransitions[0][M.getInitialState()] = "#";
	for (int f : M.getF())
	{
		extendedTransitions[f][size + 1] = "#";
	}
	for (int state : M.getQ())
	{
		string result = "";
		set<int> input;
		set<int> output;
		for (int i = 0; i <= size + 1; ++i)
		{
			if (extendedTransitions[state][i] != " " && i != state)
			{
				output.insert(i);
			}
		}
		for (int i = 0; i <= size + 1; ++i)
		{
			if (extendedTransitions[i][state] != " " && i != state)
			{
				input.insert(i);
			}
		}

		for (int i : input)
		{
			for (int j : output)
			{
				string loop = "";
				if (extendedTransitions[state][state] != " ")
				{
					loop += "(" + extendedTransitions[state][state] + ")*";
				}
				if (state != i && state != j)
				{
					if (extendedTransitions[i][state] != "#" && extendedTransitions[i][state] != " ")
					{
						result += "(" + extendedTransitions[i][state] + ")";
					}
					result += loop;
					if (extendedTransitions[state][j] != "#" && extendedTransitions[state][j] != " ")
					{
						result += "(" + extendedTransitions[state][j] + ")";
					}
				}
				if (extendedTransitions[i][j] != " ")
					extendedTransitions[i][j] += "+" + result;
				else
					extendedTransitions[i][j] = result;
				result = "";
			}
		}
		for (int i = 0; i < size + 1; i++) //sterg starea din matrice
		{
			extendedTransitions[i][state] = " ";
			extendedTransitions[state][i] = " ";
		}
		// for (int i = 0; i <= size + 1; i++) //afisare matrice la un anumit moment
		// {
		// 	cout << i << ": ";
		// 	for (int j = 0; j <= size + 1; j++)
		// 	{
		// 		cout << setw(16) << extendedTransitions[i][j] << ", ";
		// 	}
		// 	cout << endl;
		// }
		// cout << "\n---------------\n";
	}

	return extendedTransitions[0][size + 1];
}

int main()
{
	DFA M, N;

	ifstream fin("DFAtoRegEX.in");
	fin >> M;
	fin.close();
	// cout << M;

	cout << DFAtoRegEX(M);
	return 0;
}