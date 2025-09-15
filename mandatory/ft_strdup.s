section .text
global  ft_strdup

extern  malloc
extern  ft_strlen
extern  ft_strcpy

ft_strdup:
    mov rdi, rdi
    call ft_strlen
    inc rax

    mov rdi, rax
    call malloc wrt ..plt

    test rax, rax
    je .error

    mov rbx, rax

    mov rdi, rbx
    mov rsi, rsi
    call ft_strcpy

    mov rdi, 0
    ret

 .error:
    mov rdi, 1
    ret