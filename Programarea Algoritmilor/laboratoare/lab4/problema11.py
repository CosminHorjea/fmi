def alipire(*argv):
    rez = 0
    for numar in argv:
        cifMax = 0
        while(numar > 0):
            cif = numar % 10
            if(cif > cifMax):
                cifMax = cif
            numar //= 10
        rez *= 10
        rez += cifMax
    return rez

# a)
# print(alipire(4251, 73, 8, 133))
# b)


def punctulB(a, b, c):
    temp = alipire(a, b, c)
    suma = 0
    while(temp > 0):
        suma += temp % 10
        temp //= 10
    if(suma < 4):
        return True
    return False


print(punctulB(1001, 0, 100))
