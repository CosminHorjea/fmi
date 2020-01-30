# proceduri (aka functii)
.data
	mesaj: .asciiz "Hello world!\n"
.text
main:
	jal afisare #sare la afisare sidupa se intoarce in main
	# $ra adresa de memorie de unde a fost apelat jal
	# jal mereu va pune adresa in $ra (return adress)
	addi $a0,$0,100
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	
	afisare:
		li $v0,4
		la $a0,mesaj
		syscall
		jr $ra #jump register,  la adresa din main de unde a fost apelat "afisare"
		
		
		
		
		
		
		
		