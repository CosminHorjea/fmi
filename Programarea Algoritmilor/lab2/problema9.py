'''
9. Negociere
Se cere prelucrarea unui discuții dintre persoana A, care vinde un obiect, și persoana B, care oferă
bani pentru el. O astfel de discuție se poate desfășura în modul următor:
• “Eu am de gând să vând vaza aceasta pentru $5. Ce plăcut, chiar mi-ar plăcea să o achiziționez,
doar că am numai $3 la mine. Este suficient? Nu, insist să obțin 5$ pe ea. Bine, atunci voi scoate
niște bani și-ți aduc cei $5.”
• “Salut, am văzut în acel anunț că vindeți o mașină second-hand. M-ar interesa s-o achiziționez
pentru suma de $2700. Vă amintesc că suma din anunț este de $3000, sir. Desigur. Și totuși, n-am
putea ajunge la mijloc? $2850? $2850 de dolari, spuneți? Mi se pare corect, s-a făcut.”
După cum se poate observa din exemple, regulile sunt acestea:
• se știe că fiecare persoană face câte o ofertă, pe rând, iar suma se apropie spre o valoare aflată
între primele două oferte.
• Considerăm că persoana A este cea care oferă, cum este și logic :), prețul mai mare dintre primele
două oferte.
• Când ultimele două oferte sunt egale, știm că cele două persoane au ajuns la un acord comun (*).
Cerințe:
a) Extrageți din text primele două valori. (hint: orice sumă este un număr după semnul $ în șir)
b) Decideți dacă cele două persoane “s-au înțeles” :). (vezi (*))
'''


def negociere(s):
    poz = 0
    bani = []
    # s.split()
    s = s.split()
    for i in s:
        if(i[0] is "$"):
            if(i[1:].isnumeric()):
                bani.append(int(i[1:]))
            else:
                bani.append(int(i[1:len(i)-1]))
    if(bani[-1]==bani[-2]):
        print("da")
    else:
        print("no")
    # print(bani)


if __name__ == "__main__":
    negociere(" de $2700. Vă amintesc că suma din anunț este de $3000, sir. Desigur. Și totuși, n-am putea ajunge la mijloc? $2850? $2850 de dolari, spuneți? Mi se pare corect, s-a făcut.")
