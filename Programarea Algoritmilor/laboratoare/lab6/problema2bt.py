s = 6  # nr din fisier
sol = [0]*10  # vectorul in care construiesc sol


def verif(k):
    for i in range(1, k):
        if(sol[i] == sol[k]):
            return False
    return True


def afisare(k):
    for i in range(1, k):
        # i mean chiar e acelasi lucru ca la prima right? nu stau sa creez numere cu inmultiri si chestii
        print(sol[i], end="")
    print()


def back(k):
    if(sum(sol) == s):
        afisare(k)
    else:
        for i in range(1, s+1):
            sol[k] = i
            if(verif(k)):
                back(k+1)
            sol[k] = 0


back(1)
