def alegeActivitate(termenLimita):
    """
        Selectam toate activitatile cu finish time mai mic sau egal cu termenul limita
        si o alegem pe cea care se termina cel mai tarziu

        returneaza profitul care este posibil cu acea activitate 
    """
    activitatiCandidat = [x for x in activitati if x[2] <= termenLimita]
    if(len(activitatiCandidat)):
        # return activitatiCandidat[-1][0]
        return DP[len(activitatiCandidat)]
    else:
        return 0


f = open('problema8.in', 'r')

n = int(f.readline())

activitati = []
DP = [0]*(n+1)


for _ in range(n):
    activitati.append(list(map(int, f.readline().split())))
    # dataset-ul are durata, il schimb cu timpul de final cu e problema originala
    activitati[-1][2] = activitati[-1][1]+activitati[-1][2]
    # activitati[i]=profit|start|durata
activitati.sort(key=lambda x: x[2])  # sortam dupa timpul de finish
print(activitati)
for i in range(1, n+1):
    DP[i] = max(DP[i-1], activitati[i-1][0] +
                alegeActivitate(activitati[i-1][1]))
print(DP[-1])
