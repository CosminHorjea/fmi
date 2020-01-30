.data
x: .word 10
y: .word 11
z: .word 12
.text
main:
lw $t1,x+4 # incarca x in registrul t0
lh $t2,x+8
li $t3,14
sh $t3,$t2
li $v0,10
syscall