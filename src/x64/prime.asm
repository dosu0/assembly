;--------------------------------------------------
; src/x64/prime.asm
; Generates the 10,000th prime number.

; %include 'io.asm'

default rel

%include 'io.asm'

section .data
begin_text:	
	db "Generating prime #"
	db 0
usage: 	
	db "Usage: prime <n>"
	db 0

section .text
global 	_start

_start:
	pop		rcx
	cmp		ecx, 2
	jne		.usage

	pop 	rdi
	pop 	rdi
	call 	atoi
	push	rax
	
	lea 	rdi, [begin_text]
	call 	print

	pop 	rdi
	call 	iprintln

	jmp	 	.exit

.usage:
	lea 	rdi, [usage]
	call 	println
	mov		edi, 1 ; unsuccessful
	call	exit

.exit:
	xor 	edi, edi
	call	exit