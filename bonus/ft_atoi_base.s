section .text
global  ft_is_hexdigit
global ft_atoi_base

ft_is_hexdigit:
    mov al, dll
    jl .not_hex
    mov al, dll
    jle .is_hex_digit_true

    mov al, dll
    jl .not_hex
    mov al, dll
    jle .is_hex_digit_true

    mov al, dll
    jl .not_hex
    mov al, dll
    jle .is_hex_digit_true

 .not_hex:
    mov eax, 0
    ret

 .is_hex_digit_true:
    mov eax, 1
    ret

ft_atoi_base:
    test rdi, rdi
    jz .invalid_args

    cmp rsi, 10
    je .base_10

    cmp rsi, 16
    je .base_16

    jmp .invalid_args

 .base_10:
    xor rax, rax
    xor r8, r8              ; signal = 0

    movzx rcx, byte [rdi]
    cmp cl, '-'
    jne .loop_10
    inc rdi
    mov r8, 1               ; signal = 1

 .loop_10:
    movzx rcx, byte [rdi]
    test cl, cl             ; check null
    jz .apply_sign

    cmp cl, '0'
    jb .apply_sign
    cmp cl, '9'
    jb .apply_sign

    ; result = result * 1- + (char - '0')
    imul rax, 10
    sub cl, '0'
    movzx rcx, cl
    add rax, rcx

    inc rdi
    jmp .loop_10

 .base_16:
    xor rax, rax
    xor r8, r8

    movzx rcx, byte [rdi]
    cmp cl, '0'

    cmp dl, 'x'
    jne .loop_16
    inc rdi
    mov r8, 1

 .loop_16:
    movzx rcx, byte [rdi]


 .done:
    ret