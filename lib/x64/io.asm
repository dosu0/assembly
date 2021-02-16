;----------------------------------------------------------------
; Utility functions
; lib/x64/io.asm
; iprint(i64 num)	Print an interger to stdout
; iprintln(i64 num)	Print an integer to stdout with a new line
; print(char ptr) 	Print a string to stdout
; println(char ptr) Print a string to stdout with a new line

%include 'syscalls.asm'
%include 'string.asm'
%include 'misc.asm'

; Constants
stdout equ 1

;--------------------------------------------------------
; void iprint(i64 num)
; Print an integer to stdout
iprint:
	push 	rcx
	xor		rcx, rcx		; Counter of how many bytes are going to be printed
	mov		rax, rdi

.divideloop:
	inc		rcx

	xor		rdx, rdx	; rdx has to be empty becasue rdx and rax are viewed as 
						; joined (for idiv)
	mov		rsi, 10
	idiv	rsi			; rax / 10
	add		rdx, 48 	; Convert the remainder to an ascii character
	
	push	rdx			; push the new char onto the stack
	cmp		rax, 0		; Have we finished converting?
	jnz		.divideloop	; loop if not zero (nz)

.printloop:
	dec		rcx

	; print(&num)
	mov		rdi, rsp
	push	rcx			; rcx gets overriden for some reason..
	call	print
	pop 	rcx
	pop		rdi

	cmp		rcx, 0
	jnz		.printloop
.restore:
	pop		rcx
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
	push 	rdx
	push 	rsi
	push 	rdi
	call	strlen

	; write(stdout, str, strlen(str))
	mov		edx, eax 	; message length arg	
	mov 	rsi, rdi	; message pointer arg
	mov		edi, stdout ; file pointer arg
	mov		rax, sys_write
	syscall

	pop 	rdx
	pop 	rsi
	pop 	rdi
	ret

;-----------------------------------------
; void println(char* str)
; Write a message to stdout with a new line
println:
	push 	rdi
	call	print

	; print(&'\n')
	mov		edi, 10 	; new line char
	push	rdi
	mov		rdi, rsp	; rax now points to the new line char
	call	print		; print new line char

	pop		rdi			; remove new line char
.restore:
	pop 	rdi
	ret