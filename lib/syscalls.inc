; ------------------------------------------
; lib/syscalls.inc
; Defines syscall opcodes

%ifndef SYSCALLS_INC_
%define SYSCALLS_INC_

;-------------------------------------------
; Linux x64 syscalls
; scraped from here:
; https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl
; some syscalls may be missing :|
%ifidn __?OUTPUT_FORMAT?__, elf64
%assign sys_read 0
%assign sys_write 1
%assign sys_open 2
%assign sys_close 3
%assign sys_newstat 4
%assign sys_newfstat 5
%assign sys_newlstat 6
%assign sys_poll 7
%assign sys_lseek 8
%assign sys_mmap 9
%assign sys_mprotect 10
%assign sys_munmap 11
%assign sys_brk 12
%assign sys_rt_sigaction 13
%assign sys_rt_sigprocmask 14
%assign sys_rt_sigreturn 15	
%assign sys_ioctl 16        
%assign sys_pread64 17			
%assign sys_pwrite64 18		
%assign sys_readv 19	
%assign sys_writev 20		
%assign sys_access 21			
%assign sys_pipe 22			
%assign sys_select 23			
%assign sys_sched_yield 24		
%assign sys_mremap 25			
%assign sys_msync 26			
%assign sys_mincore 27			
%assign sys_madvise 28			
%assign sys_shmget 29			
%assign sys_shmat 30			
%assign sys_shmctl 31			
%assign sys_dup 32			
%assign sys_dup2 33			
%assign sys_pause 34			
%assign sys_nanosleep 35		
%assign sys_getitimer 36		
%assign sys_alarm 37			
%assign sys_setitimer 38		
%assign sys_getpid 39			
%assign sys_sendfile64 40		
%assign sys_socket 41			
%assign sys_connect 42			
%assign sys_accept 43			
%assign sys_sendto 44				
%assign sys_shutdown 48		
%assign sys_bind 49			
%assign sys_listen 50			
%assign sys_getsockname 51		
%assign sys_getpeername 52		
%assign sys_socketpair 53		
%assign sys_clone 56			
%assign sys_fork 57			
%assign sys_vfork 58				
%assign sys_exit 60			
%assign sys_wait4 61			
%assign sys_kill 62			
%assign sys_newuname 63			
%assign sys_semget 64			
%assign sys_semop 65			
%assign sys_semctl 66			
%assign sys_shmdt 67			
%assign sys_msgget 68			
%assign sys_msgsnd 69			
%assign sys_msgrcv 70			
%assign sys_msgctl 71			
%assign sys_fcntl 72			
%assign sys_flock 73			
%assign sys_fsync 74			
%assign sys_fdatasync 75		
%assign sys_truncate 76		
%assign sys_ftruncate 77		
%assign sys_getdents 78		
%assign sys_getcwd 79			
%assign sys_chdir 80			
%assign sys_fchdir 81			
%assign sys_rename 82			
%assign sys_mkdir 83			
%assign sys_rmdir 84			
%assign sys_creat 85			
%assign sys_link 86			
%assign sys_unlink 87			
%assign sys_symlink 88			
%assign sys_readlink 89		
%assign sys_chmod 90			
%assign sys_fchmod 91			
%assign sys_chown 92			
%assign sys_fchown 93			
%assign sys_lchown 94			
%assign sys_umask 95			
%assign sys_gettimeofday 96		
%assign sys_getrlimit 97		
%assign sys_getrusage 98		
%assign sys_sysinfo 99			
%assign sys_times 100			
%assign sys_getuid 102			
%assign sys_syslog 103			
%assign sys_getgid 104			
%assign sys_setuid 105			
%assign sys_setgid 106			
%assign sys_geteuid 107			
%assign sys_getegid 108			
%assign sys_setpgid 109			
%assign sys_getppid 110			
%assign sys_getpgrp 111			
%assign sys_setsid 112			
%assign sys_setreuid 113		
%assign sys_setregid 114		
%assign sys_getgroups 115		
%assign sys_setgroups 116		
%assign sys_setresuid 117		
%assign sys_getresuid 118		
%assign sys_setresgid 119		
%assign sys_getresgid 120		
%assign sys_getpgid 121			
%assign sys_setfsuid 122		
%assign sys_setfsgid 123		
%assign sys_getsid 124			
%assign sys_capget 125			
%assign sys_capset 126			
%assign sys_rt_sigsuspend 130		
%assign sys_utime 132			
%assign sys_mknod 133			
%assign sys_personality 135		
%assign sys_ustat 136			
%assign sys_statfs 137			
%assign sys_fstatfs 138			
%assign sys_sysfs 139			
%assign sys_getpriority 140		
%assign sys_setpriority 141		
%assign sys_sched_setparam 142		
%assign sys_sched_getparam 143		
%assign sys_sched_setscheduler 144	
%assign sys_sched_getscheduler 145	
%assign sys_sched_get_priority_max 146	
%assign sys_sched_get_priority_min 147	
%assign sys_sched_rr_get_interval 148	
%assign sys_mlock 149			
%assign sys_munlock 150			
%assign sys_mlockall 151		
%assign sys_munlockall 152		
%assign sys_vhangup 153			
%assign sys_modify_ldt 154		
%assign sys_pivot_root 155			
%assign sys_prctl 157			
%assign sys_arch_prctl 158		
%assign sys_adjtimex 159		
%assign sys_setrlimit 160		
%assign sys_chroot 161			
%assign sys_sync 162			
%assign sys_acct 163			
%assign sys_settimeofday 164		
%assign sys_mount 165			
%assign sys_umount 166			
%assign sys_swapon 167			
%assign sys_swapoff 168			
%assign sys_reboot 169			
%assign sys_sethostname 170		
%assign sys_setdomainname 171		
%assign sys_iopl 172			
%assign sys_ioperm 173			
%assign sys_init_module 175		
%assign sys_delete_module 176		
%endif

