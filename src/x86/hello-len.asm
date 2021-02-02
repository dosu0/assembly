;----------------------------------------------
; src/hello-len.asm
; This program prints a string of **any** size 
; to stdout

%include 'syscalls.asm'

; Constants
%define exit_sucess 0
%define stdout 1

section .data
msg		db	"Hello, World!", 10 ; '10' is the new line character

section .text
global _start

_start:
	mov		eax, msg
	call	strlen

	mov		edx, eax	; msg length arg
	mov 	ecx, msg	; msg pointer arg
	mov		ebx, stdout 	; file pointer arg

	mov		eax, sys_write	; system call
	int		80h
	
.exit:
	mov		ebx, exit_sucess
	mov		eax, sys_exit
	int		80h

;------------------------------------
; int strlen(string str)
; Calculates the length of a string
; returns the length in register eax
strlen:
	push	ebx				; preserve ebx
	mov		ebx, eax		; let eax & ebx point to the string
	
.nextchar:
	cmp 	byte [eax], 0 	; compare the byte pointed to by 'eax' against zero (end of string)
	jz		.finish			; exit this loop if was zero
	inc		eax				; increment the pointer
	jmp		.nextchar		; repeat

.finish:
	sub		eax, ebx		; subtract ending pointer from the starting pointer
							; eax now contains the length of the string
	pop		ebx				; restore ebx
	ret


