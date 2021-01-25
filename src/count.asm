; Counting program; counts to 10

%include 'io.asm'

section	 .text
global	 _start

_start:
	mov 	ecx, 0

.nextnum:
	inc 	ecx
	mov 	eax, ecx
	call 	iprintln
	cmp		ecx, 10
	jne		.nextnum

	mov		eax, exit_success
	call 	exit
