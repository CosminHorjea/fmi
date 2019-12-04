def rezolva(L_1, L_2):
    aria = L_1*L_2
    while(L_1 and L_2): # cel mai mare divizor comun
        if(L_1 > L_2):
            L_1 = L_1 % L_2
        else:
            L_2 = L_2 % L_1
    # print(L_1)

    nrBucati = int(aria/L_1**2)# impartiam aria suprafetei la aria unei bucati de gresie
    # print(nrBucati)
    return L_1, nrBucati


if __name__ == "__main__":
    assert rezolva(440, 280) == (40, 77)
    # print(rezolva(440, 280))


'''
3. Un meșter trebuie să paveze întreaga pardoseală a unei bucătării cu formă
dreptunghiulară de dimensiune L_1×L_2 centimetri, cu plăci de gresie
pătrate, toate cu aceeași dimensiune. Știind că meșterul nu vrea să taie nici o
placă de gresie și vrea să folosească un număr minim de plăci, să se
determine dimensiunea plăcilor de gresie de care are nevoie, precum și
numărul lor. De exemplu, dacă L_1=440 cm și L_2=280 cm, atunci meșterul
are nevoie de 77 de plăci de gresie, fiecare având latura de 40 cm
'''
