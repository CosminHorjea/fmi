#Lab6:1(c)
.data
string1: .asciiz "Dati numarul de elemente al matricei.\n"
string3: .asciiz "Dati elementele ,matricei.\n"
string2: .asciiz "matricea este:\n"
newline: .asciiz "\n"
n: .word 0
l1: .word 1
l2: .word 3
elem: .space 64
.text

main:
li $v0, 4
la $a0,string1
syscall

li $v0, 5
syscall
sw $v0, n
lw $t0,n #memorare nr de elem n in reg t0
lw $t3,n
lw $t4,n

mulo $t0,$t0,$t0
li $t1,0
la $t2, elem #initializare t2 cu adresa la care se memoreaza primul element
li $v0, 4 #afisare mesaj de introdus elemente
la $a0,string3
syscall

#introducere elemente
loop:
beq $t0,$t1,end_loop
addi $t1,1
li $v0, 5 #in bucla se citeste fiecare element
syscall

sw $v0, ($t2) #se pune elementul la urmatoarea adresa in zona de date;
addi $t2,4 # adresarea se face din 4 in 4
b loop

end_loop:

# citire l1
li $v0, 5
syscall
sw $v0, l1
lw $t8,l1

# citire l2
li $v0, 5
syscall
sw $v0, l2
lw $t9,l2

li $t7,0
add $t8,$t8,-1
mulo $t7,$t8,$t4  #ajung la pr elem dp linia1
mulo $t7,$t7,4    
la $s1,elem      #ma pozitionez la adresa primului element
add $s1,$t7,$s1

li $t7,0
add $t9,$t9,-1
mulo $t7,$t9,$t4
mulo $t7,$t7,4
la $s2,elem
add $s2,$t7,$s2

li $t1,0

parcurgere:
lw $t5,0($s1)
lw $t6, 0($s2)
sw $t5,0($s2)
sw $t6,0($s1)
addi $s1,4
addi $s2,4
addi $t1,1
beq $t1,$t4,iesire
b parcurgere

iesire:
#de aici incep afisarea
li $v0, 4
la $a0,string2
syscall
li $t1,0
la $t2, elem
loop_afisare: #afisarea valorilor
beq $t0,$t1,end_loop_afisare

beq $t4,$t1 new_line
lw $a0,($t2) #afisarea valorii de la adresa memorata in t2
li $v0,1
syscall
addi $t2,4
addi $t1,1
b loop_afisare
new_line:
add $t4,$t4,$t3
li $v0, 4
la $a0, newline
	syscall
b loop_afisare

end_loop_afisare:
li $v0,10 #oprire executie program
syscall