def negative_pozitive(l):
    poz, neg = [], []
    for i in l:
        if i < 0:
            neg.append(i)
        else:
            poz.append(i)
    return poz, neg


lista = map(int, input().split())
print(negative_pozitive(lista))
