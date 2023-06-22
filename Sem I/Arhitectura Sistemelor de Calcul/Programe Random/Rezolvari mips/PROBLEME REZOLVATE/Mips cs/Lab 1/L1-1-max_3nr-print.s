#max:=max(x,y,z)
.data
 x:.word 6
 y:.word 4
 z:.word 7
 max:.word 0

 maxim: .asciiz "Maximul dintre: " 
 space: .asciiz ", "
 equal: .asciiz " = "

.text
main:
 lw $t0,x
 lw $t1,y
 lw $t2,z
 lw $t3,max

#test
slt $t4, $t0, $t1   # $t4 = 1, daca $t0 < $t1, altfel $t4 = 0
beq $t4, $zero, else #if false go to else
add $t3, $zero, $t1   # $t1 mai mare => il punem in $t3
j endif # goto endif
else:
  add $t3, $zero, $t0
endif:

slt $t4, $t3, $t2   # $t4 = 1, daca $t3 < $t2, altfel $t4 = 0
beq $t4, $zero, else1 #if false go to else
add $t3, $zero, $t2   # $t1 mai mare => il punem in $t3
j endif1 # goto endif
else1:
  add $t3, $zero, $t3
endif1:
 
sw, $t3, max


#Afisare: 
 li $v0, 4
 la $a0, maxim
 syscall

  #afisam x - primul nr
 li $v0,1
 lw $a0,x
 syscall

 li $v0, 4
 la $a0, space
 syscall

  #afisam y - al doilea nr
 li $v0,1
 lw $a0,y
 syscall

 li $v0, 4
 la $a0, space
 syscall

 #afisam z - al treilea nr
 li $v0,1
 lw $a0,z
 syscall

 
 li $v0, 4
 la $a0, equal
 syscall

 li $v0,1
 lw $a0,max
 syscall


li $v0,10
syscall