;-----------------------------------
; include/x64/math.asm
; Math functions & constants

isqrt:

.loop:
    mov     rax, rdi
    mov     rcx, 100
    idiv    rcx         ; rax / rcx