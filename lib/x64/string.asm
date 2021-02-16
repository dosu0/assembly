;----------------------------------------------------------
; lib/x64/string.asm
; String utility functions.
; strlen(char* str)	Find the length of a string.
; atoi(char* str)		Convert an ascii string to an integer.	

;---------------------------------------
; int atoi(char* str)
; Convert an ascii string to an integer.
atoi:
	push 	rcx
	push 	rdx
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
	pop 	rcx
	pop 	rdx
	ret

;---------------------------------------	
; i64 strlen(char* str)
; Calculates the length of a string
; returns the length in register rdi
strlen:
	push 	rdi
	push 	rcx
	xor 	al, al
	mov		rcx, -1

    ; while (*rdi != '\0') rcx--;
	repnz 	scasb ; the real 'magic'
	not 	rcx
	mov		rax, rcx

	pop 	rcx
	pop 	rdi
	ret

;---------------------------------------	
; i64 strlen(char* str)
; Calculates the length of a string
; returns the length in register rdi
; normal impl
; strlen:
; 	mov		rax, rdi		; let rdi & rax point to the string
	
; .nextchar:
; 	cmp 	byte [rax], 0 	; compare the byte pointed to by 'rdi' against 
; 							; zero (end of string)
; 	jz		.finish			; exit this loop if was zero
; 	inc		rax				; increment the pointer
; 	jmp		.nextchar		; repeat

; .finish:
; 	sub		rax, rdi		; subtract ending pointer from the starting pointer
; 							; rax now contains the length of the string
; .restore:
; 	ret
