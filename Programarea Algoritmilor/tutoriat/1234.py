import math
q = int(input())
for i in range(q):
    n = int(input())
    a = map(int, input().split())
    s = sum(a)
    print(math.ceil(s/n))
