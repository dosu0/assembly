;----------------------------------------------------------
; lib/lib.inc
; Includes and defines all functions and constants in this 
; c-like standard library for assembly.

%ifndef LIB_INC_
%define LIB_INC_

;------------------------------------------------
; Global Includes
%include "syscalls.inc"

;------------------------------------------------
; Constants
exit_success	equ 0
exit_error		equ 1
exit_terminated	equ 130


;------------------------------------------------
; Functions/Methods
; void exec()           Execute an external program via 
;                       sys_execve
; void exit(i8 code)    Exit the program via sys_exit

;--------------------------------------
; void exec(char* program_name, 
;   char* args, char* env_vars)
; Execute an external program via sys_execve
exec:
	push 	rcx
	mov 	eax, sys_execve
	syscall
	pop		rcx
    ret

;------------------------------
; void exit(i8 code)
; Exit the program 
exit:
	mov		eax, sys_exit
	syscall
    ret     ; should not be needed but idk...

%endif