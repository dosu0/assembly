;----------------------------------------
; bool check_prime(int num);
; Check if a given number is prime or not
check_prime:
	push		rcx
	cvtsi2sd	xmm0, rdi 	; rdi: i64 -> xmm0: f64
	sqrtsd 		xmm0, xmm0 	; xmm0 = sqrt(xmm0)
	cvtsd2si 	rcx, xmm0 	; xmm0: f64 -> rcx: i64
	

