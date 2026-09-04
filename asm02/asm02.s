section .data
    msg db "1337", 0ah
    buf db "  "

section .text
  global _start

_start:
 mov rax, 0    
 mov rdi, 0      
 mov rsi, buf 
 mov rdx, 2              
 syscall


 cmp ax, bx
 je     Equal
 mov rax, 1
 mov rdi, 1
 mov rsi, msg
 mov rdx, 5
 syscall
 mov rax, 60
 mov rdi, 0
 jl     Less


 mov rax, 60

 syscall
  