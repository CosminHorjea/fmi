#generearea permutarilor
global n,s
def bkt(k):
	if k==n: 
		print(s)
	for i in range(1,n+1):
		if i not in s[:k]:
			s[k]=i
			if(k<n):
				bkt(k+1)
n=5
s=[0]*n
bkt(0)