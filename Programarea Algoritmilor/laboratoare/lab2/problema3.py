'''
3. Scrieți un program care să înlocuiască într-o propoziție toate aparițiile unui cuvânt 𝑠 cu un cuvânt 𝑡. Atenție, NU se poate utiliza metoda replace! De ce?
'''
string = input()
s = input()
t = input()
s2 = ""
string = string.split()
for i in string:
    if(i == s):
        s2 += t+" "
    else:
        s2 += i+" "
print(s2)
