#Laboratorul 3: 3
.data
x: .word 10
y: .word 11
z: .word 12
.text
main:
#a:
lw $t3,x+4
#b:
la $t1,x+8 
li $t2,14
sh $t2,($t1)

li $v0,10
syscall