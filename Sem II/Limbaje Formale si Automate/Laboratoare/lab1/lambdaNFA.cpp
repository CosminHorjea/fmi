#include <iostream>
#include <map>
#include <string>
#include <set>
#include <fstream>
#include <queue>

using namespace std;

class LNFA
{
    set<int> Q, F;
    set<char> Sigma;
    set<int> q0;
    map<pair<int, char>, set<int>> delta;

public:
    LNFA() { this->q0.insert(0); }
    LNFA(set<int> Q, set<char> Sigma, map<pair<int, char>, set<int>> delta, set<int> q0, set<int> F)
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

    friend istream &operator>>(istream &, LNFA &);

    bool isFinalState(int);
    set<int> deltaStar(set<int>, string);

    set<int> lambdaInchidere(int);
};

bool LNFA::isFinalState(int q)
{
    return F.find(q) != F.end();
}

set<int> LNFA::deltaStar(set<int> s, string w)
{
    int n = w.length();
    set<int> localFinalStates;
    s = lambdaInchidere(*s.begin());
    for (int i : s)
    {
        for (int j : delta[{i, w[0]}])
        {
            localFinalStates.insert(j);
        }
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
            for (int k : lambdaInchidere(i))
                for (int j : delta[{k, w[contor + 1]}])
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

set<int> LNFA::lambdaInchidere(int q)
{
    set<int> elements = delta[{q, '*'}];
    elements.insert(q);
    queue<int> toVisit;
    for (int i : elements)
        toVisit.push(i);
    while (!toVisit.empty())
    {
        int curr = toVisit.front();
        elements.insert(curr);
        for (int i : delta[{curr, '*'}])
        {
            if (elements.find(i) == elements.end()) // daoar daca nu am selectat deja elem ala, altfel ar fi un ciclu infinit
                toVisit.push(i);
        }
        toVisit.pop();
    }
    return elements;
}

istream &operator>>(istream &f, LNFA &M)
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
    M.Sigma.insert('*'); // ch lambda de la LNFA
    for (int i = 0; i < noOfLetters; ++i)
    {
        char ch;
        f >> ch;
        M.Sigma.insert(ch);
    }
    int nrTranzitiiDelta;
    f >> nrTranzitiiDelta; // aici nu eram sigur ce numar, deci e daor numarul de reanduri ce urmeaza sa fie scrise sub forma stare init ch nr stari etc..
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
    LNFA M;
    int ok = 0;
    // ifstream fin("LNFA.txt");
    // ifstream fin("LNFA.txt");
    // ifstream fin("LFAtest1.txt");
    // ifstream fin("LFAtest2.txt");
    ifstream fin("testptLNFA.txt");
    fin >> M;
    fin.close();
    set<int> test;

    set<int> lastState = M.deltaStar(M.getInitialState(), "aba");

    for (int i : lastState)
    { // trebuie sa verific lambda tranzitiile state-urilor finale, deci le adaug
        for (int j : M.lambdaInchidere(i))
        {
            lastState.insert(j);
        }
    }
    // for (int i : lastState)
    // {
    //     cout << i << " ";
    // }

    for (int i : lastState)
        if (M.isFinalState(i))
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
