;--------------------------------------------------
; src/args.asm
; Prints each command line argument on a new line

%include "lib.inc"
%include "io.inc"

global _start

section .text

_start:
    ; The first value on the stack is the amount of arguments
    ; passed in to the executable
    pop rcx

.nextarg:
    cmp     rcx, 0      ; If there are no arguments remaining exit
    jz      .finish

    pop     rdi         ; Get the next argument
    call    println     ; and print it
    
    dec     rcx         ; one less arg
    jmp     .nextarg    ; repeat

.finish:
    xor     rdi, rdi
    call    exit
