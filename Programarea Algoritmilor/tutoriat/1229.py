skills = [0]*60
valid = [False]*60
suma=0


def binar(a):
    i=0
    while(a > 0):
        if(a & 1):
            skills[i] += 1
        a = a >> 1
        i+=1
def verific(a):
    i=0
    while(a > 0):
        if(a & 1):
            if(valid[i]==False):
                return False
        a = a >> 1
        i+=1
    return True


n = int(input())
a = list(map(int, input().split()))
b = list(map(int, input().split()))
# for i in a:
#     binar(i)
# for i in range(n):
#     if(skills[i]!=1):
#         valid[i]=True
# for i in range(n):
#     if(verific(a[i])):
#         suma+=b[i]
print(list(enumerate(a)))