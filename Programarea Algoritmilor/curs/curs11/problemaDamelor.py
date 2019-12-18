#problema damelor
global n
def printSol(tabla):
    for i in range(n):
        print(tabla[i])
        
def check(tabla,row,col):
    for i in range(col):
        if tabla[row][i]==1:
            return False

    i=row-1; j= col-1
    while i>=0 and j>=0:
        if tabla[i][j]==1:
            return False
        i-=1; j-=1
    i=row+1; j= col-1
    while i<n and j>=0:
        if tabla[i][j]==1:
            return False
        i+=1; j-=1
    return True

def bkt(tabla,col):
    if col==n: 
        printSol(tabla)
        return 
        
    for i in range(n):
        if check(tabla,i,col):
            tabla[i][col]=1
            printSol(tabla)
            print()
            bkt(tabla,col+1)
            tabla[i][col]=0
 
n=5   
rand=[0]*n
tabla=[]
for i in range(n):
    tabla.append(rand.copy())
bkt(tabla,0)
# https://www.onlinegdb.com/Sys_y9kRB

    
