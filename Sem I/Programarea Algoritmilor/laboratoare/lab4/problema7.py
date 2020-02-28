def lungime(a):
    return len(a)


f = open("problema7.txt", 'r')
g = open("problema7.out", 'w')
L = f.readline().split()
# print(L)
# b = sorted(L, reverse=True)
g.write(str(sorted(L, reverse=True))+"\n")
g.write(str(sorted(L, key=lungime)))  # cumva le face si pe b si pe c
