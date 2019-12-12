#problema damelor	
global n,tabla
def printSol(tabla):
	for i in range(n):
		print(tabla[i])
def check(tabla,row,col):
	for i in range(col):
		if tabla[row][i]==1:
			return False

	# for i in range(row):
	# 	if tabla[i][col]==1:
	# 		return False

	i=row-1;j=col-1
	while i>=0 and j>=0:
		if tabla[i][j]==1:
			return False
		i-=1;j-=1

	i=row+1; j=col-1
	while i<n and j>=0:
		if tabla[i][j]==1:
			return False
		i+=1;j-=1
	return True
def bkt(tabla,col):
	if(col==n):
		return True

	for i in range(n):
		if check(tabla,i,col):
			tabla[i][col]=1
			if bkt(tabla,col+1):
				return True
			tabla[i][col]=0
	return False
n=4
rand = [0]*n
tabla= [rand.copy()]*n	
# if(bkt(tabla,0)):
# 	printSol(tabla)
# else: print('nu se poate')
bkt(tabla,0)
printSol(tabla)