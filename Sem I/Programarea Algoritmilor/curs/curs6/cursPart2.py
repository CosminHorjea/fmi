from functools import cmp_to_key as c2k  # pt o functie de comp cu 2 param

s = "Ana are mere albe"
l = s.split()
l.sort(key=str.lower)
print(l)
