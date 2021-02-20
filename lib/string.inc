;----------------------------------------------------------
; lib/string.inc
; String utility functions.
; strlen(char* str)	Find the length of a string.
; atoi(char* str)		Convert an ascii string to an integer.	

%ifndef STRING_INC_
%define STRING_INC_

;---------------------------------------
; int atoi(char* str)
; Convert an ascii string to an integer.
atoi:
	push 	rcx
	push 	rdx
	push 	rsi

	xor		ecx, ecx
	xor 	eax, eax 	; sum

.loop:
	xor 	edx, edx
	mov 	dl, [rdi+rcx]
	
	cmp 	dl, 48 		; ascii 0
	jl 		.shift_back
	cmp 	dl, 57
	jg 		.shift_back
	sub 	dl, 48		; conv to ascii repr

	; Shift place value
	add 	eax, edx
	mov 	esi, 10
	mul 	esi

	inc 	ecx
	jmp 	.loop

.shift_back:
	cmp 	ecx, 0
	je 		.restore  	; an integer was not passed
	div 	esi			; undo extra place value shift

.restore:
	pop 	rsi
	pop 	rdx
	pop 	rcx
	ret

;---------------------------------------	
; i64 strlen(char* str)
; Calculates the length of a string
; returns the length in register rdi
strlen:
	push 	rcx
	push 	rdi 		; apparently rdi is modified?

	xor 	al, al 		; let al = 0
	mov		rcx, -1 	; let rcx = 111111...

	repnz 	scasb 		; while (deref(rdi) != al and rcx != 0) rcx--;

	not 	rcx			; 111...11100 -> 000...00011 (repnz counts down)
	mov		rax, rcx	; return rcx
	.restore:
		pop 	rdi
		pop 	rcx
		ret

%endif