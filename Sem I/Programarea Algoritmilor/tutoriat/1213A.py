import math
n = int(input())
c = map(int, input().split())
paritate = [0, 0]
for i in c:
    paritate[i % 2] += 1
if(paritate[0] == 0 or paritate[1] == 0):
    print(0)
elif(paritate[0] > paritate[1]):
    print(paritate[1])
else:
    print(paritate[0])
