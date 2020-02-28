f = open('problema5.in')
n = int(f.readline())


def binarySearch(job, start_index):
    # Initialize 'lo' and 'hi' for Binary Search
    lo = 0
    hi = start_index - 1

    # Perform binary Search iteratively
    while lo <= hi:
        mid = (lo + hi) // 2
        if job[mid][1] <= job[start_index][0]:
            if job[mid + 1][1] <= job[start_index][0]:
                lo = mid + 1
            else:
                return mid
        else:
            hi = mid - 1
    return -1


activitati = []

for a in f.readlines():
    activitati.append(tuple(map(int, a.split())))
print(activitati)

activitati.sort(key=lambda x: x[1])
n = len(activitati)
T = [0 for _ in range(n)]
T[0] = activitati[0][2]

for i in range(1, n):
    inclProf = activitati[i][2]
    l = binarySearch(activitati, i)
    if l != -1:
        inclProf += T[l]
    T[i] = max(inclProf, T[i-1])

print(T[n-1])
