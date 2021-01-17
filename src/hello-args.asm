; Hello World program

%include 'funcs.asm'

section .text
global _start

_start:
	pop ecx			; The first value on the stack is the amount of arguments
				; passed in to the executable
nextarg:
	cmp	ecx, 0		; If there are no arguments remaining exit
	jz	finish

	pop	eax		; Get the next argument
	call	println		; and print it

	dec	ecx		; one less argument
	jmp 	nextarg		; repeat

finish:
	call exit
