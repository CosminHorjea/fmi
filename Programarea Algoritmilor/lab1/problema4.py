
def rezolva4(n):
    x = input("Introduceti valorile separate prin \",\"")
    x = x.split(',')
    # x=float(x)
    max = 0
    for i in range(n-1):
        dif = abs(float(x[i+1])-float(x[i]))
        if(max < dif):
            max = dif
    print(format(max, '.2f'))
    # nu arata si alea doua zile but who cares


if __name__ == "__main__":
    n = int(input("n="))
    rezolva4(n)

'''
4. Se citește un șir format din n numere reale strict pozitive (n≥2), reprezentând
cursul de schimb valutar RON/EURO din n zile consecutive. Să se afișeze
zilele între care a avut loc cea mai mare creștere a cursului valutar, precum și
cuantumul acesteia. De exemplu, pentru n=6 zile și cursul valutar dat de șirul
4.25,4.05,4.25,4.48,4.30,4.40, cea mai mare creștere a fost de 0.23 RON,
între zilele 3 și 4.
'''
