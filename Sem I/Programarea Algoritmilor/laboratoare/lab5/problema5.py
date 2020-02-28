f = open('activitati.txt', 'r')
g = open('intarzieri.txt', 'w')
n = int(f.readline())
activitati = []
T = 0
intarziereMaxima = 0
for i in range(n):
    activitati.append(tuple(map(int, f.readline().split())))
activitati.sort(key=lambda x: x[1])
for activitate in activitati:
    intarziere=0
    g.write((str(T)+'-->'+str(T+activitate[0])).ljust(10))#ljust imi pune un padding
    g.write(str(activitate[1]).ljust(5))
    T += activitate[0]
    if T > activitate[1]:
        intarziere = T-activitate[1]
        if(intarziere > intarziereMaxima):
            intarziereMaxima = intarziere
    g.write(str(intarziere).ljust(5))
    g.write('\n')
g.write("Intarziere maxima:"+str(intarziereMaxima))
# print(activitati)
