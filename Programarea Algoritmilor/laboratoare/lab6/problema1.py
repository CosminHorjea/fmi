#  Problema Rucascului cu Divide
#  all credit goes to : https://github.com/micu01/
#  Repo-ul pe care l-am folosti ca sa inteleg :https://github.com/micu01/ProgAlgo2019-2020
def mm_pivot(lst):
    # lst= lista cu raportul dintre val si greutate (x[3])
    if(len(lst)<=5):
        return sorted(lst)[len(lst)//2] # daca lista are mai putin de 5 el, o sortez si returnez el din mijloc(mediana)
    sublst = [lst[i:i+5]for i in range(0,len(lst),5)]# altfel fac subliste de cate 5 el
    new_lst = [sorted(l)[len(l)//2] for l in sublst] # creez o noua lista cu medianele din subliste
    return mm_pivot(new_lst) # fac acelasi lucru pentru lista noua

def quickSelect(rez,lst,G,pickPivot):
    piv=pickPivot([x[3]for x in lst]) # aleg mediana dintre rapoarte
    L = [x for x in lst if x[3]<piv] # toate elementele sub val mediana
    E = [x for x in lst if x[3]==piv] # toate cele gale
    H = [x for x in lst if x[3]>piv] # toate cele mai mari decat pivot-ul
    if G<sum([x[1] for x in H]): # daca elemntele cu raportul mai mare deact mediana aleasa trec cu greutatea peste G
        return quickSelect(rez,H,G,mm_pivot)#vreau profit maxim, deci trebuie sa mut problema pe multimea acelor elemente
    else: # altfel
        rez += [(ob,1)for ob in H] # toate cele cu val mai mare dat pivotul sunt bune si le pun in sol
        G-=sum([x[1]for x in H]) # scad G-ul ca sa vad cat mai pot sa bag in rucsac
        for ob in E: # fiecare obiect in alea egale cu mediana
            if G>ob[1]: # daca mai e loc de obiectul curent
                rez.append((ob,1)) # il adaug in rucsac
                G-=ob[1] # scad spatiul disponibil
            else:
                rez.append((ob,G/ob[1])) #pot sa bag doar o parte din el ,deci adaug cat de mul pot din el
                G=0 # nu mai am loc clar
                break
        if G!=0: # daca am mai ramas cu loc liber
            return quickSelect(rez,L,G,mm_pivot) # fac acelasi lucru cu ob ramsae,cele care sunt mai mici decat mediana

f = open('rucsac.in', 'r')

G = int(f.readline()) # greutatea admisa in rucsac

obiecte = []
for i,linie in enumerate(f.readlines()):
    g,v = (map(int, linie.split()))
    obiecte.append((i+1,g,v,v/g))# obiectele sunt de tipul (index,greutate,valuare,raportul dintre cele doua)
if sum([ob[1] for ob in obiecte])<G:# daca greutatea tutror ob sunt mai mici decat G atunci e clar
    rez = [(ob,1)for ob in obiecte]
else:
    rez=[]
    quickSelect(rez,obiecte,G,mm_pivot)


with open("rucsac.out", 'w') as fout:
    # fout.write("Nr.".ljust(5)+"g".center(5)+"v".center(5)+"rap".center(5)+"procent\n".center(5))
    for ob in rez:
        fout.write(str(ob[0][0]).ljust(5) + str(ob[0][1]).center(5) + str(ob[0][2]).center(5) + f"{ob[0][3]: .2f}".center(5) + f"{ob[1]: .3f}\n".center(5))
    fout.write(f"Castig maxim: {sum([ob[0][2] * ob[1] for ob in rez])}")
