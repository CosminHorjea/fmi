l = [2, 4, 8, 10, 12, 14]

# https://www.geeksforgeeks.org/find-missing-number-arithmetic-progression/

def findMissing(l,s,d):
    # print(l[s:d],(s,d))
    if s<d:
        m=(s+d)//2
        if (m != 0 and m != len(l) - 1):
            if ((l[m - 1] + l[m + 1]) // 2 != l[m]):
                ds = l[m]-l[m-1]
                dd = l[m+1]-l[m]
                if ds>dd:
                    return l[m]-dd
                else:
                    return l[m]+ds
        return findMissing(l, s, m)+findMissing(l,m+1,d)
    else:
        return 0

print(findMissing(l,0,len(l)))