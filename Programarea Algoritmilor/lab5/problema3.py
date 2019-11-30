cuburi = []
height = 0
g = open('turn.txt', 'w')
with open('cuburi.txt', 'r') as f:
    for cub in f.readlines():
        cub = cub.split()
        cuburi.append((int(cub[0]), cub[1]))
cuburi.sort(key=lambda x: x[0], reverse=True)
g.write(str(cuburi[0][0])+" "+str(cuburi[0][1])+"\n")
height += cuburi[0][0]
color = cuburi[0][1]
for i in cuburi[1:]:
    if i[1] != color:
        color = i[1]
        g.write(str(i[0])+" " + i[1]+"\n")
        height += i[0]
g.write(str(height))
g.close()
