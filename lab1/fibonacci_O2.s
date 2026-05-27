	.file	"fibonacci.c"
	.text
	.p2align 4
	.globl	fib_iter
	.type	fib_iter, @function
fib_iter:
.LFB22:
	.cfi_startproc
	cmpl	$1, %edi              ; Сравнить n с 1
	jle	.L7                    ; Если n <= 1, вернуть n
	addl	$1, %edi              ; n = n + 1 (предел цикла)
	movl	$2, %edx              ; i = 2 (счётчик цикла)
	movl	$1, %eax              ; b = 1 (текущее число Фибоначчи)
	xorl	%ecx, %ecx            ; a = 0 (предыдущее число)
	.p2align 4
	.p2align 4
	.p2align 3
.L4:                                ; Начало цикла
	movq	%rax, %rsi            ; tmp = b (сохранить старое b)
	addl	$1, %edx              ; i++
	addq	%rcx, %rax            ; b = b + a (новое число Фибоначчи)
	movq	%rsi, %rcx            ; a = tmp (старое b)
	cmpl	%edi, %edx            ; Сравнить i с n+1
	jne	.L4                    ; Если не равны, продолжить цикл
	ret                            ; Вернуть результат (он в rax)
	.p2align 4,,10
	.p2align 3
.L7:                                ; Случай n <= 1
	movslq	%edi, %rax            ; Расширить n до 64 бит и вернуть
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
	pushq	%r15                  ; Сохранить регистры (много, будет сложная рекурсия)
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edi, %r15d           ; Сохранить n в r15d
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
	movslq	%edi, %rbx            ; Расширить n до 64 бит
	subq	$120, %rsp            ; Выделить 120 байт в стеке
	.cfi_def_cfa_offset 176
	cmpl	$1, %edi              ; Сравнить n с 1
	jle	.L8                    ; Если n <= 1, вернуть n
	; Оптимизатор развернул рекурсию в итеративный процесс с предвычислением
	leal	-1(%rdi), %eax        ; eax = n-1
	movl	%edi, %r12d           ; r12d = n
	xorl	%ebx, %ebx            ; Обнулить счётчик
	andl	$-2, %eax             ; Сделать n-1 чётным
	subl	%eax, %r12d           ; r12d = остаток (0 или 1)
	movl	%r12d, %ebp           ; Сохранить остаток
	; Дальше идёт развёрнутый цикл с предвычислением блоков
	; (слишком длинный и сложный для ручного разбора —
	;  компилятор заменил рекурсию на итеративный расчёт с оптимизацией)
	...
.L8:                                ; Выход из функции
	addq	$120, %rsp            ; Восстановить стек
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %rax            ; Результат в rax
	popq	%rbx                  ; Восстановить регистры
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
	...
	.cfi_endproc
.LFE23:
	.size	fib_rec, .-fib_rec
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Usage: %s <n> <method>\n"    ; Строка справки
.LC1:
	.string	"Fibonacci(%d) = %llu\n"      ; Строка вывода результата
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	subq	$24, %rsp             ; Выделить 24 байта в стеке
	.cfi_def_cfa_offset 32
	cmpl	$3, %edi              ; Сравнить argc с 3
	je	.L60                   ; Если == 3, перейти к обработке
	; Вывод подсказки
	movq	(%rsi), %rdx          ; argv[0]
	movq	stderr(%rip), %rdi    ; stderr
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rsi      ; Строка формата
	call	fprintf@PLT           ; Вывести сообщение
	movl	$1, %eax              ; Код возврата 1
.L59:
	addq	$24, %rsp             ; Восстановить стек
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L60:
	.cfi_restore_state
	movq	8(%rsi), %rdi         ; argv[1] в rdi
	movq	%rsi, 8(%rsp)         ; Сохранить argv в стеке
	movl	$10, %edx             ; Основание 10
	xorl	%esi, %esi            ; Конечный указатель не нужен
	call	__isoc23_strtol@PLT   ; Преобразовать строку в число
	movq	8(%rsp), %rcx         ; Восстановить argv
	movl	%eax, %r8d            ; Сохранить n в r8d
	movq	16(%rcx), %rdx        ; argv[2] в rdx
	cmpb	$105, (%rdx)          ; Сравнить первый символ с 'i'
	jne	.L62                   ; Если не 'i', вызвать рекурсивную версию
	; Итеративное вычисление (заинлайнено прямо в main)
	movslq	%eax, %rdx            ; Расширить n до 64 бит
	cmpl	$1, %eax              ; Сравнить n с 1
	jle	.L64                   ; Если n <= 1, вернуть n
	addl	$1, %eax              ; n = n + 1 (предел цикла)
	movl	$2, %ecx              ; i = 2
	movl	$1, %edx              ; b = 1
	xorl	%esi, %esi            ; a = 0
	.p2align 4
	.p2align 4
	.p2align 3
.L65:                               ; Цикл (заинлайненая версия fib_iter)
	movq	%rdx, %rdi            ; tmp = b
	addl	$1, %ecx              ; i++
	addq	%rsi, %rdx            ; b = b + a
	movq	%rdi, %rsi            ; a = tmp
	cmpl	%eax, %ecx            ; Сравнить i с n+1
	jne	.L65                   ; Продолжить цикл
	jmp	.L64
.L62:
	; Рекурсивное вычисление
	movl	%eax, %edi            ; Передать n через edi
	movl	%eax, 8(%rsp)         ; Сохранить n в стеке
	call	fib_rec               ; Вызвать fib_rec
	movl	8(%rsp), %r8d         ; Восстановить n
	movq	%rax, %rdx            ; Результат в rdx
.L64:
	; Вывод результата
	movl	%r8d, %esi            ; n во 2-й аргумент
	leaq	.LC1(%rip), %rdi      ; Строка формата
	xorl	%eax, %eax
	call	printf@PLT           ; Вывести результат
	xorl	%eax, %eax            ; Код возврата 0
	jmp	.L59                   ; Выйти
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-17) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
