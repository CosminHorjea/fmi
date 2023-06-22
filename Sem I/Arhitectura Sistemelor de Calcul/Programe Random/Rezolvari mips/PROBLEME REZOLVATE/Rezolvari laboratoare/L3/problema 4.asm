#Laboratorul 3: 4
.data
x: .word 5
.text
main:
lw $t0,x 
la $t1,x+4
 
move $t7,$t0
mulo $t2,$t0,$t7
li $t3,2
mulo $t4,$t2,$t3

li $t8,4
mulo $t9,$t8,$t0

sub $t5,$t4,$t9

li $t3,12

add $t6,$t5,$t3

sw $t6,($t1)
li $v0,10
syscall