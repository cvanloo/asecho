.intel_syntax noprefix
.globl _start

# A table of Linux syscalls can be found here: https://x64.syscall.sh/
# Instruction reference: https://www.felixcloutier.com/x86/

.section .text

_start:
	sub rsp, 1024 # reserve stack space for buffer
echo_loop:
	xor rdi, rdi  # stdin
	mov rsi, rsp  # pointer to buffer
	mov rdx, 1024 # max len to read (buffer space)
	xor rax, rax    # read syscall
	syscall

				 # rsi still set to buffer
	mov rdi, 1   # stdout
	mov rdx, rax # len of read-in text
	mov rax, 1   # write syscall
	syscall

	jmp echo_loop

	# unreachable
	xor rdi, rdi  # success status code
	mov rax, 60 # exit syscall
	syscall
