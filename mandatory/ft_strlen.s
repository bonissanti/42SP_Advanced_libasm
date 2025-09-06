section .data
text:   db "Hello World!", 0

section .text
    global _start
    global ft_strlen

_start:
    mov     rdi, text
    call    ft_strlen
    mov     rdx, rax

    mov     rax, 1      ;sys_write syscall number (linux x64)
    mov     rdi, 1      ;file descriptor (stdout)
    mov     rsi, rdx    ;message to write
    syscall

exit:
    mov     rax, 60     ;sys_exit syscall number (linux x64)
    mov     rdi, 0      ;exit status
    syscall

ft_strlen:
    xor rax, rax
 .loop:
    cmp byte [rdi + rax], 0
    je .done
    inc rax
    jmp .loop

 .done:
    ret

section .bss
len: resb 4