n=int(input())
op = input()
rocks=0
for c in op:
    if(c=="+"):
        rocks+=1
    else:
        if rocks ==0 :
            continue
        else:
            rocks-=1
print(rocks)