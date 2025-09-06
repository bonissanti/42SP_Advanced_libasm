section .text
global ft_strcpy

ft_strcpy:
    xor     ecx, ecx

    test    rdi, rdi
    jz      .error
    test    rsi, rsi
    jz      .error

 .loop:
    movzx   rdx, byte [rsi + rcx]
    mov     [rdi + rcx], dl
    test    dl, dl
    je      .exit
    inc     rcx
    jmp     .loop

 .exit
    mov     rax, rdi
    ret

 .error
    xor rax, rax
    ret
