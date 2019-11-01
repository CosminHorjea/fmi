s = input()
paranteze = []
ok = 1
for i in s:
    if(i == "("or i == "["):
        paranteze.append(i)
    elif(i == ")"):
        if(len(paranteze) and paranteze.pop() != "("):
            ok = 0
            break
    elif(i == "]"):
        if(len(paranteze) and paranteze.pop() != "["):
            ok = 0
            break
    elif(i == "!"):
        break
if(len(paranteze) == 0 and ok):
    print("DA!")
else:
    print("NU!")
