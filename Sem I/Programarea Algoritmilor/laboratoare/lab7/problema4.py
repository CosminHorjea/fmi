f = open('problema4.in')

sol=[]

def sir_max(siruri,k):
	ok=0
	if(len(siruri)==1):
		for el in siruri[0]:
			if(el==k):
				return True	
		return False

	for el in siruri[-1]:
		if(k<el):
			continue
		ok=ok or sir_max(siruri[:-1],k-el)
	return ok



n, k = map(int, f.readline().split())
siruri=[]

for sir in f.readlines():
	siruri.append(list(map(int,sir.split())))
print(siruri,k)

print(sir_max(siruri,k))