def verific(c):
    for i in cuv:
        if i not in c:
            return False
    return True


sir = input()
cuv = set(input())
lista = []
sir.replace(",", "")
for i in sir.split():
    if(verific(i)):
        lista.append(i)
print(lista)
