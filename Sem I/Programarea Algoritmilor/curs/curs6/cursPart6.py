from collections import deque

q = deque([3, 8, 6])
print(q)
q.append(10)
print(q)
q.appendleft(-10)
print(q)
print(q.pop(), q.popleft())
