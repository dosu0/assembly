# x64

## (Linux) Calling Convention

### Integers & Pointers
rdi, rsi, rdx, rcx, r8, r9

### Floats
xmm0, xmm1, xmm2, xmm3 xmm4, xmm5, xmm6, xmm7

### Return Value
rax (ints & ptrs) or 
## 'Scratch' Registers
These registers can be overwritten in functions as long as they aren't a parameter
rax, rcx, rdx, rsi, rdi, r8, r9, r10, r11

source: 

## Memory access

| C datatype | Bits | Bytes | Access      | Allocate |
| ---------- | ---- | ----- | ----------- | -------- |
| char       | 8    | 1     | byte [ptr]  | db       |
| short      | 16   | 2     | word [ptr]  | dw       |
| int        | 32   | 4     | dword [ptr] | dd       |
| long       | 64   | 8     | qword [ptr] | dq       |