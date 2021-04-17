#include <bits/stdc++.h>

using namespace std;

double mutationRate;
int a, b;            //intervalul pe care caut maximul
vector<int> coef(3); //coeficientii ecuatiei de gradul 2
int precision;
int generationsNumber;
double crossoverRate;
int totalPopulation;
int genesLength; // numarul de gene

class Cromozom;
Cromozom *population; // un vector care reprezinta populatia

ofstream g("output.txt");

double f(double x)
{
  /**
   *  Calculez valoare functiei in punctul x
   */
  return coef[0] * pow(x, 2) + coef[1] * x + coef[2];
}
class Cromozom
{
public:
  bitset<50> genes; // folosim un sir binar pentru a reprezenta genele, alocam 50 de spatii, dar o sa ne folosim de ei in functie de nivelul de precizie
  double fitness;   //scorul fiecarui individ

  Cromozom()
  {
    /*
    * Cand se apeleaza constructorul, se construieste un sir de gene la intamplare
    */
    for (int i = 0; i < genesLength; i++)
    {
      genes[i] = (rand() % 2);
    }
  }
  void computeFitness()
  {
    /*
    * calculam scorul pentru un individ
    */
    fitness = f(this->getNumber());
  }
  pair<Cromozom, Cromozom> crossover(Cromozom partner, bool afisare)
  {
    /*
      Incrucisare pentru cazul cu doi parteneri care participa la reproducere
      afisare- un parametru care este setat "true" pentru prima generatie cu scopul de a scrie in fisierul output

      @returns - o pereche de doi indivizi 
    */

    Cromozom child1 = Cromozom();
    Cromozom child2 = Cromozom();
    int midpoint = (int)(rand() % genesLength); //gasim un punct de taiere
    if (afisare)
      g << this->getGenes() << " " << partner.getGenes() << " punct " << midpoint << endl;
    for (int i = 0; i < genesLength; i++)
    {
      if (i > midpoint) //daca suntem dupa punctul de taiere, copii pastreaza genele parintilor initiali
      {
        child1.genes[i] = genes[i];
        child2.genes[i] = partner.genes[i];
      }
      else // altfel, copilul 1 ia genele parintelui 2 iar copilul 2 genele parintelui 1
      {
        child1.genes[i] = partner.genes[i];
        child2.genes[i] = genes[i];
      }
    }
    if (afisare)
    {
      g << "Rezultat " << child1.getGenes() << " " << child2.getGenes() << endl;
    }
    return {child1, child2};
  }
  vector<Cromozom> threeCrossover(Cromozom partner2, Cromozom partner3, bool afisare)
  {
    /*
      Incrucisare pe cazul cu 3 indivizi care participa la reproducere

      @return - un vector cu 3 elemente care contine cei 3 descendenti
    */
    Cromozom child1 = Cromozom();
    Cromozom child2 = Cromozom();
    Cromozom child3 = Cromozom();
    int midpoint1 = (int)(rand() % (2 * genesLength / 3));                 // alegem un prim punct de taiere in primele doua treimi
    int midpoint2 = (int)(rand() % (genesLength - midpoint1) + midpoint1); // pe al doilea il alegem dupa primul punct
    while (midpoint2 == midpoint1)
    { // ne asiguram ca nu alegem alcelasi punct de doua ori
      midpoint2 = (int)(rand() % (genesLength - midpoint1) + midpoint1);
    }
    if (afisare)
      g << this->getGenes() << " " << partner2.getGenes() << " " << partner3.getGenes() << " puncte " << midpoint1 << " si " << midpoint2 << endl;
    for (int i = 0; i < genesLength; i++)
    {
      if (i < midpoint1)
      {
        child1.genes[i] = partner2.genes[i];
        child2.genes[i] = partner3.genes[i];
        child3.genes[i] = genes[i];
        continue;
      }
      if (i < midpoint2)
      {
        child1.genes[i] = genes[i];
        child2.genes[i] = partner2.genes[i];
        child3.genes[i] = partner3.genes[i];
        continue;
      }
      child1.genes[i] = partner3.genes[i];
      child2.genes[i] = genes[i];
      child3.genes[i] = partner2.genes[i];
    }
    if (afisare)
    {
      g << "Rezultat " << child1.getGenes() << " " << child2.getGenes() << " " << child3.getGenes() << endl;
    }
    return {child1, child2, child3};
  }
  bool mutate(double mutationRate)
  {
    /*
      Functie care trece prin fiecare gene si incearca sa aplice o mutatie

      @returns bool, true - daca s-a produs o mutatie in tot cromozomul
    */
    int didMutate = 0;
    for (int i = 0; i < genesLength; i++)
    {
      if (((double)rand() / (RAND_MAX)) < mutationRate)

      {
        didMutate = 1;
        genes[i] = (rand() % 2);
      }
    }
    return didMutate;
  }
  double getNumber()
  {
    /*
      Converteste sirul de biti (genele) intr-un numar din intervalul nostru
    */
    return (b - a) / (pow(2, genesLength) - 1) * genes.to_ulong() + a;
  }
  string getGenes()
  {
    /*
      Prentru afisare in fisier, luam sirul de biti va un string si scoatem zerourile din fata
    */
    return genes.to_string().substr(genes.size() - genesLength);
  }
};

