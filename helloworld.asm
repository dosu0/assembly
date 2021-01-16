; Hello World program

; Linux System Calls
%define sys_write 4
%define sys_exit 1

; Constants
%define exit_sucess 0
%define stdout 1

section .data
msg	db	'Hello World!', 10 ; '10' is the new line character

section .text
global _start

_start:
	
	mov	edx, 13
	mov 	ecx, msg
	mov	ebx, stdout 
	mov	eax, sys_write 
	int	80h
	
	mov	ebx, exit_sucess
	mov	eax, sys_exit
	int	80h
