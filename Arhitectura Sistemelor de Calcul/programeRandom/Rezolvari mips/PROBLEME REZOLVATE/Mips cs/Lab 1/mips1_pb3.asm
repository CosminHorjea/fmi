.data
s: .space 4
v: .word 1 2 3 4 5 6
n: .word 6

.text

main:
lw $t3,n
li $t0,4
mul $t3,$t3,$t0 #t3 = t3*4 = 4*n
lw $t4,n #i
li $t1,0

subu $t4,$t4,1
mul $t4,$t4,4

for:

 blt  $t4,0 ,iesire
 lw $t0,v($t4)
 add $t1, $t1, $t0
  subu $t4,$t4,4
  j for
  
iesire: 

li $v0,1
sw $t1, s
move $a0, $t1
syscall

li $v0,10
syscall