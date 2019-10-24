import math


def check(x, y):
    return (x**2+2*x*y+x+1)


# r=x^2+2xy+x+1
# r=x(x+2y+1)+1
# r-1 = x(x+2y+1)
r = int(input())
x = y = 1
ok = 0
while(x <= math.sqrt(r)):
    while(check(x, y) < r):
        y += 1
        # print(check(x, y))
    if(check(x, y) == r):
        print(x, y)
        ok = 1
        break
    x += 1
    y = 1
    # print("loop 1")
if(not ok):
    print("NO")
# 260158260522
