section .text
global  ft_write
extern  __errno_location

ft_write:
    mov rax, 1  ; sys_write system call number, already contains:
    ;   rdi (fd - first param),
    ;   rsi (buffer - second param),
    ;   rdx (length - third param)
    syscall

    test rax, rax
    js .error
    ret

 .error:
    neg rax
    mov rdi, rax
    call __errno_location wrt ..plt
    mov [rax], rdi
    mov rax, -1
    ret
