
def compl(c):
    if(c=="a"):
        return "b"
    return "a"
n = int(input())
s = input()
s2 = ""
nr = 0
for i in range(0, n, 2):
    if(s[i] != s[i+1]):
        s2 += s[i]+s[i+1]
    else:
        s2 += s[i]+compl(s[i])
        nr += 1
print(nr)
print(s2)
