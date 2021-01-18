;----------------------------------
; Hello World program

%include 'io.asm'

;-------------------------------------------------
; Variables
; Note:
; - 10 is the newline character
; - 0 is the null byte (end of string delimiter)
section .data
msg1	db	'Hello, World!', 10, 0 ; '10' is the new line character
msg2	db	'This is how we use functions in assembly', 10, 0

section .text
global _start

_start:
	mov	eax, msg1
	call	print
	
	mov 	eax, msg2
	call	print
	
	mov	eax, exit_success
	call 	exit
