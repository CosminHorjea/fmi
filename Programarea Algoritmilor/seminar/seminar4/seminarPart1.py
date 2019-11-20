n=6;m=6
M=[] #trebuie puse valorile
def matrix_search(M,val):
	if(val<M[0,0] or val>M[n-1][m-1]):
		return (-1,-1)
	i=n-1;j=0
	while(i>=0 and j<m):
		if val==M[i][j]:return (i,j)
		elif:val<M[i][j]: i-=1
		else: j-=1
	return(-1,-1)
print(matrix_search(M,60))