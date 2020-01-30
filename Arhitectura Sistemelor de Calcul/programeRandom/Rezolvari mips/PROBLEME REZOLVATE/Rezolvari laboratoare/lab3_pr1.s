.data
x: .word 1
y: .word 2
.text
main:
lw $t1,x # incarca x in registrul t0
lw $t2,y
move $t0,$t1
move $t1,$t2
move $t2,$t0 
li $v0,10
syscall