;------------------------------------------
; Miscallaneous subroutines
; exit : Exit the program with sys_exit

%include 'syscalls.asm'

%define exit_success	0
%define exit_error	1
%define	exit_terminated	130

;------------------------------
; void exit(int code)
; Exit the program
exit:
	mov	ebx, eax 	; exit code
	mov	eax, sys_exit
	int	80h
	ret
	
