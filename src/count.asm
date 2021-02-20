;--------------------------
; src/count.asm
; Counts to 10

%include "lib.inc"
%include "io.inc"

global	 _start

section	 .text

_start:
	xor		ecx, ecx

	.nextnum:
		inc 	ecx
		mov 	edi, ecx
		push	rcx
		call 	iprintln
		pop 	rcx
		
		cmp		ecx, 10 	; Count up to 10
		jl		.nextnum

	.finish:
		xor 	edi, edi
		call 	exit