%ifidn __?OUTPUT_FORMAT?__, macho64
; -----------------------------------------
; macOS x64

; Generate the 'raw' syscall
%define S(n) ((2 << 24) | (~(0xff << 24) & (n)))

%assign	sys_exit            S(1)
%assign	sys_fork            S(2)
%assign	sys_read            S(3)
%assign	sys_write           S(4)
%assign	sys_open            S(5)
%assign	sys_close           S(6)
%assign	sys_wait4           S(7)
%assign	sys_link            S(9)
%assign	sys_unlink          S(10)
%assign	sys_chdir           S(12)
%assign	sys_fchdir          S(13)
%assign	sys_mknod           S(14)
%assign	sys_chmod           S(15)
%assign	sys_chown           S(16)
%assign	sys_break           S(17)
%assign	sys_getfsstat       S(18)
%assign	sys_lseek	        S(19)
%assign	sys_getpid	        S(20)
%assign	sys_mount	        S(21)
%assign	sys_unmount	        S(22)
%assign	sys_setuid	        S(23)
%assign	sys_getuid	        S(24)
%assign	sys_geteuid	        S(25)
%assign	sys_ptrace	        S(26)
%assign	sys_recvmsg	        S(27)
%assign	sys_sendmsg	        S(28)
%assign	sys_recvfrom	    S(29)
%assign	sys_accept	        S(30)
%assign	sys_getpeername	    S(31)
%assign	sys_getsockname	    S(32)
%assign	sys_access	        S(33)
%assign	sys_chflags	        S(34)
%assign	sys_fchflags  	    S(35)
%assign	sys_sync	        S(36)
%assign	sys_kill	        S(37)
%assign	sys_stat	        S(38)
%assign	sys_getppid	        S(39)
%assign	sys_lstat	        S(40)
%assign	sys_dup	            S(41)
%assign	sys_pipe	        S(42)
%assign	sys_getegid	        S(43)
%assign	sys_profil	        S(44)
%assign	sys_ktrace	        S(45)
%assign	sys_sigaction	    S(46)
%assign	sys_getgid	        S(47)
%assign	sys_sigprocmask	    S(48)
%assign	sys_getlogin	    S(49)
%assign	sys_setlogin	    S(50)
%assign	sys_acct	        S(51)
%assign	sys_sigpending      S(52)
%assign	sys_sigaltstack	    S(53)
%assign	sys_ioctl	        S(54)
%assign	sys_reboot	        S(55)
%assign	sys_revoke	        S(56)
%assign	sys_symlink	        S(57)
%assign	sys_readlink	    S(58)
%assign	sys_execve	        S(59)
%assign	sys_umask	        S(60)
%assign	sys_chroot	        S(61)
%assign	sys_fstat	        S(62)
%assign	sys_getkerninfo	    S(63)
%assign	sys_getpagesize	    S(64)
%assign	sys_msync	        S(65)
%assign	sys_vfork	        S(66)
%assign	sys_sbrk	        S(69)
%assign	sys_sstk	        S(70)
%assign	sys_mmap	        S(71)
%assign	sys_vadvise	        S(72)
%assign	sys_munmap	        S(73)
%assign	sys_mprotect	    S(74)
%assign	sys_madvise	        S(75)
%assign	sys_mincore	        S(78)
%assign	sys_getgroups	    S(79)
%assign	sys_setgroups	    S(80)
%assign	sys_getpgrp	        S(81)
%assign	sys_setpgid	        S(82)
%assign	sys_setitimer	    S(83)
%assign	sys_swapon	        S(85)
%assign	sys_getitimer	    S(86)
%assign	sys_gethostname	    S(87)
%assign	sys_sethostname	    S(88)
%assign	sys_getdtablesize	S(89)
%assign	sys_dup2	        S(90)
%assign	sys_fcntl	        S(92)
%assign	sys_select	        S(93)
%assign	sys_fsync	        S(95)
%assign	sys_setpriority	    S(96)
%assign	sys_socket	        S(97)
%assign	sys_connect	        S(98)
%assign	sys_getpriority	    S(100)
%assign	sys_sigreturn	    S(103)
%assign	sys_bind	        S(104)
%assign	sys_setsockopt	    S(105)
%assign	sys_listen	        S(106)
%assign	sys_sigsuspend	    S(111)
%assign	sys_sigstack	    S(112)
%assign	sys_vtrace	        S(115)
%assign	sys_gettimeofday    S(116)
%assign	sys_getrusage	    S(117)
%assign	sys_getsockopt	    S(118)
%assign	sys_resuba	        S(119)
%assign	sys_readv	        S(120)
%assign	sys_writev	        S(121)
%assign	sys_settimeofday    S(122)
%assign	sys_fchown	        S(123)
%assign	sys_fchmod	        S(124)
%assign	sys_setreuid	    S(126)
%assign	sys_setregid	    S(127)
%assign	sys_rename	        S(128)
%assign	sys_truncate	    S(129)
%assign	sys_ftruncate	    S(130)
%assign	sys_flock	        S(131)
%assign	sys_mkfifo	        S(132)
%assign	sys_sendto	        S(133)
%assign	sys_shutdown	    S(134)
%assign	sys_socketpair	    S(135)
%assign	sys_mkdir	        S(136)
%assign	sys_rmdir	        S(137)
%assign	sys_utimes	        S(138)
%assign	sys_adjtime	        S(140)
%assign	sys_gethostid	    S(142)
%assign	sys_sethostid	    S(143)
%assign	sys_getrlimit	    S(144)
%assign	sys_setrlimit	    S(145)
%assign	sys_setsid	        S(147)
%assign	sys_quotactl	    S(148)
%assign	sys_nfssvc	        S(155)
%assign	sys_getdirentries	S(156)
%assign	sys_statfs	        S(157)
%assign	sys_fstatfs	        S(158)
%assign	sys_async_daemon	S(160)
%assign	sys_getfh	        S(161)
%assign	sys_shmsys	        S(171)
%assign	sys_setgid	        S(181)
%assign	sys_setegid	        S(182)
%assign	sys_seteuid	        S(183)

%endif

%endif