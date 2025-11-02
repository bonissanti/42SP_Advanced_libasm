section .data
    base10 db "10", 0
    base16 db "16", 0

section .text
    global  ft_is_hexdigit
    global  ft_atoi_base
    global  handle_hex

    extern  ft_strcmp

; TIP: use ldd <program_name> to see library linked to bin

; verify if char is hexadecimal
ft_is_hexdigit:
    mov al, dil

    cmp al, '0'
    jb .not_hex
    cmp al, '9'
    jbe .is_hex_digit_true

    cmp al, 'a'
    jb .check_upper
    cmp al, 'f'
    jbe .is_hex_digit_true

 .check_upper:
    cmp al, 'A'
    jb .not_hex
    cmp al, 'F'
    jbe .is_hex_digit_true

 .not_hex:
    xor rax, rax
    ret
 .is_hex_digit_true:
    mov rax, 1
    ret

; handle hexadecimal chars
handle_hex:
    mov al, dil

    cmp al, '0'
    jb .return_zero
    cmp al, '9'
    jbe .digit

    cmp al, 'a'
    jb .check_upper
    cmp al, 'f'
    jbe .lower_hex
    jmp .return_zero

 .check_upper:
    cmp al, 'A'
    jb .return_zero
    cmp al, 'F'
    jbe .upper_hex
    jmp .return_zero

 .digit:
    sub al, '0'
    movzx rax, al
    ret

 .lower_hex:
    sub al, 'a'
    add al, 10
    movzx rax, al
    ret

 .upper_hex:
    sub al, 'A'
    add al, 10
    movzx rax, al
    ret

 .return_zero:
    xor rax, rax
    ret

ft_atoi_base:
    test rdi, rdi       ; check char *str
    jz .invalid

    test rsi, rsi       ; check char *base
    jz .invalid

    push r12
    push r13

    mov r12, rdi        ; save *str on r12
    mov r13, rsi        ; save *base on r13

    mov rdi, rsi        ; 1st arg = *base
    lea rsi, [rel base10]
    call ft_strcmp
    jz .base_10

    mov rdi, r13        ; 2nd arg = *base
    lea rsi, [rel base16]
    call ft_strcmp
    jz .base_16

    jmp .invalid

 .base_10:
    xor rax, rax
    xor r8, r8              ; signal = 0

    movzx rcx, byte [r12]
    cmp cl, '-'
    jne .loop_10
    inc r12
    mov r8, 1               ; signal = 1

 .loop_10:
    movzx rcx, byte [r12]
    test cl, cl             ; check null
    jz .apply_sign

    cmp cl, '0'
    jb .invalid
    cmp cl, '9'
    ja .invalid

    ; result = result * 10 + (char - '0')
    imul rax, 10
    sub cl, '0'
    movzx rcx, cl
    add rax, rcx

    inc r12
    jmp .loop_10

 .base_16:
    xor rax, rax

    movzx rcx, byte [r12]
    cmp cl, '0'
    jne .done

    movzx rcx, byte [r12 + 1]
    cmp cl, 'x'
    je .skip_prefix
    cmp cl, 'X'
    je .skip_prefix
    jne .invalid

 .skip_prefix:
    add r12, 2

 .loop_16:
    movzx rcx, byte [r12]
    test cl, cl
    jz .done

    push rax
    mov rdi, r12
    mov dil, cl
    call ft_is_hexdigit
    test rax, rax
    jz .restore_and_done

    mov dil, cl
    call handle_hex
    mov rcx, rax
    pop rax

    imul rax, 16
    add rax, rcx

    inc r12
    jmp .loop_16

.apply_sign:
    test r8, r8           ; Check if negative
    jz .done
    neg rax               ; Apply negative sign
    jmp .done

 .invalid:
    pop r13
    pop r12
    mov rax, 0
    ret

 .restore_and_done:
    pop rax
    jmp .done

 .done:
    pop r13
    pop r12
    ret