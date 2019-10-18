'''
ARG consola in c
int main(int argc // nr de arg
            char ** argv) // lista de liste de stringuri

'''
'''
def main():
    print("Hello world") # ex de functie

if __name__ == "__main__":  # main in pyhton
    main()
'''
# extragem numarul dintr-un string , dupa ce gasim un $n, n numar
# s = str(input())
s = "un sir cu $10 si cu $20 dar si $30"
poz = s.find("$")
s = s[poz:]
while True:
    # poz += 1
    s = s[1:]
    lungime = 0
    # extragem numarul
    # poz = s[poz:].find("$") + 1

    # .isnumeric daca toate caracterele sunt numere
    # daca pun \ pot sa continui pe urmatorul rand
    while (lungime+1 < len(s)
           and s[:poz+lungime+1].isnumeric() == True):
        lungime += 1
    print(s[:lungime])
    poz = s.find("$")
    # poz += lungime
    if(poz == -1):
        break
    else:
        s = s[poz:]
    # poz += test
    # print("Pozitie",poz)
quit()  # incheie programul
