;----------------------------------------------------------------------------
; src/x64/input.asm
; Designed for 64bit macOS - prints "Hello, <your inputted name>"
;

default rel

%define stdin 0

%include 'io.asm'

section .data
msg1	db	'Please enter your name: ', 0
msg2	db	'Hello, ', 0

section	.bss
input	resb	255

section .text
global	_start

_start:
	; print(&msg1)
	lea		rdi, [msg1]
	call	print

	; read(stdin, &input, 255)
	mov		rdx, 255
	lea		rsi, [input]
	mov		rdi, stdin
	mov		rax, sys_read
	syscall
	
	; print(&msg2)
	lea		rdi, [msg2]
	call	print
	
	; print(&input)
	lea		rdi, [input]
	call	print
	
	; exit(0)
	xor		rdi, rdi
	call	exit



