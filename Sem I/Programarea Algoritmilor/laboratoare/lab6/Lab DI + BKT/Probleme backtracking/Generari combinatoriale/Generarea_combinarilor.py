def bkt(k):
    global n, sol, cnt, p

    for v in range(1 if k == 0 else sol[k-1]+1, n+1):
        sol[k] = v
        if k == p-1:
            cnt += 1
            print(str(cnt).rjust(3) + ".", sol[:k+1])
        else:
            bkt(k+1)


n = 5
p = 3
cnt = 0

sol = [0]*n
bkt(0)
