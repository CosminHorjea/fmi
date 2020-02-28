f = open('harti.in', 'r')
vecini = {}
n = int(f.readline())
# citesc din fisier si construiesc un dict ca un graf neorientat ca sa fie mai usor cu conditia din bt
for border in f.readlines():
    border = list(map(int, border.split()))
    if(border[0] in vecini.keys()):
        vecini[border[0]].append(border[1])
    else:
        vecini[border[0]] = [border[1]]
    if(border[1] in vecini.keys()):
        vecini[border[1]].append(border[0])
    else:
        vecini[border[1]] = [border[0]]

sol = [0]*(n+1)
# print(vecini)


def afisare():
    # for i in range(1, n+1):
        # i mean chiar e acelasi lucru ca la prima right? nu stau sa creez numere cu inmultiri si chestii
    print(sol[1:], end="")  # indexez de la 1, shame on me


def verif(k):
    for i in range(1, k):
        if(i in vecini[k] and sol[i] == sol[k]):
            return False
    return True


def back(k):
    if(k > n):
        afisare()  # construiesc stiva din prima corecta, deci cand k > n afisez clar
    else:
        for i in range(1, 4+1):  # 4 e nr maxim de culori
            sol[k] = i
            if(verif(k)):
                back(k+1)


back(1)
