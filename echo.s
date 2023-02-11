.intel_syntax noprefix
.globl _start

# A table of Linux syscalls can be found here: https://x64.syscall.sh/

.section .text

_start:
	sub rsp, 1024 # reserve stack space for buffer
echo_loop:
	mov rdi, 0    # stdin
	mov rsi, rsp  # pointer to buffer
	mov rdx, 1024 # max len to read (buffer space)
	mov rax, 0    # read syscall
	syscall

	mov rdi, 1   # stdout
	mov rsi, rsp # pointer to read-in text
	mov rdx, rax # len of read-in text
	mov rax, 1   # write syscall
	syscall

	jmp echo_loop

	# unreachable
	mov rdi, 0  # success status code
	mov rax, 60 # exit syscall
	syscall
