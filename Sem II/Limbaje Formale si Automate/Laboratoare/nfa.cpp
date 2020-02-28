#include <iostream>
#include <map>
#include <string>
#include <set>
#include <fstream>

using namespace std;

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

int main()
{
    NFA M;
    int ok = 0;
    ifstream fin("nfa.txt");
    fin >> M;
    fin.close();
    set<int> test;

    set<int> lastState = M.deltaStar(M.getInitialState(), "aabbb");
    // cout << *M.getF().begin();
    for (int i : lastState)
        if (*M.getF().find(i) == i)
        {
            cout << "Cuvant acceptat";
            ok = 1;
            break;
        }
    if (!ok)
    {
        cout << "Cuvant neacceptat";
    }
    return 0;
}
/*
    int noOfTransitions;
    f >> noOfTransitions;
    for (int i = 0; i < noOfTransitions; ++i)
    {
        int s, d;
        char ch;
        f >> s >> ch >> d;
        M.delta[{s, ch}] = d;
    }
*/