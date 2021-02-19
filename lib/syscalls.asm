; ------------------------------------------
; lib/x64/syscalls.asm

; -----------------------------------------
; 32bit Linux System calls
; sys_exit	 equ 1
; sys_read	 equ 3
; sys_write	 equ 4

; -----------------------------------------
; macOS system calls
; 32bit Linux + 0x20000000

sys_exit equ 0x2000001
sys_read equ 0x2000003
sys_write equ 0x2000004