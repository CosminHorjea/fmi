.data
 v:.word 2, 1, 3, 2, 3, 6, 2, 3, 4, 1, 2, 9, 11  # vectorul
 n:.word 13              # nr. de elemente ale vectorului
 i:.space 4             # indice (putem folosi si un registru)
 suma:.word 0           # aici vom stoca suma
.text
main:
#initializari
 li $t0,-1
 sw $t0,i    # i:=0
#ciclu
intrare:
 lw $t0,i
 addi $t0,$t0,1
 sw $t0,i            # i:=i+1
 lw $t1,n
 bge $t0,$t1,iesire  # daca i>=n iesim din ciclu
 add $t0,$t0,$t0
 add $t0,$t0,$t0     # acum $t0=4*i, adica offsetul in octeti al lui v[i]
                     #  fata de v
 lw $t0,v($t0)       # $t0:=v[i]
 lw $t1,suma
 add $t1,$t1,$t0
 sw $t1,suma
 b intrare
iesire:
li $v0,1
lw $t3,suma
move $a0,$t3
syscall 
li $v0,10
syscall