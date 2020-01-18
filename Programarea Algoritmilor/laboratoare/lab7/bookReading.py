N, M, Q = 1000, 6, 3
m = [4, 8, 15, 16, 23, 42]
q = [1]
pages = 0
for i in q:
    for j in m:
        if(j % i == 0):
            pages -= 1
    pages += N//i
print(pages)
