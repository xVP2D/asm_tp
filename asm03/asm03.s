section .data
 msg db "1337", 0ah
 buf db "  "

section .text
 global _start

_start:

 mov rax, [rsp]
 cmp rax, 2
 mov rsi, [rsp + 16] 
 cmp byte rsi, '42'
 mov rax, 1
 mov rdi, 1
 mov rsi, msg
 mov rdx, 5
 syscall

 mov rax, 60
 mov rdi, 0
 syscall
 jne fail

fail:
 mov rax, 60
 mov rdi, 1
 syscall