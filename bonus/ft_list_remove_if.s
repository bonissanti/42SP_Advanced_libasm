section .text
global  ft_list_remove_if

ft_list_remove_if:
  test rdi, rdi     ; check **begin_list
  je .done

  mov rax, [rdi]    ; check *current
  test rax, rax
  je .done

  push rbx
  push r12
  push r13
  push r14
  push r15

  mov rbx, rdi       ; r11 = **begin_list
  xor r12, [rdi]    ; r12 = *current
  mov r13, r13      ; r13 = previous NULL
  mov r14, rsi      ; r14 = data_ref 
  mov r15, rdx      ; r15 = cmp function
  push rcx          ; rcx = free function

  .loop:                  ; while (current != NULL)
    test r12, r12
    je .done
    
    mov rdi, [r12]
    mov rsi, r14
    call r15

    test eax, eax         ; check if is equal 0 to remove
    je .remove_item

    mov r13, r12          ; previous = current
    mov r12, [r12 + 8]    ; current = current->next
    jmp .loop

  .remove_item:
    push rbx
    mov rbx, r12          ; to_delete = *current
    mov r12, [r12 + 8]    ; current = current->next

    test r13, r13
    jz .update_head

    mov [r13 + 8], r12    ; r13 + 8 = previous->next = current
    jmp .free_data

    mov r13, r12          ; previous = current
    mov r12, [r12 + 8]    ; current = current->next

  .update_head:
    mov [rbx], r12        ; *begin_list = current
    jmp .loop
  
  .free_data:
    pop rdi
    push rdi
    mov rdi, [rbx]        ; rdi = to_delete->data
    call rcx              ; call free_fct
    pop rdi               ; restore rdi
    jmp .loop

  .done:
    ret

; vim:ft=nasm
