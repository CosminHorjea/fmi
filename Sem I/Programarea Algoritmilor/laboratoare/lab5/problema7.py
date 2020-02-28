f = open('obiecte.txt', 'r')
g = open('rucsac.txt', 'w')
n = int(f.readline())
obiecte = []
for i in range(n):
    obiecte.append(tuple(map(int, f.readline().split())))
f.close()
weigh = int(f.readline())
w = 0
val = 0
obiecte.sort(key=lambda x: x[0]/x[1], reverse=True)
print(obiecte)
for obj in obiecte:
    if w+obj[1] <= weigh:
        val += obj[0]
        w += obj[1]
    else:
        dif = weigh-w
        val += obj[0]/obj[1]*dif
        break
g.write(str(val))
# nu mai fac si chestia cu "ce obiecte am pus", pur si simplu le afisez sau le stochez undeva pe masura ce le folosesc in loop, si raportul se ia usor de la aia cu dif, pt ca e doar la ultimul obiect
g.close()
