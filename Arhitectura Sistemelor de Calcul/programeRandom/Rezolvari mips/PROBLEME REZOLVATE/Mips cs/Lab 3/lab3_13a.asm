#count length of a string
  
.data
string: .asciiz "Hello"

.text
main:
        la $t4, string
        subu $sp, $sp, 4

        sw $t4, 0($sp)


        jal strlen

        move $a0, $v0
        li $v0, 1
        syscall

        lw $t4, 0($sp)

        addi $sp, $sp, 4

        addi $v0, $0, 10
        syscall

strlen:
        lw $t7, 0($sp) 
        subu $sp, $sp, 8
        sw $ra, 0($sp)
        sw $fp, 4($sp)




        li $t0, 0 # count = 0
        loop:
                lb $t1, 0($t7) # load the next character into t1
                beqz $t1, exit
                addi $t7, $t7, 1 # incr pointer
        j loop
exit:
	
	la $t6, $t7
	la $t5, $fp
	
	
	sub $t7, 
        move $v0, $t0
        lw $ra, 0($sp)
        lw $fp, 4($sp)
	
        addiu $sp, $sp, 8
        jr $ra                                                                                      