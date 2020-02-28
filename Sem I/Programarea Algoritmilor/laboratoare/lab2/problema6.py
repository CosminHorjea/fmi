'''
6. Jurnalul electronic al Anei conține, în fiecare zi, câte o frază cu informații despre cheltuielile pe
care ea le-a efectuat în ziua respectivă. Scrieți un program care să citească o frază de acest tip din
jurnalul Anei și apoi să afișeze suma totală cheltuită de ea în ziua respectivă. De exemplu, pentru fraza
“Astăzi am cumpărat pâine de 5 RON, pe lapte am dat 10 RON, iar de 15 RON am cumpărat niște
cașcaval. De asemenea, mi-am cumpărat și niște papuci cu 50 RON!”, programul trebuie să afișeze
suma totală de 80 RON. Fraza se consideră corectă, adică toate numerele care apar în ea sunt
numere naturale reprezentând sume cheltuite de Ana în ziua respectivă!
'''
s = "Astăzi am cumpărat pâine de 5 RON, pe lapte am dat 10 RON, iar de 15 RON am cumpărat niște cașcaval. De asemenea, mi-am cumpărat și niște papuci cu 50 RON!"
poz = s.find("RON")
suma=0
for i in range(poz):
    while(not s[i:poz-1].isnumeric()):
        i += 1
    # print(s[i:poz])
    suma+=int(s[i:poz])
    s = s[poz+3:]
    poz = s.find("RON")
    if(poz is -1):
        break
print(suma)