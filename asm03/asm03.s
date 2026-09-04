section .data
 msg db "1337", 0ah
 msglen equ $-msg

section .text
 global _start

_start:
 mov rax, [rsp]
 cmp rax, 2
 jne fail

 mov rsi, [rsp + 16] 

 cmp word  [rsi], '42'
 jne fail

 mov rax, 1
 mov rdi, 1
 mov rsi, msg
 mov rdx, msglen
 syscall

 mov rax, 60
 mov rdi, 0
 syscall

fail:
 mov rax, 60
 mov rdi, 1
 syscall