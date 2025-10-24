section .text
global  ft_list_remove_if

ft_list_remove_if:
  test rdi, rdi     ; check **begin_list
  je .done

  mov rax, [rdi]    ; check *current
  test rax, rax
  je .done

  push rbx
  push r11
  push r12
  push r13
  push r14
  push r15

  mov r11, rdi      ; r11 = **begin_list
  xor r12, r12      ; previous = NULL
  mov r13, rsi      ; r13 = data_ref
  mov r14, rdx      ; r14 = cmp function
  mov r15, rcx      ; r15 = free function

  .loop:
    push rax
    mov rdi, [r11]  ; rdi = *begin_list
    mov rax, [rdi]  ; rax = current->data
    mov rsi, r13    ; pass data_ref to rsi
    call r14        ; call cmp
    pop rax

    cmp eax, 0      ; check if is equal 0 to remove
    je .remove_item

    mov r12, rdi          ; previous = current
    mov rdi, [r11 + 8]    ; current = current->next
    jmp .loop

  .remove_item:
    mov rax, r11          ; to_delete = *current
    mov r11, [r11 + 8]    ; current = current->next

    cmp rax, 0                  ; previous == NULL
    je if_previous_is_null







; vim:ft=nasm
