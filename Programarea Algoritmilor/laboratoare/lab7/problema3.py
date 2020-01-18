a = 'harpa'
b = 'armura'


# def levDist(a, b):
#     if len(a) == 0:
#         return len(a)
#     if len(b) == 0:
#         return len(b)

#     if(a[-1] == b[-1]):
#         cost = 0
#     else:
#         cost = 1
#     return min(levDist(a[:-1], b)+1, levDist(a, b[:-1])+1, levDist(a[:-1], b[:-1])+cost)

def LevensteinDistance(a, b):
    a = " "+a
    b = " "+b
    m = len(a)-1
    n = len(b)-1
    d = [[0 for x in range(n+1)]for y in range(m+1)]

    for i in range(1, m+1):
        d[i][0] = i
    for j in range(1, n+1):
        d[0][j] = j
    for j in range(1, n+1):
        for i in range(1, m+1):
            if(a[i] == b[j]):
                cost = 0
            else:
                cost = 1
            # deletion, substitution,replacement
            d[i][j] = min(d[i-1][j]+1, d[i][j-1]+1, d[i-1][j-1]+cost)
    return d[m][n]


print(LevensteinDistance(a, b))
