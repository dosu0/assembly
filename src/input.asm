;----------------------------------------------------------------------------
; src/input.asm
; Designed for 64bit macOS
; Prompts for your name and then prints "Hello, <your inputted name>"
;

%include "lib.inc"
%include "io.inc"

global    _start

default rel

section .data
    prompt:     db  "Please enter your name: ", 0
    response:   db  "Hello, ", 0

section .bss
    input:  resb 255

section .text

_start:
    ; print(&prompt)
    lea     rdi, [prompt]
    call    print

    ; read(stdin, &input, 255)
    mov     rax, sys_read
    mov     rdi, stdin
    lea     rsi, [input]
    mov     rdx, 255
    syscall
    
    ; print(&msg2)
    lea     rdi, [response]
    call    print
    
    ; print(&input)
    lea     rdi, [input]
    call    print

.exit:
    xor     rdi, rdi
    call    exit
