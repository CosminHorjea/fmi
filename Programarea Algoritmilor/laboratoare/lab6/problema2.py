import random

def solve(i1,j1,i2,j2,trees):
    global rez
    tmp=[]
    for(i,j)in trees:
        if(i1<i<i2 and j1<j<j2):
            tmp.append((i,j))# vad cati copaci se afla pe zona in care caut(initial e tot dreptunghiul
    if(len(tmp)==0):# daca nu am copaci
        arie_curr=(i2-i1)*(j2-j1) #calculez aria
        if(arie_curr>rez[2]): # daca aria pe care am obtinut-o e mai mare decat cea mai mare pe care o am la un moment dat (rez[2])
            rez=[(i1,j1),(i2,j2),arie_curr]#atunci schimb rez cu totul
    else:
        coord = random.choice(tmp)# daca un copac este pe margine, nu se considera inaria selectata , deci elimin unul la intamplare
        solve(coord[0], j1, i2, j2, trees) # merg in partea din dreapta
        solve(i1, j1, coord[0], j2, trees) # partea stanga
        solve(i1, coord[1], i2, j2, trees) # partea de sus
        solve(i1, j1, i2, coord[1], trees) # parea de jos ( totate relativ la copacul ales)


with open("copaci.in") as f:
    st_i,st_j=map(int,f.readline().split())# coltul din stanga jos
    fn_i,fn_j=map(int,f.readline().split())# coltun din dreapta sus
    n=int(f.readline()) #nr de copaci / useless
    trees =[] # lista cu coord copacilor
    for line in f:
        i,j=(map(int,line.split()))
        trees.append((i,j)) # populez lista cu puncte
rez = [(0,0),(0,0),0] # rezultatul :[colt stanga jos, colt stanga sus, arie]
solve(st_i,st_j,fn_i,fn_j,trees)


with open("copaci.out", 'w') as fout:
    fout.write("Dreptunghiul: ")
    fout.write(f"{rez[0]} x {rez[1]}\n")
    fout.write("Aria maxima: ")
    fout.write(str(rez[2]))