;-----------------------------------------
; src/x64/rgs.asm
; Prints each command line argument on
; a new line

%include 'io.asm'

section .data
msg     db      "Hello, world!."
section .text
global _start

_start:
    mov     rdi, 100
    call    iprintln 

.finish:
    xor     rdi, rdi
	call 	exit
