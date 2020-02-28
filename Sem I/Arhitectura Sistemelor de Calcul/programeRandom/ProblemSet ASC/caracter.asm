.data

.text
main:
	li $a0,'a'
	bgtz
	li $v0,11
	syscall
	li $v0,10
	syscall