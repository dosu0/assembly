;-----------------------------------------------------------
; src/prime.asm
; Usage: prime <n>
; Generates the <n>th prime number and all previous
; prime numbers
; TODO: Create an output buffer

%include "lib.inc"
%include "io.inc"

global 	_start

default rel

section .data
	begin_text: db "Generating ", 0
	end_text: 	db " prime(s)", 0
	usage_text: db "Usage: prime <n>", 0

section .text

;----------------------
; bool is_prime(i64 num)
; using 6k+/-1 method
is_prime:
	push 	r8
	push 	r9
	; if (num <= 3 && num != 1) return true;
	cmp 	rdi, 3 		; all numbers less than 3 (except one) are prime
	jg 		.gt3

	cmp 	rdi, 1 		; one is not a prime number

	je 		.not_prime
	jmp 	.is_a_prime

	.gt3:


		; num/2
		xor 	rdx, rdx
		mov 	rax, rdi
		mov 	rsi, 2
		div 	rsi
		cmp 	rdx, 0 		; rdx contains the remainder
		jz 		.not_prime

		; num/3
		xor 	rdx, rdx
		mov 	rax, rdi
		mov 	rsi, 3
		div 	rsi
		cmp 	rdx, 0 		; rdx contains the remainder
		jz 		.not_prime

		mov 	r8, 5
		.loop:
			; r8 * r8
			mov 	rax, r8
			mul		r8
			cmp 	rax, rdi
			jge		.is_a_prime

			xor 	rdx, rdx
			mov 	rax, rdi
			div 	r8
			cmp 	rdx, 0
			jz 		.not_prime
			
			xor 	rdx, rdx
			mov 	r9, r8
			add		r9, 2
			mov 	rax, rdi
			div 	r9
			cmp 	rdx, 0
			jz 		.not_prime

			add 	r8, 6

			jmp 	.loop

	.is_a_prime:
		xor 	eax, eax
		pop		r9
		pop		r8
		ret
	.not_prime: 
		mov 	rax, 1
		pop 	r9
		pop 	r8
		ret

_start:
	; if (rcx != 2) usage();
	pop		rcx
	cmp		rcx, 2
	jne		.usage
	
	pop 	rdx 	; discard program name

	; max_primes (r8) = argv[1]
	pop 	rdi
	call 	atoi
	cmp 	rax, 0 	; don't generate 0 primes
	jz		.usage
	mov		r8, rax

	; printf("Generating %d primes", atoi(argv[1]))
	lea 	rdi, [begin_text]
	call 	print
	mov 	rdi, r8 		; primes to generate
	call 	iprint
	lea 	rdi, [end_text]
	call 	println

	xor 	r9, r9			; candidate
	xor 	r10, r10		; primes_found

	.loop:
		inc 	r9			; next prime candidate

		; if(is_prime(candidate)) ...
		mov 	rdi, r9
		call 	is_prime
		cmp 	rax, 0
		jnz 	.loop

		inc 	r10 	; primes_found += 1
		; if(primes_found > max_primes)
		cmp 	r10, r8
		jg 		.exit
		mov 	rdi, r9
		call 	iprintln

		jmp 	.loop

	.usage:
		lea 	rdi, [usage_text]
		call 	println
		mov		edi, 1 ; unsuccessful
		call	exit

	.exit:
		xor 	edi, edi
		call	exit