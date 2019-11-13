from functools import cmp_to_key as c2k  # pt o functie de comp cu 2 param

f = open('input.txt', 'r')


def comp(x):
    return x % 2


def my_cmp(a, b):
    return a-b


s = f.readline()
# print(s, type(s))
l = [int(x) for x in s.split()]
ll = l.copy()
print(l)
# l.sort(reverse=True)
# print(l)
# ll=sorted(ll,reverse=True)  # asta cu modifica ll , doar returneaza o lista noua sortata
# print(ll)
# l.sort(key=comp) # sortez lita pe baza lui comp, care returneaza o "pondere", nr mai mare pr nr impare si mai mic pt pare
l.sort(key=c2k(my_cmp))  # asta e pt o functie cu 2 param utilizand functools
# cand dau o functie ca parametru nu trebuie sa pun ()
print(l)
