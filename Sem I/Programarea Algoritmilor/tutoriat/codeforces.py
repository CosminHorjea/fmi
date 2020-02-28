string = input()
l = u = 0
for i in string:
    if(i.islower()):
        l += 1
    else:
        u += 1
if(l >= u):
    print(string.lower())
else:
    print(string.upper())
