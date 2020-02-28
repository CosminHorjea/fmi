'''
8. “Traduceri”
a) Se citește de la tastatură un text. Se cere să se “traducă” în limba păsărească textul dat astfel: după
fiecare vocală se adaugă litera p și încă o dată acea vocală (după a, e, i, o, u se adaugă respectiv pa,
pe, pi, po, pu). Exemplu: “Ana are mere.” devine “Apanapa aparepe meperepe.”
Fiind dat un astfel de text în limba păsărească, se poate obține textul original? Dacă da, faceți asta.
'''
vocale = "aeiouAEIOU"


def pasareasca(s):
    p = ""

    for i in s:
        if(i in vocale):
            p += i+"p"+i.lower()
        else:
            p += i
    print(p)


def inversPasareasca(p):
    s = ""
    poz = p.find("p")
    while(poz != -1):
        s += p[:poz]
        if(p[poz+1] in vocale):
            s += ""
        p = p[poz+2:]
        poz = p.find("p")

    print(s)


if __name__ == "__main__":
    pasareasca("Ana are mere.")
    # inversPasareasca("Apanapa aparepe meperepe.")
    # pasareasca("A-na a-re mul-te me-re ro-sii si de-li-cioa-se.") # chestia de la b merge cu primele functii aparent
    # inversPasareasca("Apa-napa apa-repe mupul-tepe mepe-repe ropo-sipiipi sipi depe-lipi-cipiopoapa-sepe.")
'''
b) Se citește de la tastatură un text în care cuvintele sunt despărțite în silabe cu ajutorul cratimelor. Se
cere să se “traducă” textul dat în limba păsărească astfel: după fiecare silabă se adaugă litera p și se
repetă ultima literă din acea silabă. Afișați traducerea și cu cratime, dar și fără.
Exemplu: “A-na a-re mul-te me-re ro-sii si de-li-cioa-se.” devine
“Apa-napa apa-repe mulpl-tepe mepe-repe ropo-siipi sipi depe-lipi-cioapa-sepe.” și
“Apanapa aparepe mulpltepe meperepe roposiipi sipi depelipicioapasepe.”
Fiind dat un astfel de text în limba păsărească (cel care conține și cratime), se poate obține textul
original? Dacă da, faceți asta.
'''