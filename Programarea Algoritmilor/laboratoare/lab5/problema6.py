f = open('evenimente.txt', 'r')
g = open('sali.txt', 'w')
spectacole = []
sali = {}
orar = {}  # key = numele spect si val e ora
k = 0
for row in f.readlines():
    time, name = row.split()
    orar[name] = time
    start, finish = time.split("-")
    # convertesc ora in numar cu zecimala
    start = float(start.replace(":", "."))
    finish = float(finish.replace(":", "."))
    spectacole.append((start, finish, name))
spectacole.sort(key=lambda x: x[0])
for i in spectacole:
    programat = 0
    for key in sali.keys():
        if(sali[key][-1][1] <= i[0]):
            sali[key].append(i)
            programat = 1
            break
    if programat == 0:
        sali[k] = [i]
        k += 1
g.write(str(k)+' sali\n')
print(sali)
for key in sali.keys():
    for i in sali[key]:
        g.write("("+orar[str(i[2])]+" "+i[2]+')')
    g.write('\n')
