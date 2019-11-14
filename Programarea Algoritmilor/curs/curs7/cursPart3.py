import heapq as hq
L = [2, 5, 7, 9, 10, 8, 12, 3, 1]
hq.heapify(L)  # NlogN
print(L)
hq.heappush(L, 3)
print(L)
hq.heappush(L, 3)
print(L)
print(hq.heappop(L))
print(L)
