f = open('rucsac.in', 'r')

n = int(f.readline())

obiecte = []
for i in f.readlines():
    obiect = tuple(map(int, i.split()))
    obiecte.append(obiect)

print(obiecte)
