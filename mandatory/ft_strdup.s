section .text
global  ft_strdup

extern   malloc
extern  ft_strlen
extern  ft_strcpy

ft_strdup:
    test rdi, rdi
    jz .error

    push rdi
    call ft_strlen
    inc rax

    mov rdi, rax
    call malloc wrt ..plt   ;(wrt) with respect to - reference point for an address or symbol
                            ;(..plt)procedure linkage table - mechanism in dynamically linked executables to
                            ; allows a program call functions located in shared libraries
    test rax, rax
    je .error_pop

    mov rdi, rax
    pop rsi
    push rax
    call ft_strcpy
    pop rax
    ret

    test rdi, rdi
    jz .error

  .error_pop:
    pop rdi

 .error:
    xor rax, rax
    ret