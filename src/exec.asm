;--------------------------------------------------
; src/exec.asm
; Executes the `echo' shell script

%include "lib.inc"

default rel

global _start

section .data
    cmd:  db "/bin/echo", 0
    arg1: db "Hello, World!", 0
    args: dq cmd, arg1, 0
    env:  dd 0

section .text

_start:
    ; exec(cmd, args, env)
    lea 	rdi, [cmd]
    lea   rsi, [args]
    lea   rdx, [env]
    call  exec

.finish:
    xor 	rdi, rdi
    call  exit
