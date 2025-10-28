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
    cmp r14, 0            ; while current != NULL
    je .done_list
    
    mov rdi, [r14]
    mov rsi, r12
    call r13

    test eax, eax         ; what is eax even?
    je .remove_data       ; TODO: should be update_head instead

    mov r15, r14          ; previous = current;
    mov r14, [r14 + 8]    ; current = current->next
    jmp .loop

  .remove_data:           ; FIX: need to be implemented and change position with update_head
    test r15, r15
    jz .update_head
    

  .update_head:
    mov rdi, r14
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
