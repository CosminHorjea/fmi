n= 4

x=[0]*100
def bkt(k): #k e pozitita din stiva
    global x,n
    # print(k)
    for v in range(1,n+1): # pt fiecare valoare posibila (care e de la 1 la n) pt ca suma
        x[k]=v # pun pe pozitia k val v
        cort = sum(x[:k+1])# suma pana la poz k inclusiv
        if cort<=n: # daca suma e mai mica sau egala pot sa continui, daca e mai mare deja nu mai are rost sa trec pe urm pozitie si o sa uit de solutia curenta
            if cort == n: # daca e fix suma e blana si o printez
                print("".join(map(str,x[:k+1])))
            else: # altfel trec pe urmatoarea pozitie
                bkt(k+1)

bkt(0)