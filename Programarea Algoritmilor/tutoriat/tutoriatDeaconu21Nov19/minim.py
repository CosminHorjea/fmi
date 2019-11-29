from itertools import permutations


def minim(lista):
    # print(*permutations(lista))
    permutari = list(permutations(lista))
    minim = max(lista)*max(lista)*len(lista)
    for p in permutari:
        for q in permutari:
            suma = 0
            for i in range(len(p)):
                suma += p[i]*q[i]
            if(suma < minim):
                minim = suma
    print(minim)


def minimGreddy(lista_1, lista_2):
    suma = 0
    copie_1 = sorted(lista_1)
    copie_2 = sorted(lista_2, reverse=True)
    for i in range(len(lista_1)):
        suma += copie_2[i]*copie_1[i]
    print(suma)


minimGreddy([1, 2, 3], [-1, 2, 3])
