	.file	"fibonacci.c"
	.text
	.globl	fib_iter
	.type	fib_iter, @function
fib_iter:
.LFB22:
	.cfi_startproc
	cmpl	$1, %edi              ; Сравнить n с 1
	jle	.L6                    ; Если n <= 1, вернуть n
	addl	$1, %edi              ; Увеличить n на 1 (для условия цикла: i != n+1)
	movl	$2, %edx              ; i = 2 (счётчик цикла)
	movl	$1, %eax              ; b = 1 (текущее число Фибоначчи, будет в rax)
	movl	$0, %ecx              ; a = 0 (предыдущее число, будет в rcx)
	.p2align 4
.L4:                                ; Начало тела цикла
	movq	%rax, %rsi            ; tmp = b (сохраняем старое b)
	addq	%rcx, %rax            ; b = b + a (новое число Фибоначчи)
	addl	$1, %edx              ; i++ (увеличиваем счётчик)
	movq	%rsi, %rcx            ; a = tmp (старое b становится новым a)
	cmpl	%edi, %edx            ; Сравнить i с n+1
	jne	.L4                    ; Если не равны, продолжить цикл
	ret                            ; Вернуть b (оно в rax)
.L6:                                ; Случай n <= 1
	movslq	%edi, %rax            ; Расширить n до 64 бит и вернуть
	ret
	.cfi_endproc
.LFE22:
	.size	fib_iter, .-fib_iter
	.globl	fib_rec
	.type	fib_rec, @function
fib_rec:
.LFB23:
	.cfi_startproc
	pushq	%r14                  ; Сохранить регистры, которые будут испорчены
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp              ; Выровнять стек
	.cfi_def_cfa_offset 32
	movl	%edi, %ebx            ; Сохранить n в ebx
	movslq	%edi, %rax            ; Расширить n до 64 бит
	cmpl	$1, %edi              ; Сравнить n с 1
	jle	.L7                    ; Если n <= 1, вернуть n
	leal	-1(%rdi), %edi        ; edi = n-1
	call	fib_rec               ; Вызвать fib_rec(n-1)
	movq	%rax, %r14            ; Сохранить результат в r14
	leal	-2(%rbx), %edi        ; edi = n-2
	call	fib_rec               ; Вызвать fib_rec(n-2)
	addq	%rax, %r14            ; Сложить fib_rec(n-1) + fib_rec(n-2)
	movq	%r14, %rax            ; Результат в rax
.L7:
	addq	$8, %rsp              ; Восстановить стек
	.cfi_def_cfa_offset 24
	popq	%rbx                  ; Восстановить регистры
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	fib_rec, .-fib_rec
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Usage: %s <n> <method>\n"    ; Строка справки
.LC1:
	.string	"Fibonacci(%d) = %llu\n"      ; Строка вывода результата
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	pushq	%r14                  ; Сохранить регистры
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp              ; Выровнять стек
	.cfi_def_cfa_offset 32
	movq	%rsi, %rbx            ; Сохранить argv в rbx
	cmpl	$3, %edi              ; Сравнить argc с 3
	je	.L12                   ; Если == 3, перейти к обработке
	; Вывод подсказки при неправильном количестве аргументов
	movq	(%rsi), %rdx          ; argv[0] в rdx (3-й аргумент)
	leaq	.LC0(%rip), %rsi      ; Строка формата
	movq	stderr(%rip), %rdi    ; stderr (1-й аргумент)
	movl	$0, %eax
	call	fprintf@PLT           ; Вывести сообщение об ошибке
	movl	$1, %eax              ; Вернуть 1
.L11:
	addq	$8, %rsp              ; Восстановить стек
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx                  ; Восстановить регистры
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L12:
	.cfi_restore_state
	movq	8(%rsi), %rdi         ; argv[1] в rdi (для strtol)
	movl	$10, %edx             ; Основание системы счисления = 10
	movl	$0, %esi              ; Конечный указатель не нужен
	call	__isoc23_strtol@PLT   ; Преобразовать строку в число
	movl	%eax, %edi            ; Результат (n) в edi
	movl	%eax, %r14d           ; Сохранить n в r14d
	movq	16(%rbx), %rax        ; argv[2] в rax
	cmpb	$105, (%rax)          ; Сравнить первый символ с 'i'
	jne	.L14                   ; Если не 'i', вызвать рекурсивную версию
	call	fib_iter              ; Вызвать итеративное вычисление
	movq	%rax, %rdx            ; Результат в rdx
.L15:
	movl	%r14d, %esi           ; n во 2-й аргумент printf
	leaq	.LC1(%rip), %rdi      ; Строка формата в 1-й аргумент
	movl	$0, %eax
	call	printf@PLT           ; Вывести результат
	movl	$0, %eax              ; Вернуть 0
	jmp	.L11
.L14:
	call	fib_rec               ; Вызвать рекурсивное вычисление
	movq	%rax, %rdx            ; Результат в rdx
	jmp	.L15
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-17) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
