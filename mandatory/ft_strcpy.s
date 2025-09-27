section .text
global ft_strcpy

ft_strcpy:
    xor     ecx, ecx

    test    rdi, rdi
    jz      .error
    test    rsi, rsi
    jz      .error

 .loop:
    movzx   rdx, byte [rsi + rcx]   ; load
    mov     [rdi + rcx], dl         ; process
    test    dl, dl                  ; test
    je      .exit
    inc     rcx
    jmp     .loop

 .exit:
    mov     rax, rdi
    ret

 .error:
    xor rax, rax
    ret
