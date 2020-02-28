def op(s1, s2):
    if(s1[-1] != s2[1]):
        return s1+s2
    else:
        while(s1[-1] == s1[-2]):
            s1 = s1[:len(s1)-2]
        while(s2[0] == s2[1]):
            s2 = s2[1:]
        s1 = s1[:len(s1)-1]
        s2 = s2[1:]
        print(s1+s2)


op("aba", "aaaaaaabba")
