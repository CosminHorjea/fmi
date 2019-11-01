def verifica(s):
    r = p = 0
    if(len(s) % 2 == 0):
        return False
    for c in s:
        if(c == "("):
            r += 1
        elif(c == "["):
            p += 1
        elif(c == ")"):
            if(p > r or r == 0):
                return False
            r -= 1
        elif(c == "]"):
            if(r > p or p == 0):
                return False
            p -= 1
    if(r != p):
        return False
    return True


s = input()
# assert(verifica("[[]]()!"), True)
# assert(verifica("[(])!"), False)
# assert(verifica("][()]!"), False)
# assert(verifica("[[]]()!"), True)
print(verifica(s))
