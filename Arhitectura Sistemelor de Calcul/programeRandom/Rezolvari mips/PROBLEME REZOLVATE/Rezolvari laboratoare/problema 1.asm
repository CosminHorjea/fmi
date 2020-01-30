.data
x: .word 1
y: .word 2
.text
main:
lw $t0,x 
lw $t1,y 
move $t3,$t0
move $t0,$t1
move $t1,$t3
sw $t0,x 
sw $t1,y
li $v0,10
syscall