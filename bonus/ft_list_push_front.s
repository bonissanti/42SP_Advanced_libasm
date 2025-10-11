section .text
global ft_list_push_front

extern malloc

ft_list_push_front:
    ;rdi contains the address of the **ptr
    ;rsi is the void *data
    mov r12, [rdi] ; equivalent to r12 = *begin_list;
    test r12, r12
    jz .list_is_empty


  .list_is_empty:
    .loop_start:
    cmp r12, 0
    je .add_node_empty_list

    push rdi
    push rsi
    mov rdi, 16             ; sizeof(t_list) = 16 bytes, parameter for malloc
    call malloc wrt ..plt   ; returns pointer in rax
    pop rsi
    pop rdi

    mov [rax + 0], rsi      ; new_node->data = data
    mov [rax + 8], r12      ; new_node->next = *begin_list
    mov [rdi], rax          ; *begin_list = new_node
    ret

 .add_node_empty_list:
    push rdi
    push rsi
    mov rdi, 16             ; sizeof(t_list) = 16 bytes, parameter for malloc
    call malloc wrt ..plt   ; returns pointer in rax
    pop rsi
    pop rdi

    mov [rax + 0], rsi      ; new_node->data = data
    mov [rax + 8], DWORD 0  ; new_node->next = NULL - DWORD - instruction to CPU treated size specifier as a 32 bit
    mov [rdi], rax          ; *begin_list = new_node
    ret