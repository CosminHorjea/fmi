def divide(v,s=0,f=None):
	if f== None :
		f=len(v)
	if f-s==-1:
		return
	mid=(f+s)//2
	divide(v,s,mid)
	divide(v,mid,f)
	union(v,s,mid,f)
def union(v,s,m,f):
	w = []
	i=s;j=m
	while i<m and j< f:
			if v[i]<v[j]:
				w.append(v[i])
				i+=1
			else:
				w.append(v[j])
				j+=1
	while i<m: w.append(v[i]);i+=1
	while j<f: w.append(v[j]);j+=1
	v[s:f]=w
v=[2,6,3,1,5,4,7]
divide(v)
print(v)