	.file	"fibonacci.c"
	.text
	.globl	fib_iter
	.type	fib_iter, @function
fib_iter:
.LFB22:
	.cfi_startproc
	cmpl	$1, %edi
	jle	.L6
	addl	$1, %edi
	movl	$2, %edx
	movl	$1, %eax
	movl	$0, %ecx
	.p2align 4
.L4:
	movq	%rax, %rsi
	addq	%rcx, %rax
	addl	$1, %edx
	movq	%rsi, %rcx
	cmpl	%edi, %edx
	jne	.L4
	ret
.L6:
	movslq	%edi, %rax
	ret
	.cfi_endproc
.LFE22:
	.size	fib_iter, .-fib_iter
	.globl	fib_rec
	.type	fib_rec, @function
fib_rec:
.LFB23:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	%edi, %ebx
	movslq	%edi, %rax
	cmpl	$1, %edi
	jle	.L7
	leal	-1(%rdi), %edi
	call	fib_rec
	movq	%rax, %r14
	leal	-2(%rbx), %edi
	call	fib_rec
	addq	%rax, %r14
	movq	%r14, %rax
.L7:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	fib_rec, .-fib_rec
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Usage: %s <n> <method>\n"
.LC1:
	.string	"Fibonacci(%d) = %llu\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %rbx
	cmpl	$3, %edi
	je	.L12
	movq	(%rsi), %rdx
	leaq	.LC0(%rip), %rsi
	movq	stderr(%rip), %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
.L11:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L12:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	__isoc23_strtol@PLT
	movl	%eax, %edi
	movl	%eax, %r14d
	movq	16(%rbx), %rax
	cmpb	$105, (%rax)
	jne	.L14
	call	fib_iter
	movq	%rax, %rdx
.L15:
	movl	%r14d, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	jmp	.L11
.L14:
	call	fib_rec
	movq	%rax, %rdx
	jmp	.L15
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-17) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
