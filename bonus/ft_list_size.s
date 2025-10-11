section .text
global ft_list_size

extern malloc

ft_list_size:
    xor rax, rax
    test rdi, rdi
    jz .list_is_empty

 .loop_start:
    cmp rdi, 0
    je .done
    inc rax
    mov rdi,  [rdi + 8]
    jmp .loop_start

 .list_is_empty:
    xor rax, rax
    ret

 .done:
    ret