def diff(A, B):
    s = 0
    for i in range(len(A)):
        s += abs(A[i]-B[i])
    return s


N = int(input())
A = list(map(int, input().split()))
B = [0]*N

for i in range(N):
    B[i] += N-A[i]+1
# print(B)
for i in B:
    print(i, end=" ")
# print("\n Diff: ", diff(A, B))
