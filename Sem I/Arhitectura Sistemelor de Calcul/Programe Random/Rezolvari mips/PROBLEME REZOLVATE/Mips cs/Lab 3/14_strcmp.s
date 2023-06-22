.data
msg1:.asciiz "Introduceti sirul pentru comparare (max 20 caractere): "
msg2:.asciiz "\n siruri diferite"
msg3:.asciiz "\nsirurile seamana"
str1: .space 20
str2: .space 20
.text
.globl main

main:
li $v0,4
la $a0,msg1
syscall

li $v0,8
la $a0,str1
addi $a1,$zero,20
syscall   #am citit primul sir

li $v0,4
la $a0,msg1
syscall

li $v0,8
la $a0,str2
addi $a1,$zero,20
syscall   #am citit al doilea sir

la $a0,str1  #am copiat primul sir in a0
la $a1,str2  #am copiat al doilea sir in a1
jal strcmp  #am apelat functia strcmp

beq $v0,$zero,ok #verific rezultat
li $v0,4
la $a0,msg2
syscall
j exit

ok:
li $v0,4
la $a0,msg3
syscall

exit:
li $v0,10
syscall

strcmp:
#add $t0,$zero,$zero
add $t1,$zero,$a0
add $t2,$zero,$a1
loop:
lb $t3($t1)  #incarc inca un byte din string
lb $t4($t2)
beqz $t3,checkt2 
beqz $t4,missmatch
slt $t5,$t3,$t4  #compara 2 bytes
bnez $t5,missmatch
slt $t5,$t4,$t3  #compara 2 bytes
bnez $t5,missmatch
addi $t1,$t1,1 
addi $t2,$t2,1
j loop

missmatch: 
addi $v0,$zero,1
j endfunction
checkt2:
bnez $t4,missmatch
add $v0,$zero,$zero

endfunction:
jr $ra
