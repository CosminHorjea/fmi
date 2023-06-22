.data
x: .word 10
y: .word 11
z: .word 12
.text
main:
lw $t3,x+4
la $t1,x+8 
li $t2,14
sh $t2,($t1)
li $v0,10
syscall