cuvinte = {}
# propozitie = input()
propozitie = "Ana are mere si pere dar mai multe mere are Ana decat pere Ana"
for cuv in propozitie.split():
    if(cuvinte.get(cuv)):
        cuvinte[cuv] += 1
    else:
        cuvinte[cuv] = 1
numar = cuvinte.items()


print(sorted(numar)[0][0], " ", sorted(numar)[len(numar)-1][0])# python coding be like
