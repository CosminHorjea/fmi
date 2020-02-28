t = int(input())
valid = [0]*26
lista = ""
for t1 in range(t):
    s = input()
    # zzaaz
    lista = ""
    nr = 1
    if(len(s) == 1):
        print(s)
        continue
    while(len(s) > 1):
        while(len(s)>1 and s[0] == s[1]):
            nr += 1
            s = s[1:]
        if(nr % 2 == 0):
            lista += s[0]
        else:
            lista = lista.replace(s[0], "")
        s = s[1:]
    print(lista)

'''
4
a
zzaaz
ccff
cbddbb

'''
