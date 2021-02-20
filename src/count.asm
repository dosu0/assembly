;--------------------------
; src/count.asm
; Counts to 10

%include "lib.inc"
%include "io.inc"

global	 _start

section	 .text

_start:
	xor		r8, r8

	.nextnum:
		inc 	r8
		mov 	rdi, r8
		call 	iprintln
		
		cmp		r8, 10 		; Count up to 10
		jl		.nextnum

	.finish:
		xor 	edi, edi
		call 	exit
