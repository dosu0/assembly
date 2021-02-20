;--------------------------------------------
; src/hello.asm
; Prints "Hello, World!" to stdout

%include "lib.inc"
%include "io.inc"

global _start

default rel

section .data
    string: db "Hello, World!", 0

section .text

_start:
    ; lea     rdi, [string]
    ; call    println

    xor     ecx, ecx
    xor     edx, edx

    mov     edi, 10
    call    iprintln

    xor     rdi, rdi
    call    exit