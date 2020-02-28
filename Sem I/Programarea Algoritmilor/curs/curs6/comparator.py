from functools import cmp_to_key as c2k

l = [5, 21, 'cuvant', 13, 'albui', 44]
l2 = [12, 3, 4, 61, 32, 543]


def comp(a, b):
    if(type(a) != type(b)):
        if(type(a) is type(0)):
            return 1
        return -1
    else:
        if(type(a) == type(0)):
            return a-b
        else:
            return 0


def comp2(a, b):
    return a-b


print(sorted(l, key=c2k(comp)))
