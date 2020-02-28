#Laboratorul 3: 2
.data
var1: .word 16
var2: .word 31
var3: .word 0
.text
main:
lw $t0,var1 
lw $t1,var2 
li $t2,8
mulo $t3,$t2,$t0
li $t4,16
div $t5,$t1,$t4
sub $t6,$t3,$t5
sw $t6,var3
li $v0,10
syscall