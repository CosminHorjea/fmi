.text

#count length of a string

.data
string: .asciiz "Hello"

.text

.macro strlen($v)
	la $t3, ($v)
	li $t0, 0 # count = 0
	loop:
		lb $t1, 0($t3) # load the next character into t1
		beqz $t1, exit 
		addi $a0, $a0, 1 # incr pointer
		addi $t3, $t3, 1 # count ++
	j loop
	
	exit:
		 j continue

.end_macro

main:
	la $a0, string
	strlen($a0)
	continue: 
	move $a0, $v0 
	li $v0, 1
	syscall
	
        addi $v0, $0, 10    
        syscall

