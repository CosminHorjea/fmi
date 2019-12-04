sir = input()
rime = {}
for cuvant in sir.split():
    sufix = cuvant[-2]+cuvant[-1]
    if(rime.get(sufix)):
        rime[sufix].append(cuvant)
    else:
        rime[sufix] = [cuvant]
final = {}
for key in rime:
    if(len(rime[key]) >= 2):
        final[key] = rime[key]
print(final)
# print(rime)
