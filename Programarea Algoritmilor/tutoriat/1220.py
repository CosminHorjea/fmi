# n = 10
# s = "nznooeeoer"
n=int(input())
s=input()
#Zero
#oNe
v=[0,0]
for i in s:
    if(i =="z"):
        v[0]+=1
    elif(i=="n"):
        v[1]+=1
for i in range(v[1]):
    print(1,end=" ")
for i in range(v[0]):
    print(0,end=" ")

