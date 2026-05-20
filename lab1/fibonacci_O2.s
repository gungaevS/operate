	.file	"fibonacci.c"
	.text
	.p2align 4
	.globl	fib_iter
	.type	fib_iter, @function
fib_iter:
.LFB22:
	.cfi_startproc
	cmpl	$1, %edi
	jle	.L7
	addl	$1, %edi
	movl	$2, %edx
	movl	$1, %eax
	xorl	%ecx, %ecx
	.p2align 4
	.p2align 4
	.p2align 3
.L4:
	movq	%rax, %rsi
	addl	$1, %edx
	addq	%rcx, %rax
	movq	%rsi, %rcx
	cmpl	%edi, %edx
	jne	.L4
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	movslq	%edi, %rax
	ret
	.cfi_endproc
.LFE22:
	.size	fib_iter, .-fib_iter
	.p2align 4
	.globl	fib_rec
	.type	fib_rec, @function
fib_rec:
.LFB23:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edi, %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movslq	%edi, %rbx
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	cmpl	$1, %edi
	jle	.L8
	leal	-1(%rdi), %eax
	movl	%edi, %r12d
	xorl	%ebx, %ebx
	andl	$-2, %eax
	subl	%eax, %r12d
	movl	%r12d, %ebp
.L12:
	cmpl	%r15d, %ebp
	je	.L51
	leal	-1(%r15), %edi
	leal	-1(%r15), %edx
	subl	$2, %r15d
	movl	%ebp, 64(%rsp)
	movl	%r15d, %eax
	xorl	%r12d, %r12d
	movq	%rbx, %rbp
	andl	$-2, %eax
	subl	%eax, %edi
	movl	%edi, 68(%rsp)
.L15:
	cmpl	%edx, 68(%rsp)
	je	.L52
	leal	-2(%rdx), %r14d
	leal	-1(%rdx), %eax
	movq	%r12, 32(%rsp)
	xorl	%r13d, %r13d
	movl	%r14d, %ecx
	movl	%eax, %esi
	andl	$-2, %ecx
	subl	%ecx, %esi
	movl	%esi, 72(%rsp)
.L18:
	cmpl	72(%rsp), %eax
	je	.L53
	leal	-1(%rax), %esi
	leal	-2(%rax), %ecx
	movq	%rbp, 40(%rsp)
	movl	%r15d, %r12d
	andl	$-2, %ecx
	movl	%esi, %edi
	movq	%r13, 48(%rsp)
	xorl	%r15d, %r15d
	subl	%ecx, %edi
	movl	%r14d, %ebx
	leal	-2(%rax), %ecx
	movl	%edi, 76(%rsp)
.L21:
	cmpl	76(%rsp), %esi
	je	.L54
	leal	-2(%rsi), %edi
	leal	-1(%rsi), %r13d
	xorl	%ebp, %ebp
	movq	%r15, 56(%rsp)
	leal	-1(%rsi), %r14d
	movl	%edi, %esi
	movl	%r12d, %edx
	movl	%ecx, %r11d
	andl	$-2, %esi
	movq	%rbp, %r12
	movl	%edi, %r10d
	subl	%esi, %r13d
	movl	%r13d, %r15d
.L24:
	cmpl	%r15d, %r14d
	je	.L55
	leal	-1(%r14), %eax
	subl	$2, %r14d
	xorl	%ebp, %ebp
	movl	%edx, %esi
	movl	%r14d, %edi
	movl	%eax, %ecx
	andl	$-2, %edi
	subl	%edi, %ecx
	movl	%ecx, 12(%rsp)
.L27:
	cmpl	12(%rsp), %eax
	je	.L56
	leal	-2(%rax), %edi
	leal	-3(%rax), %ecx
	movl	%esi, %r9d
	movl	%edi, %edx
	leal	-3(%rax), %r8d
	movl	%edi, 4(%rsp)
	andl	$-2, %edx
	subl	%edx, %ecx
	leal	-3(%rax), %edx
	subl	$5, %eax
	andl	$-2, %edx
	movl	%ecx, 24(%rsp)
	xorl	%ecx, %ecx
	subl	%edx, %eax
	movl	%eax, 8(%rsp)
.L31:
	cmpl	%r8d, 24(%rsp)
	je	.L57
	movq	%rcx, 16(%rsp)
	leal	1(%r8), %esi
	movl	%r8d, %edx
	movl	%ebx, %r13d
	movl	%r8d, 28(%rsp)
	xorl	%r8d, %r8d
.L34:
	movl	%edx, %ecx
	cmpl	$1, %edx
	je	.L58
	xorl	%ebx, %ebx
.L32:
	leal	-1(%rcx), %edi
	movl	%r10d, 108(%rsp)
	movl	%r11d, 104(%rsp)
	movl	%r9d, 100(%rsp)
	movl	%edx, 96(%rsp)
	movq	%r8, 88(%rsp)
	movl	%esi, 84(%rsp)
	movl	%ecx, 80(%rsp)
	call	fib_rec
	movl	80(%rsp), %ecx
	movl	84(%rsp), %esi
	addq	%rax, %rbx
	movq	88(%rsp), %r8
	movl	96(%rsp), %edx
	subl	$2, %ecx
	movl	100(%rsp), %r9d
	movl	104(%rsp), %r11d
	cmpl	$1, %ecx
	movl	108(%rsp), %r10d
	jg	.L32
	leal	-3(%rsi), %ecx
	subl	$2, %edx
	subl	$2, %esi
	andl	$-2, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	cltq
	addq	%r8, %rax
	leaq	(%rbx,%rax), %r8
	cmpl	$1, %esi
	jne	.L34
	movl	%r13d, %ebx
	movq	16(%rsp), %rcx
	movq	%r8, %r13
	movl	$1, %edx
	movl	28(%rsp), %r8d
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L56:
	movl	%esi, %edx
	addq	$1, %rbp
	xorl	%eax, %eax
