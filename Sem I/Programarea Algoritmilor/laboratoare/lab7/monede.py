coins = [1, 3, 6, 10]

goal = 12

DP = [0]*(goal+1)

for i in range(1, goal+1):
    if i in coins:
        DP[i] = 1
    else:
        # aleg toate monedele cu valoare mai mica decat i ( pentru ca doar cu alea pot sa foemz i)
        lower = [x for x in coins if x < i]
        # vad ce am calculat deja scotand pe rand cate o bancnota din i
        alreadyDone = [DP[i-x] for x in lower]
        # o aleg pe cea mai buna si mai adaug 1 (bancnota unitate)
        DP[i] = min(alreadyDone)+1

print(DP[-1])
