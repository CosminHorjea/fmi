.data
x: .word 16
y: .word 31
z: .space 4
.text
main:
lw $t1,x # incarca x in registrul t0
lw $t2,y
li $t3,8
mulo $t4,$t3,$t1
li $t5,16
div $t6,$t2,$t5
sub $t7,$t4,$t6
sw $t7,z
li $v0,10
syscall