.L26:
	addq	%rbp, %rax
	addq	%rax, %r12
	cmpl	$1, %r14d
	jne	.L24
	movq	56(%rsp), %r15
	movq	%r12, %rbp
	movl	%r11d, %ecx
	movl	%edx, %r12d
	movl	%r10d, %edi
	movl	$1, %r9d
.L23:
	addq	%rbp, %r9
	movl	%edi, %esi
	addq	%r9, %r15
	cmpl	$1, %edi
	jne	.L21
	movl	%ebx, %r14d
	movl	%ecx, %eax
	movq	%r15, %rbx
	movq	40(%rsp), %rbp
	movq	48(%rsp), %r13
	movl	%r12d, %r15d
	movl	$1, %ecx
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L57:
	movl	4(%rsp), %edi
	movl	%r9d, %esi
	addq	$1, %rcx
	xorl	%r13d, %r13d
.L29:
	addq	%rcx, %r13
	movl	%edi, %eax
	addq	%r13, %rbp
	cmpl	$1, %edi
	jne	.L27
	movl	%esi, %edx
	movl	$1, %eax
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L58:
	movl	%r13d, %ebx
	movq	16(%rsp), %rcx
	leaq	1(%r8), %r13
	xorl	%edx, %edx
	movl	28(%rsp), %r8d
.L33:
	addq	%r13, %rdx
	addq	%rdx, %rcx
	leal	-2(%r8), %edx
	cmpl	%edx, 8(%rsp)
	je	.L30
	movl	%edx, %r8d
	jmp	.L31
.L55:
	movq	%r12, %rbp
	movq	56(%rsp), %r15
	movl	%edx, %r12d
	movl	%r11d, %ecx
	movl	%r10d, %edi
	addq	$1, %rbp
	xorl	%r9d, %r9d
	jmp	.L23
.L54:
	movq	40(%rsp), %rbp
	movq	48(%rsp), %r13
	movl	%ebx, %r14d
	movl	%ecx, %eax
	leaq	1(%r15), %rbx
	xorl	%ecx, %ecx
	movl	%r12d, %r15d
.L20:
	addq	%rbx, %rcx
	addq	%rcx, %r13
	cmpl	$1, %eax
	jne	.L18
	movq	32(%rsp), %r12
	movl	$1, %eax
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L53:
	movq	32(%rsp), %r12
	addq	$1, %r13
	xorl	%eax, %eax
.L17:
	addq	%r13, %rax
	movl	%r14d, %edx
	addq	%rax, %r12
	cmpl	$1, %r14d
	jne	.L15
	movl	$1, %eax
	movq	%rbp, %rbx
	movl	64(%rsp), %ebp
	addq	%r12, %rax
	addq	%rax, %rbx
	cmpl	$1, %r15d
	jne	.L12
.L51:
	addq	$1, %rbx
.L8:
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L52:
	.cfi_restore_state
	addq	$1, %r12
	xorl	%eax, %eax
	movq	%rbp, %rbx
	movl	64(%rsp), %ebp
	addq	%r12, %rax
	addq	%rax, %rbx
	cmpl	$1, %r15d
	jne	.L12
	jmp	.L51
.L30:
	movl	4(%rsp), %edi
	movl	%r9d, %esi
	movslq	%r8d, %r13
	jmp	.L29
	.cfi_endproc
.LFE23:
	.size	fib_rec, .-fib_rec
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Usage: %s <n> <method>\n"
.LC1:
	.string	"Fibonacci(%d) = %llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	cmpl	$3, %edi
	je	.L60
	movq	(%rsi), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rsi
	call	fprintf@PLT
	movl	$1, %eax
.L59:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L60:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	movq	%rsi, 8(%rsp)
	movl	$10, %edx
	xorl	%esi, %esi
	call	__isoc23_strtol@PLT
	movq	8(%rsp), %rcx
	movl	%eax, %r8d
	movq	16(%rcx), %rdx
	cmpb	$105, (%rdx)
	jne	.L62
	movslq	%eax, %rdx
	cmpl	$1, %eax
	jle	.L64
	addl	$1, %eax
	movl	$2, %ecx
	movl	$1, %edx
	xorl	%esi, %esi
	.p2align 4
	.p2align 4
	.p2align 3
.L65:
	movq	%rdx, %rdi
	addl	$1, %ecx
	addq	%rsi, %rdx
	movq	%rdi, %rsi
	cmpl	%eax, %ecx
	jne	.L65
	jmp	.L64
.L62:
	movl	%eax, %edi
	movl	%eax, 8(%rsp)
	call	fib_rec
	movl	8(%rsp), %r8d
	movq	%rax, %rdx
.L64:
	movl	%r8d, %esi
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	xorl	%eax, %eax
	jmp	.L59
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-17) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
