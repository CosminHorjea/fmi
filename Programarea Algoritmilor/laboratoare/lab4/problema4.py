def verific(k):
    for i in range(2, k):
        if(k % i == 0):
            return False
    return True


def prime():
    while(True):
        yield 2
        k = 3
        if(verific(k) == False):
            continue
        yield k
        k += 1
n= int(input())

