s = {1, 5, 7}
fs = {1, 2, 7, 6, 5, 9}

print(s <= fs)  # s inclus in fs

s = {1, 5, 7, 3, 10}
fs = {1, 2, 7, 6, 5, 9}
ffss = {10, 2, 22}
ss = s | fs | ffss  # s.union() <=> | , complexitatea e adunarea lungimilor
ss = s & fs  # intersectie
ss = s ^ fs  # diferenta simetrica
ss = s - fs  # diferenta dintre seturi
s.clear()
print(ss)

#####

s = {1, 5, 7, 3, 10}
ss = s.copy()
ss.add(-1)
print(s)
