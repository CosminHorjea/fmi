from math import pi


def lungime_arie_cerc(r):
    l = 2*pi*r
    a = pi*(r**2)
    return (l, a)

r = int(input())
print(lungime_arie_cerc(r))
