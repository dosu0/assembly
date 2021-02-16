;---------------------------------------------------
; lib/x64/misc.asm
; Miscallaneous subroutines
; exit(i64 code)	Exit the program with sys_exit

%include 'syscalls.asm'

exit_success	equ 0
exit_error		equ 1
exit_terminated	equ 130

;------------------------------
; void exit(i32 code)
; Exit the program
exit:
	mov		rax, sys_exit
	syscall