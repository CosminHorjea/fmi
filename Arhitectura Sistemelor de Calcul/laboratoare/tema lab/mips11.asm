.data
	alfabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ" #un string cu char din alfabet de care ne folosim pt a evita lucrul cu ASCII
	p : .word 4  #spatiu pentru p-ul citit
	powers: .space 400
	mesajPrim: .asciiz "Numarul nu este prim"
	newLine: .asciiz "\n"
	mesaj1: .space 400
	mesaj2: .space 400
	mesajGenerator: .asciiz "Generatorul este: "
.text
main:
	li $v0,5
	syscall
	sw $v0,p  #citesc un p si il slavez intr-o variabila
	li $t0,2 #de la 2
	lw $t1,p #la p
	blt $t1,$t0,exitPrim #daca este mai mic decat 2 
	prim: #verific daca numarul este prim
		mul $t2,$t0,$t0 #calculez $t0*$t0 a.k.a i*i 
		bge $t2,$t1,ePrim # verific daca i*i < p
		rem $t3,$t1,$t0	 #calcuelz restul
		beqz $t3,exitPrim #daca restul e 0, numarul are divizori, deci nu e prim
		addi $t0,$t0,1 #adaug la iterator
		j prim # jump inapui in loop 
			
exitPrim: 
	la $a0,mesajPrim #afisez mesajul din memorie pt numerele care nu sunt prime
	li $v0,4  # codul pt afisarea unei adrese
	syscall #execut
	j exit # jump in exit-ul default
ePrim:
	lw $t0,p # in incarc pe  p in t0
	subu $t1,$t0,1 # g-ul (aka p-1) e in $t1
	li $t2,1 #t2 e g care initial e 2 , adaug 1 in loop
	li $t3,1 # incep de la puterea 0
	li $t6,0 #pozitia in vectorul de puteri
	li $t5,1 # t5 e 1 pentru ca primul element din orice vector de puteri (element^0)
	li $t7,1 # verific daca restul la orice iteratie e 1, daca e, numarul testat pt a vedea daca este generator, nu e generator
	genPuteri: 
		addi $t2,$t2,1 #elementul pe care il testez acum
		sw $t5,powers($t6) #salvez pe prima pozitie 1
		move $t4,$t2 # fac o copie la $t2 (care e incercare pt generator, ca mai tarziu sa-l inmultesc pe $t4 cu $t2)
		genPuteri2:
			bge $t3,$t1,amGasitGenerator #inseamna ca am gasit un vector ( cu elementele de la 0 la g)
			rem $t5,$t4,$t0 #calculez restul si il salvez in t5
			beq $t5,$t7, nuEGenerator  #daca t5(restul) e 1, inseamna ca numarul nu e generator
			mul $t6,$t3,4 # calculez pozitia in vector ,$t6 e pozitia($t3,care e puterea *4(bytes pt un int))
			sw $t5,powers($t6) #il salvez pe $t5(restul) in vectorul powers pe pozitia $t6
			mul $t4,$t4,$t2  #inmultesc pe $t4 cu t2(care e elementul testat pt conditia de generator))
			rem $t4,$t4,$t0  #salvez mereu in $t4 restul modulo p, ca sa nu ajungem la numere mai mari decat p
			
			addi $t3,$t3,1  # adaug 1 la putere
			j genPuteri2    # jump la generarea urmatorului rest
nuEGenerator:
	li $t3,1 #daca nu e generator resetez puterea 
	j genPuteri #ma intorc sa testez unrmatorul element

	
amGasitGenerator:
	#in mom asta am in $t2 generatorul
	# si in "powers" puterile
	la $a0,mesajGenerator
	li $v0,4
	syscall
	move $a0,$t2
	li $v0,1
	syscall
	la $a0,newLine
	li $v0,4
	syscall
	la $a0,mesaj1
	li $a1,99
	li $v0,8
	syscall
	la $a0,mesaj2
	li $a1,99
	li $v0,8
	syscall
	li $t0,0 #pozitia in mesaj
	lb $t1,mesaj1($t0)
criptare:
	li $t7,10 #10 e codul pt newLine
	beq $t1,$t7,decriptare #mesajul a fost criptat, acum il tratam pe cel de-al doilea
	li $t3,0 #pozitia in alfabet
	cautInAlfabet:
		lb $t6, alfabet($t3)
		beq $t1,$t6,afisezPozInAlfabet
		addi $t3,$t3,1
		j cautInAlfabet
	
afisezPozInAlfabet: #am gasit pe ce poz e in alfabet
	li $t5,4
	mul $t4,$t3,$t5
	lw $t7,powers($t4)
	lb $a0,alfabet($t7)
	li $v0,11
	syscall
	addi $t0,$t0,1
	lb $t1,mesaj1($t0)
	j criptare

decriptare:
	la $a0,newLine
	li $v0,4
	syscall
	li $t0,0
	lb $t1,mesaj2($t0)
	decriptare2:
		li $t7,10 #10 e codul pt newLine
		beqz $t1,exit # la al doilea mesaj, in MARS trebuie beq $t1,$t7 pt ca imi consiera un newLine si la al doilea cuv
		li $t3,0 #pozitia in powers
		cautInPowers:
			lb $t6, powers($t3)
			lb $t5, alfabet($t6)
			beq $t1,$t5,afisezCaracterDecodat
			addi $t3,$t3,4
			j cautInPowers
afisezCaracterDecodat:
	#t1 e litera din mesaj criptat
	# t3 e pozitia din powers(mult de 4)
	#t6 e poz literei in alfabet
	#li $t5,4
	divu $t4,$t3,4
	lb $t7,alfabet($t4)
	move $a0,$t7
	li $v0,11
	syscall
	addi $t0,$t0,1
	lb $t1,mesaj2($t0)
	j decriptare2
exit:
	li $v0,10 #termin programul
	syscall