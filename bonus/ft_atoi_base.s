section .text
global  ft_is_digit

ft_is_digit:
    mov al, dil

    cmp al, '0'
    jl not_a_digit

    cmp al, '9'
    jg not_a_digit

    mov rax, 1
    ret

 not_a_digit:
    mov rax, 0
    ret

ft_is_hexdigit:
    mov al, dil

    cmp al, '0'
    jl not_a_hexdigit

    cmp al, '9'
    jg not_a_hexdigit

    cmp al, 'a'
    jl not_a_hexdigit

    cmp al, 'f'
    jg not_a_hexdigit

    cmp al, 'A'
    jl not_a_hexdigit

    cmp al, 'F'
    jg not_a_hexdigit

    mov rax, 1
    ret

 not_a_hexdigit:
    mov rax, 0
    ret

