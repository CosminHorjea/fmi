.data
    myVector: .word 1 5 10 6 8 99 10
    myVectorSize: .word 7
    resultMessage: .asciiz "Maximul din vector este "
    myVectorMax: .word 0
    
.text
    main:
        la $a0, myVector
        lw $a1, myVectorSize
        lw $v0, myVectorMax
    
        jal recursiveMax
        move $fp, $zero
        
        sw $v0, myVectorMax
        
        li $v0, 4
        la $a0, resultMessage
        syscall
        
        li $v0, 1
        lw $a0, myVectorMax
        syscall
    
        li $v0, 10
        syscall
    
    recursiveMax: #a0 - adresa de inceput, $a1 - lungimea secventei, $t3 maximul din prima jumatate, $t4 maximul din a 2a jumatate
    	move $fp, $sp
        sub $sp, $sp, 20
        sw $fp, ($fp)
        sw $a0, -4($fp)
        sw $a1, -8($fp)
        sw $ra, -16($fp)
        lw $t1, -8($fp)
        
        beq, $t1, 1, oneElement
        
        div $a1, $a1, 2
        
        jal recursiveMax
        
        move $t3, $v0
        sw $t3, -12($fp)
        lw $fp, ($fp)
        lw $t2, -8($fp)
        sub $a2, $t2, $a1 #numarul de elemente din cealalta jumatate
        
        mul $t2, $a1, 4
        move $a1, $a2 
        add $a0, $a0, $t2 #adresa de inceput a celeilalte jumatati
        
        jal recursiveMax
         
        move $t4, $v0
        lw $t3, -12($fp)
        lw $fp, ($fp)
        
        jal maximum
        
        lw $a0, -4($fp)
        lw $a1, -8($fp)
        lw $ra, -16($fp)
        
        #"Curat" memoria
        sw $zero, ($fp)
        sw $zero, -4($fp)
        sw $zero, -8($fp)
        sw $zero, -12($fp)
        sw $zero, -16($fp)
        
        move $sp, $fp
        add $fp, $fp, 20
        
        jr $ra
        
        oneElement:
            
            lw $v0, ($a0)
            
            #"Curat" memoria
            sw $zero, ($fp)
            sw $zero, -4($fp)
            sw $zero, -8($fp)
            sw $zero, -12($fp)
            sw $zero, -16($fp)
            
            move $sp, $fp
            add $fp, $fp, 20
            
            jr $ra
        
    maximum:
        bge $t3, $t4, second
        
        move $v0, $t4
        
        jr $ra
        
        second:
        
        move $v0, $t3
        
        jr $ra
        
        
        
    