# x64

## (Linux) Calling Convention


## Parameters
> **rdi**, **rsi**, **rdx**, **rcx**, **r8**, and **r9** are used (in order) to pass 
> the first six integer or pointer parameters to called functions.
> Additional parameters (or large parameters such as structs passed by value)
> are passed on the stack.

Floats are passed from registers **xmm0-xmm7**

### Caller-save registers
> **rax**, **rcx**, **rdx**, **rdi**, **rsi**, **rsp**, and **r8-r11** are considered
> caller-save registers, meaning that they are not necessarily saved across function calls.

### Return Value
> By convention, **rax** is used to store a function’s return value, if it exists and is no more
> than 64 bits long. (Larger return types like structs are returned using the 
> stack.)

### Callee-save registers
> **rbx**, **rbp**, and **r12-r15** are callee-save registers, meaning that
> they are saved across function calls. 
> **rsp** is used as the stack pointer, a pointer to the topmost element in the stack.


In 32-bit x86, the base pointer (formerly %ebp, now %rbp) was used to keep track of the base of
the current stack frame, and a called function would save the base pointer of its caller prior to
updating the base pointer to its own stack frame. With the advent of the 64-bit architecture, this
has been mostly eliminated, save for a few special cases when the compiler cannot determine
ahead of time how much stack space needs to be allocated for a particular function (see
Dynamic stack allocation).
## Memory access

| C datatype | Bits | Bytes | Access      | Allocate |
| ---------- | ---- | ----- | ----------- | -------- |
| char       | 8    | 1     | byte [ptr]  | db       |
| short      | 16   | 2     | word [ptr]  | dw       |
| int        | 32   | 4     | dword [ptr] | dd       |
| long       | 64   | 8     | qword [ptr] | dq       |