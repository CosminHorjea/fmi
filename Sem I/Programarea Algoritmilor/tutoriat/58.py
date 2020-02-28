s = input()
cuvant = "hello"
if(len(s) < len(cuvant)):  # daca lungimea e mai mica decat cuvantul cautat e clar NO
    print("NO")
else:
    # index = 0
    for i in s:
        if(len(cuvant)):  # daca mai exista cuvantul
            # daca litera la care sunt din s e aceeasi cu prima litera din cuvant
            if(i == cuvant[0]):
                cuvant = cuvant[1:]  # atunci o scot si o caut pe urmatoarea
    if(len(cuvant) != 0):  # daca am sters tot cuvantul e ok si print Yes
        print("NO")
    else:
        print("YES")
