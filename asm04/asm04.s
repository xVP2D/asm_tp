section .data
 buf: times 32 db 0

section .text
 global _start

_start:
 mov rax, 0
 mov rdi, 0
 mov rsi, buf
 mov rdx, 32
 syscall

 mov rcx, rax    
 mov rdi, buf      

scan:
 cmp rcx, 0
 je fail
 mov al, [rdi]
 cmp al, '0'
 jb next
 cmp al, '9'
 ja next
 jmp test

next:
 inc rdi
 dec rcx
 jmp scan

test:
 test al, 1
 jz pair

impair:
 mov rax, 60
 mov rdi, 1
 syscall

pair:
 mov rax, 60
 mov rdi, 0
 syscall

fail:
 mov rax, 60
 mov rdi, 2
 syscall