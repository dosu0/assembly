;-----------------------------------------
; src/x64/rgs.asm
; Prints each command line argument on
; a new line

%include 'io.asm'

section .text
global _start

_start:
    mov     rdi, 1
    call    iprintln


.finish:
    xor     rdi, rdi
	call 	exit
