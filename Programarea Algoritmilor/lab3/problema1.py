s = set()
numere = list(map(int, input().split()))
s = set(numere)

print(max(s), end=" ")
s.remove(max(s))
print(max(s))
