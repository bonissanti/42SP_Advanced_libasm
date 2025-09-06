section .data
text:   db "Hello World!", 0

section .text
    global _start

_start:
    mov     ebx, 1      ;file descriptor (stdout)
    mov     eax, 1      ;system call number (sys_write | 64bit linux)
    mov     ecx, text    ;message to write
    call    ft_strlen
    mov     edx, [len]    ;len of string to print
    syscall         ;call for linux (x86_64 arch) execute code

exit:
    mov     eax, 1      ;system call number (sys exit)
    mov     ebx, 0      ;fd to read-only
    syscall

ft_strlen:
    push    ebp
    mov     ebp, esp

    push    ecx
    dec     ecx
.loop       inc ecx
    cmp     byte [ecx], 0
    jne     .loop
    sub     ecx, [esp]
    mov     [len], ecx  ;save length
    pop     ecx
    ret

section .bss
len: resb 4