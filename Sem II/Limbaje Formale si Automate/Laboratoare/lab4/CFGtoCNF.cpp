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
	/*
		Functie care imi intoarece un simbol pentru un NonTerminal nou, nefolosit in N din param
	*/
	while (N.find(last) != N.end())
		last++;
	return last;
}

void configGrammar() //configurez gramatica
{
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

void removeUseless() //Elimin simbolurile newfolositoare
{
	/*
		Metoda folosita din Cursul 8 (LFA), Teorema 1
	*/
	set<char> N1 = {}; // o multime noua pentru simbolurile folositoare
	unsigned i = 0;
	while (i <= N1.size()) //cat timp adaug nonterminale noi
	{
		for (char A : N) // iau fiecare nonterminal
		{
			for (const string p : P[A]) // iau fiecare productie
			{
				int ok = 1;
				for (char c : p)
				{
					if (Sigma.find(c) == Sigma.end() && N1.find(c) == N1.end()) //daca caracterul nu este din alfabet sau din multimea nou initializata
					{
						ok = 0; // nu e ok si nu o adaug
					}
				}
				if (ok && (N1.find(A) == N1.end())) //daca e ok si nu e deja in multime adaug nonterminalul
				{
					N1.insert(A);
				}
			}
		}
		i++;
	}
	if (N1.find(S) == N1.end()) //daca S nu e in multimea formata ies din functie
		return;
	vector<char> N2 = {S}; //plec din S
	i = 0;
	while (i < N2.size()) //cat timp adaug
	{
		for (string p : P[N2[i]]) //iau productiile
		{
			for (char n : p)
			{
				if ((N.find(n) != N.end())) //daca caracterul este terminal
				{
					int found = 0;
					for (char aux : N2) //il caut in multimea N2
					{
						if (aux == n)
							found = 1;
					}
					if (!found) //daca nu l-am gasit il adaug
					{
						N2.push_back(n);
					}
				}
			}
		}
		i++;
	}

	set<char> finalN;
	for (char c : N2) //fac intersectia celor doua multimi
	{
		if (N1.find(c) != N1.end())
		{
			finalN.insert(c);
		}
	}
	N = finalN;
	map<char, set<string>> P2 = P; //modific productiile

	for (char n : N)
		for (string s : P2[n])
			for (char c : s)
				if ((N.find(c) == N.end()) && (Sigma.find(c) == Sigma.end())) //daca simbolul nu e folositor
					P[n].erase(s);											  //il sterg
}

void extractNonTerminals() //pentru fiecare simbol termial, ii fac o productie noua cu un nonterminal care duce in el
{
	map<char, char> nonT; // nonTerminalele noi si catre ce caracter duc
	set<char> newN = N;	  //noua multime N
	for (char nonTerm : N)
	{
		set<string> newProds; //productiile care urmeaza sa fie facute
		for (string prod : P[nonTerm])
		{
			string newProd = ""; //productia care trebuie construita
			for (int i = 0; i < prod.length(); i++)
			{
				if ((N.find(prod[i]) == N.end()) && prod[i] != '*') //daca e terminal
				{
					if (nonT.count(prod[i])) // daca deja am facut productia
					{
						newProd += nonT[prod[i]]; // doar o adaug
					}
					else
					{
						nonT[prod[i]] = getNewSymbol(newN);			 // fac un neterminal nou
						newProd += nonT[prod[i]];					 //adaug la productie
						P[nonT[prod[i]]].insert(string(1, prod[i])); //inserez productia in P
						newN.insert(nonT[prod[i]]);					 //N are un nou neterminal
					}
				}
				else
				{
					newProd += prod[i]; // altfel doar adaug litera la productie
				}
			}
			newProds.insert(newProd); //adaug productia in setul de productii
		}
		P[nonTerm] = newProds; // modific vechile productii cu cele noi
	}
	N = newN; //actualizez neterminalele
}

void cutProductions() //sparg productiile care au lungime >2
{
	set<char> newN = N;

	for (char nonT : N)
	{
		set<string> newStrings;
		for (string s : P[nonT]) //iau fiecare productie
		{
			while (s.length() > 2) //cat timp lungimea e mai mare ca 2
			{
				string lastTwo = s.substr(s.length() - 2); //iau ultimele doua litere
				char newNonT = getNewSymbol(newN);		   //fac un neterminal nou
				newN.insert(newNonT);					   //il inserez in netermnale
				P[newNonT].insert(lastTwo);				   //il pun in vectorul de productii
				s = s.substr(0, s.length() - 2) + newNonT; // inlocuiesc ultimele doua litere cu simbolul nou
			}
			newStrings.insert(s); //adaug s la noile productii, pentru ca are lungime 2
		}
		P[nonT] = newStrings; //actualizez productiile din neterminalul curent
	}
	N = newN; //actualizez neterminalele
}

void lambdaProd()
{
	/*
	 * Elimin Lambda productiile 
	 */
	set<char> onlyLambda, lambda; //un vector cu nonterminalele care duc DOAR in lambda
								  //si unul cu cele care duc si in alte productii
	for (char nonT : N)
	{
		for (string s : P[nonT])
		{
			if (s == "*") //daca e o productie lambda
			{
				if (P[nonT].size() == 1) //daca aceasta este singra
				{

					onlyLambda.insert(nonT);
					P[nonT] = {}; //il sterg direct
					N.erase(nonT);
				}
				else
				{ //daca formeaza mai multe productii, ii sterg productia cu lambda si ies din loop
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
			string newS = s; //o copie a lui s
			//pentru fiecare productie
			for (int i = 0; i < s.length(); i++)
			{
				if (onlyLambda.find(s[i]) != onlyLambda.end()) //daca caracterul este terminal cu o singura tranzitie in lambda
				{
					//sterg caracterul din  s si il adaug in noile productii
					newProds.erase(s);
					s.erase(i, 1);
					newProds.insert(s);
					i--;
				}
				else if (lambda.find(s[i]) != lambda.end()) //daca este un nonterminal care mai are si alte productii
				{
					newS.erase(i, 1);	   //sterg caracterul din copia lui s
					newProds.insert(newS); //il adaug in productiile noi
					newS = s;			   //il resetez
				}
			}
		}
		P[nonT] = newProds; //actualizez productiile
	}
}

void removeUnitProd()
{
	/*
	 * Modific tranzitiile care dun intr-un singur alt neterminal 
	 */
	int ok = 1;
	do //cat timp am schimbat productiile
	{
		ok = 1;
		for (char nonT : N)
		{
			set<string> newProds;
			for (string s : P[nonT])
			{
				if (s.length() == 1 && N.find(s[0]) != N.end()) //daca este o prod de lungime unu si nu este simbol terminal
				{
					for (string s2 : P[s[0]]) //iau productiile din acel neterminal
					{
						if (s2.length() == 1) //daca acelea sunt de lungime unu
							ok = 0;			  //mai trebuie sa fac o parcurgere
						newProds.insert(s2);  //adaug productiile din acel caracter in cele noi
					}
				}
				else
				{
					newProds.insert(s); //daca nu le adaug pe cele vechi
				}
			}
			P[nonT] = newProds; //actualizez productiile
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
	cout << "\n Sterg simbolurile nefolositoare: \n";
	for (char c : N)
	{
		cout << c << ": ";
		for (string s : P[c])
		{
			cout << s << "|";
		}
		cout << endl;
	}
	extractNonTerminals();
	cout << "\n Separ nonTerminalele: \n";
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
	cout << "\n Reduc toate productiile la lungime >2: \n";
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
	cout << "\n Elimin lambdaProductiile: \n";
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
	cout << "\nElimin productiile unitate: \n";
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