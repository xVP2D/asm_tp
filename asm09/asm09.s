section .data
	hx db "0123456789ABCDEF"

section .bss
	bf resb 80

section .text
	global _start

_start:
	mov rcx, [rsp]
	mov r11, 4
	mov r9, 15
	cmp rcx, 2
	je one
	cmp rcx, 3
	jne e2

	mov rsi, [rsp+16]
	cmp word [rsi], '-b'
	jne e2
	cmp byte [rsi+2], 0
	jne e2
	mov r11, 1
	mov r9, 1
	mov rsi, [rsp+24]
	jmp go
one:
	mov rsi, [rsp+16]
	cmp word [rsi], '-b'
	jne go
	cmp byte [rsi+2], 0
	je e2
go:
	xor r8, r8
	xor r10, r10
	xor eax, eax

	mov al, [rsi]
	cmp al, '-'
	jne ps
	mov r10, 1
	inc rsi
	jmp chk
ps:
	cmp al, '+'
	jne chk
	inc rsi
chk:
	cmp byte [rsi], 0
	je e1
pl:
	xor eax, eax
	lodsb
	test al, al
	jz dn
	sub al, '0'
	cmp al, 9
	ja e1
	imul r8, r8, 10
	add r8, rax
	jmp pl
dn:
	mov rax, r8
	lea rsi, [bf+79]
	mov byte [rsi], 10
	mov rcx, r11
cv:
	mov rdx, rax
	and rdx, r9
	mov dl, [hx+rdx]
	dec rsi
	mov [rsi], dl
	shr rax, cl
	test rax, rax
	jnz cv

	test r10, r10
	jz wr
	test r8, r8
	jz wr
	dec rsi
	mov byte [rsi], '-'
wr:
	lea rdx, [bf+80]
	sub rdx, rsi
	mov eax, 1
	mov edi, 1
	syscall

	mov eax, 60
	xor edi, edi
	syscall

e1:
	mov eax, 60
	mov edi, 1
	syscall

e2:
	mov eax, 60
	mov edi, 2
	syscall