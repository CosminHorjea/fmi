queue = ["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"]
n = int(input())
# for i in range(n):
#     name = queue.pop(0)
#     queue.append(name)
#     queue.append(name)
# pname = name
if(n < len(queue)+1):
    print(queue[n-1])
else:
    grup = 5
    i = 1
    while(n-grup > 0):
        n -= grup
        grup *= 2
        i *= 2
    print(queue[n//i])
