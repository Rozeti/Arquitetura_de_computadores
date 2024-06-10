# Algoritmo em MIPS/MARS para calcular a sequência de Fibonacci e a razão áurea

.data
prompt_term:   .asciiz "Digite o numero do termo da sequencia de Fibonacci que deseja saber: "
result_fib:    .asciiz "\nO termo da sequencia de Fibonacci e: "
phi_text:      .asciiz "\nA razao aurea (phi) e: "

.text
main:
    # Pergunta o termo ao usuário
    li $v0, 4                  # syscall para imprimir string
    la $a0, prompt_term        # endereço da string
    syscall

    li $v0, 5                  # syscall para ler inteiro
    syscall
    move $a0, $v0              # move o valor lido para $a0 (n)

    # Chama a função fibonacci para calcular o termo informado pelo usuário
    jal fibonacci
    move $t0, $v0              # armazena o resultado em $t0

    # Mostra o termo de Fibonacci calculado
    li $v0, 4                  # syscall para imprimir string
    la $a0, result_fib         # endereço da string
    syscall

    li $v0, 1                  # syscall para imprimir inteiro
    move $a0, $t0              # valor do termo calculado
    syscall

    # Calcula o 30° termo de Fibonacci e armazena em $s1
    li $a0, 30
    jal fibonacci
    move $s1, $v0              # armazena o resultado em $s1

    # Calcula o 41° termo de Fibonacci e armazena em $s2
    li $a0, 41
    jal fibonacci
    move $s2, $v0              # armazena o resultado em $s2

    # Calcula o 40° termo de Fibonacci e armazena em $s3
    li $a0, 40
    jal fibonacci
    move $s3, $v0              # armazena o resultado em $s3

    # Calcula a razão áurea (phi) e armazena em $f0
    jal calc_phi

    # Mostra a razão áurea (phi)
    li $v0, 4                  # syscall para imprimir string
    la $a0, phi_text           # endereço da string
    syscall

    li $v0, 2                  # syscall para imprimir float
    mov.s $f12, $f0            # move o valor da razão áurea para $f12
    syscall

    # Saída do programa
    li $v0, 10                 # syscall para sair
    syscall

# Função para calcular o n-ésimo termo da sequência de Fibonacci
# Entrada: $a0 = n
# Saída: $v0 = Fibonacci(n)
fibonacci:
    addi $sp, $sp, -8          # aloca espaço na pilha
    sw $ra, 4($sp)             # salva o valor de retorno
    sw $a0, 0($sp)             # salva o argumento n

    li $t1, 1                  # Fibonacci(1)
    li $t2, 1                  # Fibonacci(2)

    beq $a0, 1, fib_base_1     # se n == 1, retorna 1
    beq $a0, 2, fib_base_2     # se n == 2, retorna 1

    move $t3, $a0              # n
    subi $t3, $t3, 2           # n - 2
fib_loop:
    beqz $t3, end_fib_loop     # se $t3 == 0, termina o loop
    add $t4, $t1, $t2          # $t4 = $t1 + $t2 (próximo termo de Fibonacci)
    move $t1, $t2              # $t1 = $t2 (atualiza termo anterior)
    move $t2, $t4              # $t2 = $t4 (atualiza termo atual)
    subi $t3, $t3, 1           # decrementa o contador
    j fib_loop
end_fib_loop:
    move $v0, $t2              # retorna o valor de Fibonacci(n)
    j fib_return

fib_base_1:
    li $v0, 1
    j fib_return

fib_base_2:
    li $v0, 1
    j fib_return

fib_return:
    lw $a0, 0($sp)             # restaura o argumento n
    lw $ra, 4($sp)             # restaura o valor de retorno
    addi $sp, $sp, 8           # desaloca espaço na pilha
    jr $ra                     # retorna

# Função para calcular a razão áurea (phi)
# Saída: $f0 = phi
calc_phi:
    mtc1 $s2, $f2              # move F(41) para $f2
    mtc1 $s3, $f4              # move F(40) para $f4
    cvt.s.w $f2, $f2           # converte F(41) para float
    cvt.s.w $f4, $f4           # converte F(40) para float
    div.s $f0, $f2, $f4        # $f0 = $f2 / $f4
    jr $ra                     # retorna
