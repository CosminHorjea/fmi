v = []
x,y=0,0
for i in range(5):
    v.append(list(map(int, input().split())))
for i in range(5):
    for j in range(5):
        if(v[i][j] == 1):
            x,y=i,j
            break

print(abs(2-x)+abs(2-y))
