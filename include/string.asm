;----------------------------------------------------------------
; String utility functions.
; - strlen: 	Find the length of a string.
; - atoi:	Convert an ascii string to an integer.	

;---------------------------------------
; int atoi(string str)
; Convert an ascii string to an integer.
atoi:
	push	ebx
	push	ecx
	push	edx
	push	esi

	mov	esi, eax	; move the string into the 'source register'	
	mov	eax, 0
	mov	ecx, 0		; the offset of the current char

.convertloop:
	xor	ebx, ebx
	mov	bl, [esi+ecx]	; move the current char into the bl (8bit) register
	cmp	bl, 48		; compare against '0'
	jl	.finish		; not a string
	cmp	bl, 57		; compare against '9'
	jg	.finish		; not a string

	; Otherwise...
	sub	bl, 48		; convert current char to an int digit
	add	eax, ebx	; add this to our sum
	mov	ebx, 10
	mul	ebx		; eax * ebx : to get place value
	inc	ecx
	jmp	.convertloop

.finish:
	cmp	ecx, 0		; not an int
	jz	.restore
	
	mov	ebx, 10
	div	ebx		; eax / ebx : undo extra place value shift

.restore:
	pop	esi
	pop	edx
	pop	ecx
	pop	ebx
	ret

;---------------------------------------	
; int strlen(string str)
; Calculates the length of a string
; returns the length in register eax
strlen:
	push	ebx		; preserve ebx
	mov	ebx, eax	; let eax & ebx point to the string
	
.nextchar:
	cmp 	byte [eax], 0 	; compare the byte pointed to by 'eax' against zero (end of string)
	jz	.finish		; exit this loop if was zero
	inc	eax		; increment the pointer
	jmp	.nextchar	; repeat

.finish:
	sub	eax, ebx	; subtract ending pointer from the starting pointer

.restore:			; eax now contains the length of the string
	pop	ebx		; restore ebx
	ret

