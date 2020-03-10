#include <iostream>
#include <map>
#include <string>
#include <set>
#include <fstream>
#include <queue>

using namespace std;
class DFA;
class NFA;

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

    // friend istream &operator>>(istream &, DFA &);

    bool isFinalState(int);
    int deltaStar(int, string);

    friend DFA nfaToDfa(NFA M);
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

// istream &operator>>(istream &f, DFA &M)
// {
//     int noOfStates;
//     f >> noOfStates;
//     for (int i = 0; i < noOfStates; ++i)
//     {
//         int q;
//         f >> q;
//         M.Q.insert(q);
//     }
//     int noOfLetters;
//     f >> noOfLetters;
//     for (int i = 0; i < noOfLetters; ++i)
//     {
//         char ch;
//         f >> ch;
//         M.Sigma.insert(ch);
//     }
//     int noOfTransitions;
//     f >> noOfTransitions;
//     for (int i = 0; i < noOfTransitions; ++i)
//     {
//         int s, d;
//         char ch;
//         f >> s >> ch >> d;
//         M.delta[{s, ch}] = d;
//     }
//     f >> M.q0;
//     int noOfFinalStates;
//     for (int i = 0; i < noOfFinalStates; ++i)
//     {
//         int q;
//         f >> q;
//         M.F.insert(q);
//     }
//     return f;
// }

class NFA
{
    set<int> Q, F;
    set<char> Sigma;
    set<int> q0;
    map<pair<int, char>, set<int>> delta;

public:
    NFA() { this->q0.insert(0); }
    NFA(set<int> Q, set<char> Sigma, map<pair<int, char>, set<int>> delta, set<int> q0, set<int> F)
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
    set<int> getInitialState() const { return this->q0; }
    map<pair<int, char>, set<int>> getDelta() const { return this->delta; }

    friend istream &operator>>(istream &, NFA &);

    bool isFinalState(int);
    set<int> deltaStar(set<int>, string);

    friend DFA nfaToDfa(NFA M);
};

bool NFA::isFinalState(int q)
{
    return F.find(q) != F.end();
}

set<int> NFA::deltaStar(set<int> s, string w)
{
    int n = w.length();
    set<int> localFinalStates;
    // set<int>::iterator it = s.begin();
    for (int j : delta[{*s.begin(), w[0]}])
    {
        localFinalStates.insert(j);
    }
    n--;
    if (n == 0)
        return localFinalStates;

    int contor = 0;
    while (n)
    {
        set<int> auxiliar;

        for (int i : localFinalStates)
        {
            for (int j : delta[{i, w[contor + 1]}])
                auxiliar.insert(j);
        }
        n--;
        contor++;

        localFinalStates.clear();

        for (int i : auxiliar)
            localFinalStates.insert(i);
        auxiliar.clear();
    }
    return localFinalStates;
}

istream &operator>>(istream &f, NFA &M)
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
    int nrTranzitiiDelta;
    f >> nrTranzitiiDelta;
    for (int i = 0; i < nrTranzitiiDelta; ++i)
    {
        int stareInit;
        f >> stareInit;
        char ch;
        f >> ch;
        int nrStari;
        f >> nrStari;
        for (int j = 0; j < nrStari; ++j)
        {
            int legtura;
            f >> legtura;
            M.delta[{stareInit, ch}].insert(legtura);
        }
    }
    int q0;
    f >> q0;
    M.q0.insert(q0);

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

DFA nfaToDfa(NFA M)
{
    map<pair<set<int>, char>, set<int>> mappingTable;
    queue<set<int>> states;
    states.push(M.getInitialState());
    while (!states.empty())
    {
        set<int> i = states.front();
        for (int j : M.delta[{*i.begin(), 'a'}])
        {
            cout << "Hello";
        }
        states.pop();
    }
    DFA aux;
    return aux;
}
int main()
{
    ifstream f("nfatodfa.txt");
    NFA M;
    DFA R;
    f >> M;
    R = nfaToDfa(M);
}