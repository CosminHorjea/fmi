lista = []
n = input()
punctaje = set()
dict = {}
i = 1
while n != "-1":
    x = tuple((n.split(maxsplit=1)[0], n.split(maxsplit=1)[1], i))
    # x.append(i)
    punctaje.add(x[0])
    lista.append(x)
    n = input()
    i += 1
    if(dict.get(x[0])):
        dict[x[0]].append((x[1], x[2]))
    else:
        dict[x[0]] = [(x[1], x[2])]

# print(punctaje)#b)
print(dict)  # c)
'''
64 Danil Marius
70 Derek Alexandru
100 Pirpiric Claudiu
18 Alexandrescu Matias
64 Popescu Catalin
100 Cozia Daniel
82 Stefan Dinca
-1

'''
