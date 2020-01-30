#Lab5: 3
.data
.text

main:
li $a0 ,1
li $a1 ,2
li $t0 ,5

loop:
jal proc
add $t0 ,$t0 ,-1
bnez $t0,loop

li$v0,10
syscall

proc:
# $a0 -> n-2
# $a1 -> n-1
# $a2 -> n
mulo $a0,$a0,3
add $a2,$a0,$a1
move $a0,$a1
move $a1,$a2

jr $ra











