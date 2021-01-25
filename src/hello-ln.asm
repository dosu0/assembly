;------------------------------------------
; src/hello-inc.asm
; This program prints messages to stdout
; via external subroutines

%include 'io.asm'

;-------------------------------------------------
; Variables
; Note:
; - 0 is the null byte (end of string delimiter)
section .data
msg1	db	'Hello, World!', 0 
msg2	db	'This is how we use functions in assembly', 0

section .text
global _start

_start:
	mov		eax, msg1
	call	println
	
	mov 	eax, msg2
	call	println
	
	mov		eax, exit_success 
	call 	exit
