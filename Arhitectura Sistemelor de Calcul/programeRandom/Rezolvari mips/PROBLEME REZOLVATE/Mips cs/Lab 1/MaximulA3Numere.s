.data
    x:.space 4
    y:.space 4
    z:.space 4
    max:.space 4
    str1:.asciiz "Please enter the numbers :\n"
    str2:.asciiz "Gratest number is :\n"
.text
main:

    li $v0, 4
    la $a0, str1
    syscall

    li $v0, 5
    syscall
    add $t0, $zero, $v0
    sw $t0, x

    li $v0, 5
    syscall
    add $t0, $zero, $v0
    sw $t0, y

    li $v0, 5
    syscall
    add $t0, $zero, $v0
    sw $t0, z

    lw $t0, x
    sw $t0, max
    lw $t1, y
    bge $t0, $t1 et1
    sw $t1, max
    et1:
        lw $t0, max;
        lw $t1, z
        bge $t0, $t1 et2
        sw $t1, max
        et2 :
            li $v0, 4
            la $a0, str2
            syscall
            li $v0, 1
            lw $a0, max
            syscall

    li $v0, 10
    syscall




