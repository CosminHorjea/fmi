import math

n, m, a = map(int, input().split())

top = math.ceil(n/a)
bottom = math.ceil(m/a)
print(top*bottom)
