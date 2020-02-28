import math
q = int(input())
rez = []
for i in range(q):
    m = int(input())
    if(m == 2):
        rez.append(2)
    else:
        c = 0
        c = math.ceil(m/2)
        r = abs(m-2*c)
        rez.append(r)
for i in rez:
    print(i)
