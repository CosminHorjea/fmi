spectacole = []
oreOriginal = {}
g = open('programare.txt', 'w')
with open('spectacole.txt') as f:
    for i in f.readlines():
        ore, nume = i.split(maxsplit=1)
        oreOriginal[nume] = ore
        ore = ore.split('-')
        ore[0] = float(ore[0].replace(":", "."))
        ore[1] = float(ore[1].replace(":", "."))
        spectacole.append((ore[0], ore[1], nume))
spectacole.sort(key=lambda x: x[1])
lastTime = 0
for i in spectacole:
    if(i[0] > lastTime):
        g.write(oreOriginal[i[2]]+" " + i[2])
        lastTime = i[1]
g.close()
