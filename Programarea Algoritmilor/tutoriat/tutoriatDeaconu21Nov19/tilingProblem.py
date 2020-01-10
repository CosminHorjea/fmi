m = [
    [0] * 8,
    [0] * 8,
    [0, 'X', 0, 0, 0, 0, 0, 0],
    [0] * 8,
    [0] * 8,
    [0] * 8,
    [0] * 8,
    [0] * 8,
]

p = (2, 1)
k = 1
# g=1 stanga sus
# g=2 dreapta sus
# g=3 stanga jos
# g=4 dreapta jos


def cover(m, s, d, g):
    global k, p
    if(s[0] > d[0]):
        return None
    if(s[1] > d[1]):
        return None
    w = abs(s[0]-d[0])
    h = abs(s[1]-d[1])
    if(w == h):
        n = w
    else:
        return None

    print(s, d)
    if(n < 1):
        return None
    if(n >= 1):
        # n = (s[0]+d[0])//2
        if(g == 1):
            m[(s[0]+n)//2+1][(s[1]+n)//2+1] = k
            m[(s[0]+n)//2+1][(s[1]+n)//2] = k
            m[(s[0]+n)//2][(s[1]+n)//2+1] = k
        if(g == 2):
            m[n//2][n//2] = k
            m[n//2+1][n//2] = k
            m[n//2+1][n//2+1] = k
        if(g == 3):
            m[n//2][n//2] = k
            m[n//2][n//2+1] = k
            m[n//2+1][n//2+1] = k
        if(g == 4):
            m[n//2][n//2] = k
            m[n//2+1][n//2] = k
            m[n//2][n//2+1] = k
        k += 1
    cover(m, (s[0], s[1]), (d[0]//2, d[1]//2), 1)  # stanga sus
    cover(m, (d[0]//2+1, s[1]), (d[0], d[1]//2), 1)  # drapta sus
    cover(m, (s[0], d[1]//2+1), (d[0]//2, d[1]), 1)  # stanga jos
    # cover(m, ((s[0]+d[0])//2+1, (s[1]+d[1])//2+1),
    #       (d[0], d[1]), 1)  # dreapta jos


cover(m, (0, 0), (len(m)-1, len(m)-1), 1)
r = [str(x) for x in m]
for l in r:
    print(" ".join(l))
