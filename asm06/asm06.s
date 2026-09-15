section .bss
 result resb 3
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

 mov rcx, 10
 xor rdx, rdx
 div rcx

 add al, '0'
 add dl, '0'
 mov [result], al
 mov [result+1], dl
 mov byte [result+2], 10

 mov rax, 1
 mov rdi, 1
 mov rsi, result
 mov rdx, 3
 syscall

 mov rax, 60
 xor rdi, rdi
 syscall
