section .text
global ft_list_size

extern malloc

ft_list_size:
    xor rax, rax
    mov r12, [rdi]
    test r12, r12
    jz .list_is_empty

 .loop_start:
    cmp r12, 0
    je .done
    inc rax
    mov [r12 + 8], r12
    jmp .loop_start

 .list_is_empty:
    xor rax, rax
    ret

 .done:
    ret