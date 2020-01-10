l = [1,2,3,4,5,6,7,8]
def binarySearch(s,d,val):
    if(s>=d):
        return -1
    mid = (s+d)//2
    if(l[mid] == val): return mid
    if(l[mid] > val): return binarySearch(s,mid,val)
    if(l[mid] < val): return binarySearch(mid+1,d,val)

val = 5
print(binarySearch(0,len(l),val))