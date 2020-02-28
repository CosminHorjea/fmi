n = 6  # nr din fisier
sol = [0]*10  # vectorul in care construiesc sol


def verif(k):
    global sol, n
    for i in range(1, k):
        if(sol[i] == sol[k]):
            return False
    return True


def afisare(k):
    global sol, n
    for i in range(1, k):
        print(sol[i], end=" ")
    print()


def back(k):
    global n, sol
    if(sum(sol) == n):
        afisare(k)
    else:
        for i in range(1, n+1):
            sol[k] = i
            if(verif(k)):
                back(k+1)
            sol[k] = 0


back(1)
