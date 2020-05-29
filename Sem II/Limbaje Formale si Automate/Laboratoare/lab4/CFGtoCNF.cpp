/*
	Ideea de rezolvare a fost preluata din materilul: https://drive.google.com/file/d/1R6IvOee4YIGike9ckV_-2cdl0y_9CAq6/view

*/

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
char last = 'A';

char getNewSymbol(set<char> N)
{
	while (N.find(last) != N.end())
		last++;
	return last;
}

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
	N.insert('T');
	N.insert('U');
	N.insert('V');
	N.insert('X');
	N.insert('Y');
	P['S'].insert("T");
	P['S'].insert("U");
	P['S'].insert("X");
	P['T'].insert("VaT");
	P['T'].insert("VaV");
	P['T'].insert("TaV");
	P['U'].insert("VbU");
	P['U'].insert("VbV");
	P['U'].insert("UbV");
	P['V'].insert("aVbV");
	P['V'].insert("bVaV");
	P['V'].insert("*");
	P['X'].insert("Y");
	P['Y'].insert("X");
	Sigma.insert('a');
	Sigma.insert('b');
	Sigma.insert('*');

	S = 'S';
}

void removeUseless()
{
	set<char> N1 = {};
	unsigned i = 0;
	while (i <= N1.size())
	{
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
		i++;
	}
	if (N1.find(S) == N1.end())
		return;
	vector<char> N2 = {S};
	i = 0;
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

void extractNonTerminals()
{
	map<char, char> nonT;
	set<char> newN = N;
	for (char nonTerm : N)
	{
		set<string> newProds;
		for (string prod : P[nonTerm])
		{
			string newProd = "";
			for (int i = 0; i < prod.length(); i++)
			{
				if ((N.find(prod[i]) == N.end()) && prod[i] != '*') //daca e terminal
				{
					if (nonT.count(prod[i])) // daca deja am facut productia
					{
						newProd += nonT[prod[i]];
					}
					else
					{
						nonT[prod[i]] = getNewSymbol(newN); // fac un neterminal nou
						newProd += nonT[prod[i]];
						P[nonT[prod[i]]].insert(string(1, prod[i]));
						newN.insert(nonT[prod[i]]);
					}
				}
				else
				{
					newProd += prod[i];
				}
			}
			newProds.insert(newProd);
		}
		P[nonTerm] = newProds;
	}
	N = newN;
}

void cutProductions() //sparg productiile care au lungime >2
{
	set<char> newN = N;

	for (char nonT : N)
	{
		set<string> newStrings;
		for (string s : P[nonT])
		{
			// if (s.length() <= 2)
			// {
			// 	newStrings.insert(s);
			// }
			while (s.length() > 2)
			{
				string lastTwo = s.substr(s.length() - 2);
				char newNonT = getNewSymbol(newN);
				newN.insert(newNonT);
				P[newNonT].insert(lastTwo);
				s = s.substr(0, s.length() - 2) + newNonT;
			}
			newStrings.insert(s);
		}
		P[nonT] = newStrings;
	}
	N = newN;
}

void lambdaProd()
{
	set<char> onlyLambda, lambda;
	for (char nonT : N)
	{
		for (string s : P[nonT])
		{
			if (s == "*")
			{
				if (P[nonT].size() == 1)
				{

					onlyLambda.insert(nonT);
					P[nonT] = {};
					N.erase(nonT);
				}
				else
				{
					lambda.insert(nonT);
					P[nonT].erase("*");
					break;
				}
			}
		}
	}
	for (char nonT : N)
	{
		set<string> newProds = P[nonT];

		for (string s : P[nonT])
		{
			string newS = s;
			for (int i = 0; i < s.length(); i++)
			{
				if (onlyLambda.find(s[i]) != onlyLambda.end())
				{
					newProds.erase(s);
					s.erase(i, 1);
					newProds.insert(s);
					i--;
				}
				else if (lambda.find(s[i]) != lambda.end())
				{
					newS.erase(i, 1);
					newProds.insert(newS);
					newS = s;
				}
			}
		}
		P[nonT] = newProds;
	}
}

void removeUnitProd()
{
	int ok = 1;
	do
	{
		ok = 1;
		for (char nonT : N)
		{
			set<string> newProds;
			for (string s : P[nonT])
			{
				if (s.length() == 1 && N.find(s[0]) != N.end()) //daca este o prod de lungime unu si nu este simbol terminal
				{
					for (string s2 : P[s[0]])
					{
						if (s2.length() == 1)
							ok = 0;
						newProds.insert(s2);
					}
				}
				else
				{
					newProds.insert(s);
				}
			}
			P[nonT] = newProds;
		}
	} while (!ok);
}

int main()
{
	configGrammar();
	for (char c : N)
	{
		cout << c << ": ";
		for (string s : P[c])
		{
			cout << s << "|";
		}
		cout << endl;
	}
	removeUseless();
	// lambdaProd();
	extractNonTerminals();
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
	cutProductions();
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
	removeUnitProd();
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