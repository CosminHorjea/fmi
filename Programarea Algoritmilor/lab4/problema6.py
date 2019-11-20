def citire():
    v = list(map(int, input().split()))
    return v


def afisare(v):
    for i in v:
        print(i, end=" ")


def valpoz(v):
    poz = []
    for i in v:
        if(i > 0):
            poz.append(i)
    return poz


def semn(v):
    for i in range(len(v)):
        v[i] = -v[i]
    return v


if __name__ == "__main__":
    v = citire()
    pozitive = valpoz(v)
    for i in pozitive:
        print(i, end=" ")
    print()
    v = semn(v)
    for i in v:
        if(i > 0):
            print(-i, end=" ")
