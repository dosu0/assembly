;-----------------------------------------
; src/x64/args.asm
; Prints each command line argument on
; a new line

%include 'io.asm'

section .text
global _start

_start:
	pop 	rcx			; The first value on the stack is the amount of arguments
						; passed in to the executable
.nextarg:
	cmp		rcx, 0		; If there are no arguments remaining exit
	jz		.finish


	pop		rdi			; Get the next argument
	push 	rcx
	call	println		; and print it
	pop 	rcx

	dec		rcx			; one less argument
	jmp 	.nextarg	; repeat

.finish:
    xor     rdi, rdi
	call 	exit
