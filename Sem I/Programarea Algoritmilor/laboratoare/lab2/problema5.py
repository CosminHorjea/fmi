'''
5. O metodă simplă (dar nesigură!!!) de criptare a unui text o reprezintă cifrul lui Cezar, prin care
fiecare literă dintr-un text dat este înlocuită cu litera aflată peste 𝑘𝑘 poziții la dreapta în alfabet în mod
circular. Valoarea 𝑘𝑘 reprezintă cheia secretă comună pe care trebuie să o cunoască atât expeditorul,
cât și destinatarul mesajului criptat. Decriptarea unui text constă în înlocuirea fiecărei litere din textul
criptat cu litera aflată peste 𝑘𝑘 poziții la stânga în alfabet în mod circular. Scrieți un program care să
realizeze criptarea sau decriptarea unui text folosind cifrul lui Cezar. Indicație de rezolvare: se va
utiliza formula 𝑒𝑒𝑘𝑘(𝑥𝑥) = (𝑥𝑥 + 𝑘𝑘) mod 26 pentru criptarea unui caracter 𝑥𝑥 folosind cheia secretă 𝑘𝑘,
respectiv formula 𝑑𝑑𝑘𝑘(𝑥𝑥) = (𝑥𝑥 − 𝑘𝑘) mod 26 pentru decriptare. De asemenea, se vor utiliza funcțiile
ord și chr pentru manipularea caracterelor.
'''
# s,k=input(),int(input())
s = "Text suport"
# s=s.lower()
k = 20
cript = ""
for i in s:
    if i == " ":
        cript += " "
    else:
        if(i.isupper()):
            cript += chr(((ord(i)+k) % 26)+65)
        else:
            cript += chr(((ord(i)+k) % 26)+97)

print(cript)
