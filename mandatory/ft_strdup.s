section .text
global  ft_strdup

extern  malloc
extern  ft_strlen
extern  ft_strcpy

ft_strdup:
    push rdi
    mov rdi, rdi
    call ft_strlen
    inc rax

    mov rdi, rax
    call malloc wrt ..plt

    test rax, rax
    je .error

    mov rdi, rax
    call ft_strcpy

    mov rsi, rax
    pop rsi
    ret

 .error:
    mov rdi, 1
    ret