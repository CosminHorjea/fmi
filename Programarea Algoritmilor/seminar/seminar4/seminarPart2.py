
A=(1,1,1,0)
D={1:A}
def multiply(A,n):
	if n in D:
		return D[n]
	else:
		X=multiply(A,n//2)
		Y=multiply(A,n-n//2)
		D[n]=(X[0]*Y[0]+X[1]*Y[2],
		X[0]*Y[1]+X[1]*Y[3],
		X[2]*Y[0]+X[3]*Y[2],
		X[2]*Y[1]+X[3]*Y[3])# asta e pur si simplu inmultire de matrici
		return D[n]
print(multiply(A,7)[1]) 
#fib(2k+1)=fib(k+1)^2+fib(k)^2
#fib(2k)=fib(k)[2fib(k+1)-fib(k)] TODO: demonstratie