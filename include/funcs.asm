;----------------------------------------------------------------
; Utility functions
; - iprint:	Print an interger to stdout
; - iprintln:	Print an integer to stdout with a new line
; - print: 	Print a string to stdout
; - println: 	Print a string to stdout with a new line
; - strlen: 	Find the length of a string
; - exit:	Call sys_exit(0)

%include 'syscalls.asm'

; Constants
%define exit_sucess 0
%define stdout 1

;--------------------------------------------------------
; void iprint(int num)
; Print an integer to stdout
iprint:
	; Preserve registers
	push	eax
;	push	ebx
	push	ecx
	push	edx
	push 	esi
	
	mov	ecx, 0 		; Counter of how many bytes are going to be printed

divideloop:
	inc	ecx

	mov	edx, 0		; empty edx
	mov	esi, 10
	idiv	esi		; eax / esi
	add	edx, 48 	; Convert the remainder to an ascii character
	push	edx
	cmp	eax, 0		; Have we finished converting?
	jnz	divideloop

printloop:
	dec	ecx
	mov	eax, esp
	call	print
	pop	eax
	cmp	ecx, 0
	jnz	printloop
	
	; Restore registers that were pushed onto the stack
	pop	esi
	pop	edx
	pop	ecx
	pop	eax
	ret
;	mov 	edx, ecx 	; message length
;
;	mov	ecx, esp
;	sub	ecx, edx	; message pointer
;
;	mov	ebx, stdout
;	mov 	eax, sys_write
;	int	80h
;
;	pop	esi
;	pop	edx
;	pop	ecx
;	pop	ebx
;	pop	eax
;	ret

;------------------------------------------
; void iprintln(int num)
; Print an integer to stdout with new line
iprintln:
	call 	iprint
	push	eax
	mov	eax, 10
	push 	eax
	mov	eax, esp
	call	print
	pop	eax
	pop	eax
	ret
;-------------------------------------
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
	ret
