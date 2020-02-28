l = [38,27,43,3,9,82,10]


def mergeSort(s,d):
    if(s<d):
        m = (s+d)//2
        mergeSort(s,m)
        mergeSort(m+1,d)

        merge(s,d+1)
def merge(s,d):
    m=(s+d)//2
    L=l[s:m]
    R=l[m:d]
    k=s;i=0;j=0
    while i<len(L) and j<len(R):
        if(L[i]<=R[j]):
            l[k]=L[i]
            i+=1
        else:
            l[k]=R[j]
            j+=1
        k+=1
    while i<len(L):
        l[k]=L[i]
        i+=1
        k+=1
    while j<len(R):
        l[k]=R[j]
        j+=1
        k+=1
    print(l[s:d])


mergeSort(0, len(l))
print(l)

