.data
msgNum1: .asciiz "Informe o primeiro valor: "
msgNum2: .asciiz "Informe o segundo valor: "
msgNum3: .asciiz "Informe o terceiro valor: "
msgResultado: .asciiz "O MMC dos valores informados e: "

.text
.globl main

main:
    li $v0, 4
    la $a0, msgNum1
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0 
    
    li $v0, 4
    la $a0, msgNum2
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0
    
    li $v0, 4
    la $a0, msgNum3
    syscall
    
    li $v0, 5
    syscall
    move $t2, $v0 

    move $a0, $t0
    move $a1, $t1
    move $a2, $t2
    
    move $t3, $a0
    move $t4, $a1
    
MMC1:
    move $t5, $t4
    
MMC1_loop:
    rem $t6, $t3, $t4
    beq $t6, $zero, MMC1_end
    move $t3, $t4
    move $t4, $t6
    j MMC1_loop
    
MMC1_end:
    div $t7, $a0, $t4
    mul $t7, $t7, $a1
    
    move $t3, $t7
    move $t4, $a2
    
MMC2:
    move $t5, $t4
    
MMC2_loop:
    rem $t6, $t3, $t4
    beq $t6, $zero, MMC2_end
    move $t3, $t4
    move $t4, $t6
    j MMC2_loop
    
MMC2_end:
    div $t8, $t7, $t4
    mul $t8, $t8, $a2  
    
    li $v0, 4
    la $a0, msgResultado
    syscall
    
    li $v0, 1
    move $a0, $t8
    syscall
    
    li $v0, 10
    syscall
