; Hello World program that reads from stdin
;
;
;

%define sys_read 3

%define stdin 0

%include 'funcs.asm'

section .data
msg1	db	'Please enter your name: ', 0
msg2	db	'Hello, ', 0

section	.bss
input	resb	255

section .text
global	_start

_start:
	mov	eax, msg1
	call	print

	mov	edx, 255
	mov	ecx, input
	mov	ebx, stdin
	mov	eax, sys_read
	int	80h
	
	mov	eax, msg2
	call	print
	
	mov	eax, input
	call	print

	call	exit

