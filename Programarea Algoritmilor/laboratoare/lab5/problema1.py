from math import ceil
lista_tuplete = []


def afisare_timpi_servire(tis):
    timp = 0
    timp_mediu = 0
    for i in tis:
        print(str(i[0])+" "+str(i[1]), end=" ")
        timp += i[1]
        timp_mediu += timp
        print(timp, end="\n")
    print("Timpul mediu: " + str(timp_mediu/len(tis)))


with open('tis.txt') as f:
    cifre = list(map(int, f.readline().split()))
    for i in range(len(cifre)):
        lista_tuplete.append((i, cifre[i]))

# print(lista_tuplete)
afisare_timpi_servire(lista_tuplete)
lista_tuplete.sort(key=lambda x: x[1])
afisare_timpi_servire(lista_tuplete)
