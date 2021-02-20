; ------------------------------------------
; lib/syscalls.inc
; Defines syscall opcodes

%ifndef SYSCALLS_INC_
%define SYSCALLS_INC_

; -----------------------------------------
; 32bit Linux System calls
; sys_exit	 equ 1
; sys_read	 equ 3
; sys_write	 equ 4

; -----------------------------------------
; macOS system calls
; 32bit Linux + 0x20000000

sys_exit    equ 0x2000001
sys_fork    equ 0x2000002
sys_read    equ 0x2000003
sys_write   equ 0x2000004
sys_open    equ 0x2000005
sys_close   equ 0x2000006
sys_waitpid equ 0x2000007
sys_creat   equ 0x2000008

;---------------------------------------------
; exec naming convention
; E - An array of pointers to environment
;     variables is explicitly passed
; L - Command-line arguments are passed
;     individually to the function.
; P - Uses the PATH environment variable to
;     find the file named in the path argument 
;     to be executed.
; V - Command-line arguments are passed to the 
;     function as an array of pointers.

sys_execve  equ 0x200000b

%endif