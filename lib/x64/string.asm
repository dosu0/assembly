;----------------------------------------------------------
; String utility functions.
; - strlen: Find the length of a string.
; - atoi:	Convert an ascii string to an integer.	

;---------------------------------------
; int atoi(string str)
; Convert an ascii string to an integer.
atoi:
	push	rsi
	push	rdx
	push	rcx
	push	esi

	mov		rsi, rdi		; move the string into the 'source register'	
	mov		rdi, 0
	mov		rdx, 0			; the offset of the current char

.convertloop:
	xor		rsi, rsi
	mov		bl, [rsi+rdx]	; move the current char into the bl (8bit) register
	cmp		bl, 48			; compare against '0'
	jl		.finish			; not a string
	cmp		bl, 57			; compare against '9'
	jg		.finish			; not a string

	; Otherwise...
	sub		bl, 48			; convert current char to an int digit
	add		rdi, rsi		; add this to our sum
	mov		rsi, 10
	mul		rsi				; rdi * rsi : to get place value
	inc		rdx
	jmp		.convertloop

.finish:
	cmp		rdx, 0			; not an int
	jz		.restore

	mov		rsi, 10
	div		rsi				; rax / rsi : undo extra place value shift

.restore:
	pop		esi
	pop		rcx
	pop		rdx
	pop		rsi
	ret

;---------------------------------------	
; int strlen(string str)
; Calculates the length of a string
; returns the length in register rdi
strlen:
	mov		rax, rdi		; let rdi & rsi point to the string
	
.nextchar:
	cmp 	byte [rax], 0 	; compare the byte pointed to by 'rdi' against 
							; zero (end of string)
	jz		.finish			; exit this loop if was zero
	inc		rax				; increment the pointer
	jmp		.nextchar		; repeat

.finish:
	sub		rax, rdi		; subtract ending pointer from the starting pointer
							; rdi now contains the length of the string
.restore:
	ret
