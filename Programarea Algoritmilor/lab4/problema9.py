def citire():
    n = int(input())
    v = list(map(int, input().split()))
    return n, v


def punctulB(x, v, i, j):
    for poz in range(i, j+1):
        if(v[poz] == x):
            return poz
    return -1


if __name__ == "__main__":
    n, v = citire()
