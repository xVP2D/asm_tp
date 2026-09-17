section .bss
	bf resb 16

section .text
	global _start

_start:
	xor edi, edi
	mov rsi, bf
	mov edx, 16
	xor eax, eax
	syscall

	mov rsi, bf
	xor r8, r8
pl:
	lodsb
	sub al, '0'
	cmp al, 9
	ja dn
	imul r8, r8, 10
	add r8, rax
	jmp pl
dn:
	mov r9, 2
	xor edi, edi
	cmp r8, 2
	jb fl
lp:
	mov rax, r9
	imul rax, rax
	cmp rax, r8
	jg ok
	mov rax, r8
	xor edx, edx
	div r9
	test edx, edx
	jz fl
	inc r9
	jmp lp
fl:
	mov edi, 1
ok:
	mov eax, 60
	syscall