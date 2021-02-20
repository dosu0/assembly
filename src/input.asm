;----------------------------------------------------------------------------
; src/input.asm
; Designed for 64bit macOS
; Prompts for your name and then prints "Hello, <your inputted name>"
;

%include "lib.inc"
%include "io.inc"

global	_start

default rel

section .data
	prompt:	db	"Please enter your name: ", 0
	msg2:	db	"Hello, ", 0

section	.bss
	input:	resb	255

section .text

_start:
	; print(&prompt)
	lea		rdi, [prompt]
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

	.exit:
		; exit(0)
		xor		rdi, rdi
		call	exit
