section .data
 msg db "1337", 0ah
 buf db "    "

section .text
 global _start

_start:
 mov rax, 0
 mov rdi, 0
 mov rsi, buf
 mov rdx, 4
 syscall


 cmp rax, 2
 jne check


 cmp byte [buf], '4'
 jne fail
 cmp byte [buf+1], '2'
 jne fail
 je good

 mov rax, 1
 mov rdi, 1
 mov rsi, msg
 mov rdx, 5
 syscall

 mov rax, 60
 mov rdi, 0
 syscall


check:
 cmp byte [buf +2], 0ah
 jne fail
 
 cmp rax, 3
 jne fail
 je good


good:
 mov rax, 1
 mov rdi, 1
 mov rsi, msg
 mov rdx, 5
 syscall

 mov rax, 60
 mov rdi, 0
 syscall

fail:
 mov rax, 60
 mov rdi, 1
 syscall