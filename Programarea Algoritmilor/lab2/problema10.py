'''
10. Numele Pre-Nume
Scrieți un program care citește un șir de caractere și decide dacă acesta este un nume corect al unei
persoane. Se consideră că un nume este corect dacă respectă următoarele proprietăți:
• Orice nume sau prenume conține doar litere și cel mult o cratimă.
• Orice nume sau prenume este format din cel puțin 3 litere.
• Orice nume sau prenume începe cu literă mare.
• Prenumele sunt cel mult două, iar dacă sunt două atunci sunt despărțite printr-o cratimă (‘-’).
'''
s = "Horjea Cosmin-Marian"
valid = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM '
ok = 1
nr = 0
if(s.title() != s):
    ok = 0
else:
    for i in s:
        if(not i in valid):
            if(i == "-"):
                nr += 1
            else:
                ok = 0
                break
        if(nr > 2):
            ok = 0
            break
if(ok):
    print("da")
else:
    print("nu")
