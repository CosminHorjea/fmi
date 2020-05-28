#include <iostream>
#include <set>
#include <map>
#include <string>
#include <vector>

using namespace std;

map<char, set<string>> P; //productii
set<char> N;			  // netermiale
set<char> Sigma;		  //alfabet
char S;
// ! *-lambda

void configGrammar()
{
	// P['S'].insert("AB");
	// P['S'].insert("BC");
	// P['A'].insert("AB");
	// P['A'].insert("a");
	// P['B'].insert("CC");
	// P['B'].insert("b");
	// P['C'].insert("AB");
	// P['C'].insert("a");
	N.insert('S');
	N.insert('A');
	// N.insert('B');
	// N.insert('C');
	N.insert('X');
	N.insert('Y');
	P['S'].insert("A");
	P['A'].insert("XaYb");
	P['X'].insert("x");
	P['X'].insert("*");
	P['Y'].insert("y");
	P['Y'].insert("*");

	Sigma.insert('a');
	Sigma.insert('b');
	Sigma.insert('x');
	Sigma.insert('y');
	S = 'S';
}

void removeUseless()
{
	set<char> N1 = {};
	for (char A : N)
	{
		for (const string p : P[A])
		{
			int ok = 1;
			for (char c : p)
			{
				if (Sigma.find(c) == Sigma.end() && N1.find(c) == N1.end())
				{
					ok = 0;
				}
			}
			if (ok && (N1.find(A) == N1.end()))
			{
				N1.insert(A);
			}
		}
	}
	if (N1.find(S) == N1.end())
		return;
	vector<char> N2 = {S};
	int i = 0;
	while (i < N2.size())
	{
		for (string p : P[N2[i]])
		{
			for (char n : p)
			{
				if ((N.find(n) != N.end()))
				{
					int found = 0;
					for (char aux : N2)
					{
						if (aux == n)
							found = 1;
					}
					if (!found)
					{
						N2.push_back(n);
					}
				}
			}
		}
		i++;
	}
	set<char> finalN;
	for (char c : N2)
	{
		if (N1.find(c) != N1.end())
		{
			finalN.insert(c);
		}
	}
	N = finalN;
	map<char, set<string>> P2 = P;

	for (char n : N)
		for (string s : P2[n])
			for (char c : s)
				if ((N.find(c) == N.end()) && (Sigma.find(c) == Sigma.end()))
					P[n].erase(s);
}

void lambdaProd()
{
	set<char> Na;
	map<char, set<string>> P1 = P;
	char S1 = S;
	for (char A : N)
	{
		for (string s : P[A])
		{
			if (s == "*")
				Na.insert(A);
		}
	}

	int ok = 1;
	// while (ok)
	// {
	// 	ok = 0;
	// 	for (char A : N)
	// 	{
	// 		for (string s : P[A])
	// 		{
	// 			int canAdd = 1;
	// 			for (char c : s)
	// 			{
	// 				if (N.find(c) == N.end() && Na.find(c) == Na.end())
	// 					canAdd = 0;
	// 			}
	// 			if (canAdd && Na.find(A) == Na.end())
	// 			{
	// 				Na.insert(A);
	// 				ok = 1;
	// 			}
	// 		}
	// 	}
	// }

	if (Na.find(S) != Na.end())
	{
		P1['Z'].insert("" + S);
		S1 = 'Z';
	}

	for (char A : N)
	{
		for (string s : P[A])
		{
			for (int i = 0; i < s.size(); i++)
			{
				if (Na.find(s[i]) != Na.end())
					if (P[s[i]].size() == 1)
					{
						P1[A].erase(s);
						s.erase(i);
						P1[A].insert(s);
						i--;
					}
					else
					{
						string newS = s;
						newS.erase(i);
						cout << newS << ">";
						P1[A].insert(newS);
					}
			}
		}
	}
	for (char c : Na)
	{
		if (P[c].size() == 1)
			N.erase(c);
	}
	P = P1;
	S = S1;
}
int main()
{
	configGrammar();
	removeUseless();
	lambdaProd();
	cout << "\n============\n";
	for (char c : N)
	{
		cout << c << ": ";
		for (string s : P[c])
		{
			cout << s << "|";
		}
		cout << endl;
	}
}
