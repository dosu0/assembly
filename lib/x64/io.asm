;----------------------------------------------------------------
; Utility functions
; - iprint:	Print an interger to stdout
; - iprintln:	Print an integer to stdout with a new line
; - print: 	Print a string to stdout
; - println: 	Print a string to stdout with a new line

; %include 'syscalls.asm'
; %include 'string.asm'
; %include 'misc.asm'

; Constants
; %define stdout 1

;--------------------------------------------------------
; void iprint(i64 num)
; Print an integer to stdout
iprint:
	; Preserve registers
	push	rcx			; doesn't have to be preserved but idk
	push	rdx
	push 	rsi
	
	mov		rcx, 0 		; Counter of how many bytes are going to be printed
	mov		rax, rdi
.divideloop:
	inc		rcx

	mov		rdx, 0		; empty edx
	mov		rsi, 10
	idiv	rsi			; rax / rsi
	add		rdx, 48 	; Convert the remainder to an ascii character
	push	rdx			; push the new char onto the stack
	cmp		rax, 0		; Have we finished converting?
	jnz		.divideloop	; loop if not zero (nz)

.printloop:
	dec		rcx
	mov		rax, rsp
	call	print
	pop		rax
	cmp		rcx, 0
	jnz		.printloop

.restore:
	pop		rsi
	pop		rdx
	pop		rcx
	pop		rax
	ret

;------------------------------------------
; void iprintln(i64 num)
; Print a (64bit) integer to stdout with new line
iprintln:
	call 	iprint
	push	rax
	mov		rax, 10
	push 	rax
	mov		rax, rsp
	call	print

.restore:
	pop		rax
	pop		rax
	ret

;----------------------------
; void print(string str)
; Write a message to stdout
print:
	; Preserve the registers used
	push	edx
	push	rcx
	push	ebx
	push	eax

	call	strlen

	mov		edx, eax 	; message length arg
	pop		eax			; restore eax ( the msg pointer arg )	

	mov 	rcx, eax	; message pointer arg
	mov		ebx, stdout ; file pointer arg

	mov		eax, sys_write
	int		80h

.restore:
	pop		ebx
	pop		rcx
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
	mov		eax, rsp	; eax now points to the new line char
	call	print		; print new line char

	pop		eax			; remove new line char

.restore:
	pop		eax			; restore eax
	ret