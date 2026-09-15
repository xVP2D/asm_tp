section .bss
 buf: resb 32

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
 mov r8, 0

 cmp rcx, 0
 je fail

 mov al, [rdi]
 cmp al, '-'
 jne scan
 inc rdi
 dec rcx

scan:
 cmp rcx, 0
 je check
 mov al, [rdi]
 cmp al, 10
 je check
 cmp al, '0'
 jb fail
 cmp al, '9'
 ja fail
 mov r8, 1
 mov r9b, al
 inc rdi
 dec rcx
 jmp scan

check:
 cmp r8, 0
 je fail

test:
 test r9b, 1
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