int binarySearch(vector<double> q, double r)
{
  /*
    Cautam intervalul din q in care se afla r folosind cautarea binara
  */
  int left = 0;
  int right = q.size();
  int m;
  while (left < right)
  {
    m = (left + right) / 2;
    if (q[m] > r && q[m - 1] < r)
    {
      return m;
    }
    if (m == 0)
      return m;
    if (q[m] < r)
      left = m;
    else
      right = m;
  }
  return m;
}
int main()
{
  ifstream f("input.txt");
  //citim toate datele din fisier
  f >> totalPopulation;
  f >> a >> b;
  f >> coef[0] >> coef[1] >> coef[2];
  f >> precision;
  f >> crossoverRate;
  f >> mutationRate;
  f >> generationsNumber;
  f.close();
  srand(time(NULL));
  //calculam lungimea pentru cromozom
  genesLength = ceil(log2(((b - a) * pow(10, precision))));
  population = new Cromozom[totalPopulation]; //alocam memoria
  g << "Populatia initiala \n";
  for (int i = 0; i < totalPopulation; i++)
  {
    population[i] = Cromozom();
    population[i].computeFitness(); //dupa ce creem un cromozom, calculam scorul acestuia
    g << setw(3) << i << ":" << setw(23) << population[i].getGenes() << " x= " << setw(precision + 3) << setprecision(precision) << fixed << population[i].getNumber() << " f=" << population[i].fitness << endl;
  }

  //* Prima generatie cu afisarile in fisier
  double totalSum = 0;
  vector<double> q(totalPopulation);
  pair<int, double> maxFit = {0, 0}; //retinem intr-o pereche, index-ul elementului elitist si scorul acestuia
  for (int i = 0; i < totalPopulation; i++)
  {
    population[i].computeFitness();
    totalSum += population[i].fitness;
    maxFit = (population[i].fitness > maxFit.second) ? make_pair(i, population[i].fitness) : maxFit;
  }
  g << "Probabilitati de selectie" << endl;
  q[0] = population[0].fitness / totalSum; // punem pe prima pozitie probabilitatea de selectie a primului element
  g << "cromozom" << setw(4) << 0 << " probabilitatea " << setprecision(18) << (population[0].fitness / totalSum) << endl;
  for (int i = 1; i < totalPopulation; i++)
  {
    //construim vectorul de intervale din pozitie in pozitie
    q[i] = q[i - 1] + population[i].fitness / totalSum;
    g << "cromozom" << setw(4) << i << " probabilitatea " << setprecision(18) << (population[i].fitness / totalSum) << endl;
  }
  g << "Intervale probabilitati selectie " << endl;
  g.unsetf(ios::fixed);
  g << fixed << setprecision(2) << 0.0 << " ";
  for (int i = 0; i < totalPopulation; i++)
  {
    //afisam pe ecran valorile din vectorul de intervale de selectie
    g << fixed << setprecision(9) << q[i] << " ";
    if (i % 3 == 0)
      g << endl;
  }
  g << endl;
  double r;
  for (int i = 0; i < totalPopulation; i++) // ii selectez pe cei care participa la selectie
  {
    if (i == maxFit.first) //citeriul elitist, cromozomul ramane neschimbat
      continue;

    r = ((double)rand() / (RAND_MAX));
    g << "u=" << r << " selectam cromozomul ";
    int j = binarySearch(q, r); //aleg index-ul din vectorul de intervale
    population[i] = population[j];
    g << j << endl;
  }
  g << "Dupa selectie: " << endl;
  for (int i = 0; i < totalPopulation; i++)
  {
    g << setw(3) << i << ":" << setw(23) << population[i].getGenes() << " x= " << setw(precision + 3) << setprecision(precision) << fixed << population[i].getNumber() << " f=" << population[i].fitness << endl;
  }

  vector<pair<int, Cromozom>> matingPool; //pastrez elementele pe care vreau sa le incrucisez intr-un vector

  g << "Probabilitatea de incrucisare " << setprecision(2) << crossoverRate << endl;
  for (int i = 0; i < totalPopulation; i++)
  {
    g << i << ": " << population[i].getGenes() << " ";
    r = ((double)rand() / (RAND_MAX)); //calculez probabilitatea

    g << setprecision(15) << r;
    if (i == maxFit.first)
    {
      g << " elitist" << endl;
      continue; //criteriul elitist
    }
    if (r < crossoverRate) //daca am generat un numar mai mic decat probabilitatea de incrucisare
    {
      g << "<" << setprecision(2) << crossoverRate << " participa";
      matingPool.push_back({i, population[i]}); //il adaug in vectorul cu elemente care sunt selectate pentru incrucisare
    }
    g << endl;
  }
  g << endl;
  while (matingPool.size() > 0)
  {
    if (matingPool.size() == 1) //* daca se intampla ca din elementele dintr-o generatie sa aleg un singur elment la crossover, sar peste faza de crossover
      break;
    if (matingPool.size() == 3) //* daca in vector au ramas 3 elemente, facem incrucisare cu 3 elemente
    {
      Cromozom partenerA = matingPool[0].second;
      Cromozom partenerB = matingPool[1].second;
      Cromozom partenerC = matingPool[2].second;
      g << "Recombinare dintre cromozomul " << matingPool[0].first << " cu cromozomul " << matingPool[1].first << " si cromozomul " << matingPool[2].first << ": " << endl;
      vector<Cromozom> children = partenerA.threeCrossover(partenerB, partenerC, true);

      population[matingPool[0].first] = children[0];
      population[matingPool[1].first] = children[1];
      population[matingPool[2].first] = children[2];

      matingPool.clear();
    }
    else //* cazul in care trebuie sa alegem 2 parteneri
    {
      int p1 = (int)(rand() % matingPool.size());
      int p2 = (int)(rand() % matingPool.size());
      while (p2 == p1)
        p2 = (int)(rand() % matingPool.size()); // ne asiguram ca nu alegem acelasi partener
      g << "Recombinare dintre cromozomul " << matingPool[p1].first << " cu cromozomul " << matingPool[p1].first << ": " << endl;
      Cromozom partenerA = matingPool[p1].second;
      Cromozom partenerB = matingPool[p2].second;
      pair<Cromozom, Cromozom> children = partenerA.crossover(partenerB, true);

      population[matingPool[p1].first] = children.first;
      population[matingPool[p2].first] = children.second;

      //stergem elementele din vectorul cu elemnte de incrucisat
      matingPool.erase(matingPool.begin() + p1);
      if (p1 < p2)
      {
        p2--;
      }
      matingPool.erase(matingPool.begin() + p2);
    }
  }
  g << "Probabilitatea de mutatie pentru fiecare gena " << setprecision(2) << mutationRate << endl;
  g << "Au fost modificati cromozomii:" << endl;
  for (int i = 0; i < totalPopulation; i++)
  {
    if (i == maxFit.first)
      continue; //citeriul elitist, nu aplicam mutatii asupra elemntului elitist
    if (population[i].mutate(mutationRate))
    {
      g << i << endl;
    }
  }
  g << "Dupa mutatie: " << endl;
  for (int i = 0; i < totalPopulation; i++)
  {
    population[i].computeFitness(); //calculam iara scorul dupa mutatii
    g << setw(3) << i << ":" << setw(23) << population[i].getGenes() << " x= " << setw(precision + 3) << setprecision(precision) << fixed << population[i].getNumber() << " f=" << population[i].fitness << endl;
  }
  g << "Evolutia maximului | valoarea medie de performanta" << endl;
  int iter = 1;

  //urmatoarele generatii

  while (iter++ < generationsNumber)
  {
    double totalSum = 0;
    vector<double> q(totalPopulation);
    pair<int, double> maxFit = {0, 0};
    for (int i = 0; i < totalPopulation; i++)
    {
      population[i].computeFitness();
      totalSum += population[i].fitness;
      maxFit = (population[i].fitness > maxFit.second) ? make_pair(i, population[i].fitness) : maxFit;
    }
    g << setprecision(15) << maxFit.second << " | " << totalSum / totalPopulation << endl;
    q[0] = population[0].fitness / totalSum;
    for (int i = 1; i < totalPopulation; i++)
    {
      q[i] = q[i - 1] + population[i].fitness / totalSum;
    }
    double r;
    for (int i = 0; i < totalPopulation; i++)
    {
      if (i == maxFit.first)
        continue;

      r = ((double)rand() / (RAND_MAX));
      int j = binarySearch(q, r);
      population[i] = population[j];
    }

    vector<pair<int, Cromozom>> matingPool;

    for (int i = 0; i < totalPopulation; i++)
    {
      if (i == maxFit.first)
        continue;
      r = ((double)rand() / (RAND_MAX));
      if (r < crossoverRate)
      {
        matingPool.push_back({i, population[i]});
      }
    }

    while (matingPool.size() > 0)
    {
      if (matingPool.size() == 1)
        break;
      if (matingPool.size() == 3)
      {
        Cromozom partenerA = matingPool[0].second;
        Cromozom partenerB = matingPool[1].second;
        Cromozom partenerC = matingPool[2].second;

        vector<Cromozom> children = partenerA.threeCrossover(partenerB, partenerC, false);

        population[matingPool[0].first] = children[0];
        population[matingPool[1].first] = children[1];
        population[matingPool[2].first] = children[2];

        matingPool.clear();
      }
      else
      {
        int p1 = (int)(rand() % matingPool.size());
        int p2 = (int)(rand() % matingPool.size());
        while (p2 == p1)
          p2 = (int)(rand() % matingPool.size());
        Cromozom partenerA = matingPool[p1].second;
        Cromozom partenerB = matingPool[p2].second;
        pair<Cromozom, Cromozom> childrens = partenerA.crossover(partenerB, false);

        population[matingPool[p1].first] = childrens.first;
        population[matingPool[p2].first] = childrens.second;

        matingPool.erase(matingPool.begin() + p1);
        if (p1 < p2)
        {
          p2--;
        }
        matingPool.erase(matingPool.begin() + p2);
      }
    }
    for (int i = 0; i < totalPopulation; i++)
    {
      if (i == maxFit.first)
        continue; //elitist
      population[i].mutate(mutationRate);
    }
  }
  g.close();
}

/*
	INPUT
20
-1 2
-1 1 2
6
0.25
0.01
50
*/