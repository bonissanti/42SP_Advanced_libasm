section .text
global  ft_list_sort

ft_list_sort:
    test rdi, rdi
    je .done

    mov rax, [rdi]
    test rax, rax
    je .done

    push r12
    push r13
    push r14

    mov r12, rdi    ; r12 = begin_list
    mov r13, rsi    ; r13 = cmp function
    xor r14, r14    ; r14 = lastSorted = NULL

 .do_while:
    xor ebx, ebx    ; swapped = 0
    mov rdi, [r12]  ; current = *begin_list

 .inner_loop:
    mov rax, [rdi + 8]
    cmp rax, r14
    je .end_inner_loop

    push rdi
    mov rdi, [rdi]
    mov rsi, [rax]
    call r13
    pop rdi

    test rax, rax
    jle .no_swap

    mov rsi, [rdi]      ; temp = current->data
    mov rcx, [rdi + 8]  ; rcx = current->next
    mov rax, [rcx]      ; rax = current->next->data
    mov [rdi], rax      ; current->data = current->next->data
    mov [rcx], rsi      ; current->next->data = temp
    mov ebx, 1          ; swapped = 1

 .no_swap:
    mov rdi, [rdi + 8]
    jmp .inner_loop

 .end_inner_loop:
    mov r14, rdi        ; lastSorted = current
    test ebx, ebx
    jne .do_while

    pop r14
    pop r13
    pop r12

 .done:
    ret