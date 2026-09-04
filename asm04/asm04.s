section .data
 buf db "  "


section .text
 global _start

_start:

 mov rax, 0
 mov rdi, 0
 mov rsi, buf
 mov rdx, 2
 syscall

 cmp byte [buf], '9'
 ja fail
 cmp byte [buf], '0'
 jb fail

 test byte [buf], 1
 jz pair
 jnz impair



fail:
 mov rax, 60
 mov rdi, 2
 syscall

pair:
 mov rax, 60
 mov rdi, 0
 syscall

impair: 
 mov rax, 60
 mov rdi, 1
 syscall
