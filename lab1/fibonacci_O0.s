	.file	"fibonacci.c"
	.text
	.globl	fib_iter
	.type	fib_iter, @function
fib_iter:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)
	cmpl	$1, -36(%rbp)
	jg	.L2
	movl	-36(%rbp), %eax
	cltq
	jmp	.L3
.L2:
	movq	$0, -8(%rbp)
	movq	$1, -16(%rbp)
	movl	$2, -20(%rbp)
	jmp	.L4
.L5:
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
	addl	$1, -20(%rbp)
.L4:
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jle	.L5
	movq	-16(%rbp), %rax
.L3:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	fib_iter, .-fib_iter
	.globl	fib_rec
	.type	fib_rec, @function
fib_rec:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movl	%edi, -20(%rbp)
	cmpl	$1, -20(%rbp)
	jg	.L7
	movl	-20(%rbp), %eax
	cltq
	jmp	.L8
.L7:
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	fib_rec
	movq	%rax, %rbx
	movl	-20(%rbp), %eax
	subl	$2, %eax
	movl	%eax, %edi
	call	fib_rec
	addq	%rbx, %rax
.L8:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	fib_rec, .-fib_rec
	.section	.rodata
.LC0:
	.string	"Usage: %s <n> <method>\n"
.LC1:
	.string	"Fibonacci(%d) = %llu\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	cmpl	$3, -20(%rbp)
	je	.L10
	movq	-32(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	leaq	.LC0(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	jmp	.L11
.L10:
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -12(%rbp)
	movq	-32(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$105, %al
	jne	.L12
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	fib_iter
	movq	%rax, -8(%rbp)
	jmp	.L13
.L12:
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	fib_rec
	movq	%rax, -8(%rbp)
.L13:
	movq	-8(%rbp), %rdx
	movl	-12(%rbp), %eax
	leaq	.LC1(%rip), %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-17) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
