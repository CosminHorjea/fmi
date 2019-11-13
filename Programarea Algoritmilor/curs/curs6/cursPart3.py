from functools import cmp_to_key as c2k


def comp(x):
    if(type(x) == type('a')):
        return 0
    if(type(x) == type(0)):
        return x


l = [12, 5, 'cuv', 7, 'alb', 20]


def cmp2(a, b):  # ????
    pass
#     if(type(a) == type(b)):
#         if(type(a) == type(0)):
#             return a-b
#         else:
#             return len(a)-len(b)
#     else:
#         if(type(a)==type(0)):
#             return a
#         else:
#             return b

##########
# def comp(a, b):
#     if(type(a) != type(b)):
#         if(type(a) is type(0)):
#             return 1
#         return -1
#     else:
#         if(type(a) == type(0)):
#             return a-b
#         else:
#             return 0


print(sorted(l, key=c2k(cmp2)))
