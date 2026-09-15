section .bss
 result resb 2

section .text
 global _start

_start:
 mov rsi, [rsp+16]
 movzx rax, byte [rsi]
 sub rax, '0'

 mov rsi, [rsp+24]
 movzx rbx, byte [rsi]
 sub rbx, '0'

 add rax, rbx
 add rax, '0'

 mov [result], al
 mov rax, 1
 mov rdi, 1
 mov rsi, result
 mov rdx, 2
 syscall

 mov rax, 60 
 xor rdi, rdi
 syscall
