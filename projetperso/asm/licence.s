section .data
    server:
        dw 2
        dw 0x901F
        db 127, 0, 0, 1
        dq 0

    req1 db "POST /api/license HTTP/1.1", 13, 10
         db "Host: 127.0.0.1:8080", 13, 10
         db "Content-Type: application/json", 13, 10
         db "Connection: close", 13, 10
         db "Content-Length: "
    req1_len equ $ - req1

    req2 db 13, 10, 13, 10, '{"license":"'
    req2_len equ $ - req2
    body_pre_len equ 12

    req3 db '"}'
    req3_len equ $ - req3

    respok db "bienvenue", 10
    respok_len equ $ - respok
    respno db "Ce n'est pas la bonne licence", 10
    respno_len equ $ - respno
    resperr db "Erreur : impossible de contacter le serveur", 10
    resperr_len equ $ - resperr
    usage db "Usage : ./li <licence>", 10
    usage_len equ $ - usage

section .bss
    response resb 512
    numbuf   resb 20

section .text
global _start

_start:
    mov rax, [rsp]
    cmp rax, 2
    jl no_arg

    mov r12, [rsp+16]

    mov rcx, r12
.strlen:
    cmp byte [rcx], 0
    je .strlen_done
    inc rcx
    jmp .strlen
.strlen_done:
    sub rcx, r12
    mov r14, rcx

    mov rax, 41
    mov rdi, 2
    mov rsi, 1
    xor rdx, rdx
    syscall
    test rax, rax
    js net_error
    mov r13, rax

    mov rax, 42
    mov rdi, r13
    lea rsi, [rel server]
    mov rdx, 16
    syscall
    test rax, rax
    js net_error

    mov rax, 1
    mov rdi, r13
    lea rsi, [rel req1]
    mov rdx, req1_len
    syscall

    lea rax, [r14 + body_pre_len + req3_len]
    lea rdi, [rel numbuf + 20]
    mov rbx, 10
.itoa:
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz .itoa
    lea rdx, [rel numbuf + 20]
    sub rdx, rdi
    mov rsi, rdi
    mov rax, 1
    mov rdi, r13
    syscall

    mov rax, 1
    mov rdi, r13
    lea rsi, [rel req2]
    mov rdx, req2_len
    syscall

    mov rax, 1
    mov rdi, r13
    mov rsi, r12
    mov rdx, r14
    syscall

    mov rax, 1
    mov rdi, r13
    lea rsi, [rel req3]
    mov rdx, req3_len
    syscall

    mov rax, 0
    mov rdi, r13
    lea rsi, [rel response]
    mov rdx, 512
    syscall
    mov r15, rax

    mov rax, 3
    mov rdi, r13
    syscall

    cmp r15, 12
    jl net_error

    mov eax, [rel response + 9]
    and eax, 0x00FFFFFF
    cmp eax, '200'
    jne invalid

    mov rax, 1
    mov rdi, 1
    lea rsi, [rel respok]
    mov rdx, respok_len
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall

invalid:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel respno]
    mov rdx, respno_len
    syscall
    mov rax, 60
    mov rdi, 1
    syscall

net_error:
    mov rax, 1
    mov rdi, 2
    lea rsi, [rel resperr]
    mov rdx, resperr_len
    syscall
    mov rax, 60
    mov rdi, 2
    syscall

no_arg:
    mov rax, 1
    mov rdi, 2
    lea rsi, [rel usage]
    mov rdx, usage_len
    syscall
    mov rax, 60
    mov rdi, 1
    syscall
