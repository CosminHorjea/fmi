def cautareBinara(l, s, d, val):
    if(s >= d):
        return -1
    else:
        m = (s+d-1)//2
        if l[m] == val:
            return m
        else:
            if(l[m] > val):
                return cautareBinara(l, m+1, d, val)
            else:
                return cautareBinara(l, s, m, val)


with open('data.in', 'r') as f:
    lista = list(map(int, f.readline().split()))
lista = sorted(lista)
x = 5
# print(lista)
i = cautareBinara(lista, 0, len(lista)-1, x)
nr = 0
while(i != -1):
    lista.remove(x)
    nr += 1
    i = cautareBinara(lista, 0, len(lista)-1, x)
print(nr)
