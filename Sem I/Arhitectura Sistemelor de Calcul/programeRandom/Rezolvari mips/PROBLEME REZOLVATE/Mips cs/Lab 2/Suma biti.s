#suma bitilor
.data
	n:.word 255
	s:.word 0
.text
main:
	lw $t0,s
	lw $t1,n
intrare:
	beqz $t1,sfarsit
	andi $t2,$t1,1
	add $t0,$t0,$t2
	srl $t1,$t1,1
	j intrare
sfarsit:
	sw $t0,s
li $v0,10
syscall