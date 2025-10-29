section .text
global  ft_list_remove_if

ft_list_remove_if:
  test rdi, rdi       ; check **begin_list
  je .done

  mov rax, [rdi]
  test rax, rax       ; check *begin_list
  je .done

  test rsi, rsi       ; check *data_ref
  je .done

  test rdx, rdx       ; check *cmp function
  je .done

  test rcx, rcx       ; check *free_fct function
  je .done

  push rbx
  push r12
  push r13
  push r14
  push r15
  push rcx            ; save *free_fct

  mov rbx, rdi        ; rbx == **begin_list
  mov r12, rsi        ; r12 == *data_ref
  mov r13, rdx        ; r13 == *cmp
  mov r14, [rdi]      ; *current = *begin_list
  xor r15, r15        ; *previous = NULL

  .loop:
    test r14, r14            ; while current != NULL
    je .done_list
    
    mov rdi, [r14]
    mov rsi, r12
    call r13

    test eax, eax         ; verify return from cmp
    je .remove_data

    mov r15, r14          ; previous = current;
    mov r14, [r14 + 8]    ; current = current->next
    jmp .loop

  .remove_data:
    push r14
    mov r14, [r14 + 8]  

    test r15, r15           ; verify if previous is null
    jz .update_head

    mov [r15 + 8], r14      ; previous->next = current
    jmp .free_data

  .update_head:
    mov [rbx], r14          ; *begin_list = current
    jmp .loop

  .free_data:
    pop rdi                 ; retire older rdi from stack
    push rdi
    mov rdi, [rdi]          ; rdi = to_delete->data
    call rcx                ; call free_rct
    pop rdi
    jmp .loop
 
  .done_list:
    pop rcx
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

  .done:
    ret

; vim:ft=nasm
