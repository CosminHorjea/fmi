.data
    read :.asciiz "Introduceti de la tastatura numarul : \n"
    unsigned:.asciiz "Numarul este pozitiv"
    signed:.asciiz "Numarul este negativ"
    zero:.asciiz "Numarul este egal cu 0"
.text
main:

    li $v0, 4           #afisare mesaj in consola
    la $a0, read
    syscall

    li $v0, 5           #citire numar din consola
    syscall
    move $t0, $v0       #salvare valoare

    subu $sp, 4         #incarc parametrul actual
    sw $t0, 0($sp)

    jal sign            #apelez functia

    lw $t0, 0($sp)      #retin valoarea returnata
    addu $sp, 4         #descarc valoarea returnata de stiva

    bgtz $t0, afisare1
    beqz $t0, afisare2

    li $v0, 4
    la $a0, signed
    syscall
    j sfarsit

sign :
    subu $sp, 4         #intrare stiva este $sp : (x)       
    sw $fp, 0($sp)      #rezerv loc pentru salvarea $fp 
    addiu $fp, $sp, 0   #acum stiva este $sp: $fp: ($fp v) (x)

    lw $t0, 4($fp)      #$t0 = x

    bgtz $t0, unsignedNumber     #$t0 > 0
    beqz $t0, isZero             #$t0 == 0

    li $t0, -1
    sw $t0, 4($fp)
    j intrerupere       #$t0 < 0

    unsignedNumber:
        li $t0, 1
        sw $t0, 4($fp)
        j intrerupere
    isZero :
        sw $zero, 4($fp)
        j intrerupere

    intrerupere:
        lw $fp, 0($fp)      #restauram $fp
        addu $sp, 4         #descarc cadrul de apel, stiva acum este $sp :(val. returnata)
    jr $ra

afisare1 : 
    li $v0, 4
    la $a0, unsigned
    syscall
    j sfarsit

afisare2 :
    li $v0, 4
    la $a0, zero
    syscall
    j sfarsit

sfarsit:
    li $v0, 10
    syscall
    
