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

    jal sign
    addiu $sp, 4        #descarc parametrul actual
                        #$v0 = -1/0/1 dupa caz
    bgtz $v0, afisare1
    beqz $v0, afisare2
    bltz $v0, afisare3

sign :
    subu $sp, 4         #la intrare stiva este $sp : (x)
    sw $fp, 0($sp)
    addiu $fp, $sp, 0   #acum stiva este $sp: $fp: ($fp v) (x)
    
    lw $t0, 4($fp)      #$t0 = x

    bgtz $t0, unsignedNumber     #$t0 > 0
    beqz $t0, isZero             #$t0 == 0
    bltz $t0, signedNumber       #$t0 < 0

    unsignedNumber:
        addu $v0, $zero, 1
        j intrerupere
    isZero :
        addu $v0, $zero, 0
        j intrerupere
    signedNumber:
        addu $v0, $zero, -1
        j intrerupere

    intrerupere:
        lw $fp, 0($fp)      #restauram $fp
        addu $sp, 4         #descarc cadrul de apel, stiva acum este $sp :(x)
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
afisare3 :
    li $v0, 4
    la $a0, signed
    syscall
    j sfarsit

sfarsit:
    li $v0, 10
    syscall
    
