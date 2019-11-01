n = int(input())
var = 0
for i in range(n):
    s = input()
    if(s.find("+") != -1):
        var += 1
    else:
        var -= 1
print(var)
