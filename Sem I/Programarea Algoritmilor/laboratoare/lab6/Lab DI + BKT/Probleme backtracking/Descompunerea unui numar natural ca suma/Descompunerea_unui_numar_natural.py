def bkt(k):
    global sol, n

    # # descompuneri distincte (nu sunt formate din aceiasi termeni in alta ordine)
    # # => elementele solutiei sunt generate in ordine crescatoare
    # for v in range(1 if k == 0 else sol[k-1], n - k + 2):

    # # descompuneri distincte cu termeni distincti
    # # => elementele solutiei sunt generate in ordine strict crescatoare
    # for v in range(1 if k == 0 else sol[k - 1]+1, n - k + 2):

    # toate descompunerile
    for v in range(1, n-k+2):
        sol[k] = v
        scrt = sum(sol[:k+1])
        if scrt <= n:
            if scrt == n:
                print(sol[:k+1])
            else:
                bkt(k+1)


n = 10
sol = [0]*n
bkt(0)


