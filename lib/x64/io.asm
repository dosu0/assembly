;----------------------------------------------------------------
; Utility functions
; - iprint:	Print an interger to stdout
; - iprintln:	Print an integer to stdout with a new line
; - print: 	Print a string to stdout
; - println: 	Print a string to stdout with a new line

%include 'syscalls.asm'
%include 'string.asm'
%include 'misc.asm'

; Constants
%define stdout 1

;--------------------------------------------------------
; void iprint(i64 num)
; Print an integer to stdout
iprint:	
	mov		rcx, 0 		; Counter of how many bytes are going to be printed
	mov		rax, rdi


.divideloop:
	inc		rcx

	mov		rdx, 0		; rdx has to be empty becasue rdx and rax are viewed as 
						; joined (for idiv)
	mov		rsi, 10
	idiv	rsi			; rax / 10
	add		rdx, 48 	; Convert the remainder to an ascii character
	
	push	rdx			; push the new char onto the stack
	cmp		rax, 0		; Have we finished converting?
	jnz		.divideloop	; loop if not zero (nz)

.printloop:
	dec		rcx

	mov		rdi, rsp
	call	print

	pop		rdi
	cmp		rcx, 0
	jnz		.printloop
	ret

;------------------------------------------
; void iprintln(i64 num)
; Print a (64bit) integer to stdout with new line
iprintln:
	call 	iprint

	; print(&'\n')
	mov		rdi, 10 	; new line char
	push	rdi
	mov		rdi, rsp	; rax now points to the new line char
	call	print		; print new line char

	pop		rdi
	ret

;----------------------------
; void print(char* str)
; Write a message to stdout
print:
	call	strlen

	; write(stdout, str, strlen(str))
	mov		rdx, rax 	; message length arg	
	mov 	rsi, rdi	; message pointer arg
	mov		rdi, stdout ; file pointer arg
	mov		rax, sys_write
	syscall
	ret

;-----------------------------------------
; void println(char* str)
; Write a message to stdout with a new line
println:
	call	print

	; print(&'\n')
	mov		rdi, 10 	; new line char
	push	rdi
	mov		rdi, rsp	; rax now points to the new line char
	call	print		; print new line char

	pop		rdi			; remove new line char
.restore:
	ret