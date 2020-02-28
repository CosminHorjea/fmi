# cautare binara
def binarySearch(v, val, s=0, f=None):
    if f == None:
        f = len(v)
    if f-s == 1:
        if v[s] == val:
            return s
        else:
            raise IndexError
    m = (s+f)//2
    if v[m] == val:
        return m
    else:
        if(v[m] > val):
            return binarySearch(v, val, s, m)
        else:
            return binarySearch(v, val, m+1, f)


arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

print(binarySearch(arr, 4))
