section .data

section .text
 global _start


 
_start:
 mov rax, [rsp]
 cmp rax, 2
 jne fail

 mov rsi, [rsp + 16]    
 mov rdi, rsi
 xor rdx, rdx

c:
 cmp byte [rdi], 0
 je print
 inc rdi
 inc rdx
 jmp c

print:
 mov rax, 1
 mov rdi, 1
 syscall

 mov rax, 60
 mov rdi, 0
 syscall

fail:
 mov rax, 60
 mov rdi, 1
 syscall