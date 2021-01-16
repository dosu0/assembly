;-------------------------
; Utility functions
; - print: 	Print a message to stdout
; - println: 	Print a message to stdout with new line character
; - strlen: 	Find the length of a string
; - exit:	Call sys_exit(0)

; Linux System Calls
%define sys_write 4
%define sys_exit 1

; Constants
%define exit_sucess 0
%define stdout 1
;------------------------------------
; int strlen(string str)
; Calculates the length of a string
; returns the length in register eax
strlen:
	push	ebx		; preserve ebx
	mov	ebx, eax	; let eax & ebx point to the string
	
nextchar:
	cmp 	byte [eax], 0 	; compare the byte pointed to by 'eax' against zero (end of string)
	jz	finished	; exit this loop if was zero
	inc	eax		; increment the pointer
	jmp	nextchar	; repeat

finished:
	sub	eax, ebx	; subtract ending pointer from the starting pointer
				; eax now contains the length of the string
	pop	ebx		; restore ebx
	ret

;----------------------------
; void print(string str)
; Write a message to stdout
print:
	; Preserve the registers used
	push	edx
	push	ecx
	push	ebx
	push	eax

	call	strlen

	mov	edx, eax 	; message length arg
	pop	eax		; restore eax ( the msg pointer arg )	

	mov 	ecx, eax	; message pointer arg
	mov	ebx, stdout 	; file pointer arg

	mov	eax, sys_write
	int	80h
	
	; Restore other registers
	pop	ebx
	pop	ecx
	pop	edx
	ret
;-----------------------------------------
; void println(string str)
; Write a message to stdout with a new line
println:
	call	print
	
	push	eax
	mov	eax, 10 	; new line char
	push	eax
	mov	eax, esp	; eax now points to the new line char
	call	print		; print new line char

	pop	eax		; remove new line char
	pop	eax		; restore eax
	ret

;------------------
; void exit()
; Exit the program
exit:
	mov	ebx, exit_sucess
	mov	eax, sys_exit
	int	80h
