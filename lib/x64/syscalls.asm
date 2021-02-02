;------------------------------------------
; Unix System Calls
; 
; write(int fd, string str, int len)
; 
;-----------------------------------------
; 32bit Linux System calls
; %define sys_exit	 1
; %define sys_read	 3
; %define sys_write	 4

;------------------------------------------
; macOS system calls
; 32bit Linux + 0x20000000

;-----------------------------------------
; exit(int code: rdi)
%define sys_exit	 0x2000001
%define sys_read	 0x2000003
%define	sys_write	 0x2000004