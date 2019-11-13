def isPalindrome(s):
    for i in range(len(s)//2):
        if(s[i] != s[-(i+1)]):
            return False
    return True


s = input()
while(isPalindrome(s) and s != ""):
    s = s[:len(s)-1]
print(len(s))
