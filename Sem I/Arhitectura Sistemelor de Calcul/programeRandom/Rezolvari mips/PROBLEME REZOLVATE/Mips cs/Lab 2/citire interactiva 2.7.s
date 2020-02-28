.data
 v:.space 40
 n:.word 0
 i:.space 4
 start:.asciiz "v["
 end:.asciiz "]="
 endline:.asciiz "\n"
.text
main:
 li $v0,5
 syscall
 sw $v0,n
 lw $t1,n
 li $t0,-1
 sw $t0,i
readcicle:
 lw $t0,i
 addi $t0,$t0,1
 sw $t0,i
 bge $t0,$t1,next1
 add $t0,$t0,$t0
 add $t0,$t0,$t0
 li $v0,5
 syscall
 sw $v0,v($t0)
 b readcicle
next1:
 li $t0,-1
 sw $t0,i
writecicle:
 lw $t0,i
 addi $t0,$t0,1
 sw $t0,i
 bge $t0,$t1,next2
 add $t0,$t0,$t0
 add $t0,$t0,$t0
 li $v0,4
 la $a0,start
 syscall
 li $v0,1
 lw $a0,i
 syscall
 li $v0,4
 la $a0,end
 syscall
 li $v0,1
 lw $a0,v($t0)
 syscall
 li $v0,4
 la $a0,endline
 syscall
 b writecicle
next2:
 li $v0,10
 syscall