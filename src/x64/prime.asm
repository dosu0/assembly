;--------------------------------------------------
; src/x64/prime.asm
; Generates the 10,000th prime number.

; %include 'io.asm'

%include 'io.asm'

section .data
msg		db 	'The 10000th prime number is ', 0

section .text
global 	_start

_start:
	; mov     rcx, 0          ; candidate
	; mov     rbx, 0          ; prime numbers found
	; mov	 rdx, 0			; answer

	mov		rdi, 0
	call	exit