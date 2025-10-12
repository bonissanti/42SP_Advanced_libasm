section .text
global  ft_list_sort

extern  ft_list_size

ft_list_sort:
    xor rax, rax
    mov rbx, rsi
    push rbx
    push rdi        ;save **begin_list

    mov rdi, [rdi]  ;dereference - rdi = *begin_list
    call ft_list_size
    mov r14, rax    ;save list size
    pop rdi
    pop rbx

 .outer_loop:
    cmp r14, 0
    je .done
    mov r10, [rdi]      ;t_list *current = *begin_list
    mov r11, [rdi]      ;t_list *previous = *begin_list

 .inner_loop:
    mov r12, [r10 + 8]
    test r12, r12
    jz .end_inner_loop

    push r12
    push r11
    push r10
    mov rdi, [r10]      ;pass to rdi to be used in strcmp (rdi) - 1st param
    mov rsi, [r12]      ;pass to rsi to be used in strcmp (rsi) - 2nd param
    call rbx                ;call strcmp
    pop r10
    pop r11
    pop r12

    cmp rax, 0      ;compare result from strcmp
    jg .is_greater
    jmp .no_swap

 .is_greater:
    cmp r10, r12
    je .swap_and_update_head
    mov r13, [r12 + 8]  ;load temp->next into r13
    mov [r10 + 8], r13  ;store r13 into current->next
    mov [r12 + 8], r10
    mov [r11 + 8], r12
    mov r11, r12
    jmp .inner_loop

 .swap_and_update_head:
    mov r13, [r12 + 8]  ;load temp->next into r13
    mov [r10 + 8], r13  ;store r13 into current->next
    mov [r12 + 8], r10  ;temp->next = current
    mov [rdi], r12
    mov r11, r12
    jmp .inner_loop

 .no_swap:
    mov r11, r10        ;previous = current
    mov r10, [r10 + 8]  ;current = current->next
    jmp .inner_loop

 .end_inner_loop:
    dec r14
    jmp .outer_loop

 .done:
    ret
