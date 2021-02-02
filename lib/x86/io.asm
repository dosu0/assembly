;----------------------------------------------------------------
; Utility functions
; - iprint:	Print an interger to stdout
; - iprintln:	Print an integer to stdout with a new line
; - print: 	Print a string to stdout
; - println: 	Print a string to stdout with a new line

%include 'syscalls.asm'
%include 'string.asm'
%include 'misc.asm' 		; for convenience

; Constants
%define stdout 1

;--------------------------------------------------------
; void iprint(int num)
; Print an integer to stdout
iprint:
	; Preserve registers
	push	eax
	push	ecx
	push	edx
	push 	esi
	
	mov		ecx, 0 		; Counter of how many bytes are going to be printed

.divideloop:
	inc		ecx

	mov		edx, 0		; empty edx
	mov		esi, 10
	idiv	esi			; eax / esi
	add		edx, 48 	; Convert the remainder to an ascii character
	push	edx
	cmp		eax, 0		; Have we finished converting?
	jnz		.divideloop	; loop if not zero (nz)

.printloop:
	dec		ecx
	mov		eax, esp
	call	print
	pop		eax
	cmp		ecx, 0
	jnz		.printloop

.restore:
	pop		esi
	pop		edx
	pop		ecx
	pop		eax
	ret

;------------------------------------------
; void iprintln(int num)
; Print an integer to stdout with new line
iprintln:
	call 	iprint
	push	eax
	mov		eax, 10
	push 	eax
	mov		eax, esp
	call	print

.restore:
	pop		eax
	pop		eax
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

	mov		edx, eax 	; message length arg
	pop		eax			; restore eax ( the msg pointer arg )	

	mov 	ecx, eax	; message pointer arg
	mov		ebx, stdout ; file pointer arg

	mov		eax, sys_write
	int		80h

.restore:
	pop		ebx
	pop		ecx
	pop		edx
	ret

;-----------------------------------------
; void println(string str)
; Write a message to stdout with a new line
println:
	call	print
	
	push	eax
	mov		eax, 10 	; new line char
	push	eax
	mov		eax, esp	; eax now points to the new line char
	call	print		; print new line char

	pop		eax			; remove new line char

.restore:
	pop		eax			; restore eax
	ret
