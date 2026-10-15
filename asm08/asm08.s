section .bss
	bf resb 32

section .text
	global _start

_start:
	mov rcx, [rsp]
	cmp rcx, 2
	jne e2

	mov rsi, [rsp+16]
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
	xor eax, eax
	test r10, r10
	jnz pr
	cmp r8, 1
	jbe pr


	mov rax, r8
	lea rcx, [r8-1]
	mul rcx
	shrd rax, rdx, 1

pr:
	lea rsi, [bf+31]
	mov byte [rsi], 10
	mov rcx, 10
cv:
	xor edx, edx
	div rcx
	add dl, '0'
	dec rsi
	mov [rsi], dl
	test rax, rax
	jnz cv

	lea rdx, [bf+32]
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