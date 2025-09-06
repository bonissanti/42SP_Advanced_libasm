section .text
global ft_strcmp

ft_strcmp:
    xor rax, rax

    test rdi, rdi
    jz .done
    test rsi, rsi
    jz .done

  .loop:
    mov cl, byte [rdi + rax]
    mov dl, byte [rsi + rax]

    cmp cl, dl
    jne .return_diff

    cmp cl, 0
    je .return_zero

    inc rax
    jmp .loop

  .return_diff:
    sub cl, dl
    movsx rax, cl ;TODO: research about movsx
    ret

  .return_zero:
    xor rax, rax
    ret

  .done:
    ret