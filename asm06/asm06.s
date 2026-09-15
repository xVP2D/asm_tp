section .bss
 result resb 3
section .text
 global _start

_start:
 mov rsi, [rsp+16]
 call parse
 mov r12, rax

 mov rsi, [rsp+24]
 call parse
 mov r13, rax

 add r12, r13

 mov rax, r12
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

parse:
 xor rax, rax

bc:
 movzx rcx, byte [rsi]
 test rcx, rcx
 je yes
 imul rax, rax, 10
 sub rcx, '0'
 add rax, rcx
 inc rsi
 jmp bc


yes:
 ret
