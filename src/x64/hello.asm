%include 'io.asm'
default rel

section .text

global _start

_start:
    lea     rdi, [string]
    call    println

    xor     rdi, rdi
    call    exit

section .data
string:
    db 'Hello, World!'
    db 0