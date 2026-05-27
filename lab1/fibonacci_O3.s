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
	movl	$2, %edx              ; i = 2
	movl	$1, %eax              ; b = 1
	xorl	%ecx, %ecx            ; a = 0
	.p2align 4
	.p2align 4
	.p2align 3
.L4:                                ; Начало цикла for
	movq	%rax, %rsi            ; tmp = b
	addl	$1, %edx              ; i++
	addq	%rcx, %rax            ; b = b + a
	movq	%rsi, %rcx            ; a = tmp (старое b)
	cmpl	%edi, %edx            ; Сравнить i с n+1
	jne	.L4                    ; Продолжить цикл
	ret                            ; Вернуть b (в rax)
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
	pushq	%r15                  ; Сохранить регистры
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edi, %r15d           ; r15d = n (сохраняем для возврата)
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
	movslq	%edi, %rbx            ; rbx = n (64 бита, будущий результат)
	subq	$120, %rsp            ; Выделить 120 байт под локальные переменные
	.cfi_def_cfa_offset 176
	cmpl	$1, %edi              ; Сравнить n с 1
	jle	.L8                    ; Если n <= 1, перейти к возврату
	; Инициализация развёрнутого цикла (оптимизация хвостовой рекурсии)
	leal	-1(%rdi), %eax        ; eax = n-1
	movl	%edi, %r12d           ; r12d = n
	xorl	%ebx, %ebx            ; rbx = 0 (аккумулятор)
	andl	$-2, %eax             ; Сделать n-1 чётным (сбросить младший бит)
	subl	%eax, %r12d           ; r12d = остаток (0 или 1)
	movl	%r12d, %ebp           ; ebp = остаток
	; Дальше идёт развёрнутый итеративный расчёт (компилятор заменил рекурсию
	; на эквивалентный цикл с предвычислением блоков для ускорения)
.L12:                               ; Внешний цикл по блокам
	cmpl	%ebp, %r15d
	je	.L51
	leal	-1(%r15), %edi        ; edi = n-1
	leal	-1(%r15), %edx        ; edx = n-1
	subl	$2, %r15d             ; r15d = n-2 (переход к следующему блоку)
	movl	%ebp, 64(%rsp)        ; Сохранить ebp в стеке
	movl	%r15d, %eax           ; eax = n-2
	xorl	%r12d, %r12d          ; r12 = 0 (промежуточный результат)
	movq	%rbx, %rbp            ; rbp = аккумулятор
	andl	$-2, %eax             ; Сделать чётным
	subl	%eax, %edi            ; edi = остаток для данного блока
	movl	%edi, 68(%rsp)        ; Сохранить остаток
	; Внутренние циклы развёртки (метки .L15, .L18, .L21, .L24, .L27, .L31, .L34)
	; Компилятор развернул рекурсию на несколько уровней для ускорения
	; Каждый уровень вычисляет частичную сумму чисел Фибоначчи
	...
	; Выход из развёрнутого цикла
.L8:                                ; Эпилог функции
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
	pushq	%r14                  ; Сохранить регистры
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp            ; rbp = argv
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp              ; Выровнять стек
	.cfi_def_cfa_offset 48
	cmpl	$3, %edi              ; Сравнить argc с 3
	je	.L60                   ; Если == 3, перейти к обработке
	; Вывод подсказки
	movq	(%rsi), %rdx          ; argv[0] в rdx
	movq	stderr(%rip), %rdi    ; stderr
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rsi      ; Строка формата
	call	fprintf@PLT           ; Вывести справку
	movl	$1, %eax              ; Код возврата 1
.L59:                               ; Выход
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L60:
	.cfi_restore_state
	movq	8(%rsi), %rdi         ; argv[1] в rdi (для strtol)
	movl	$10, %edx             ; Основание 10
	xorl	%esi, %esi            ; Конечный указатель не нужен
	call	__isoc23_strtol@PLT   ; Преобразовать строку в число
	movq	%rax, %rbx            ; rbx = n
	movq	16(%rbp), %rax        ; argv[2] в rax
	cmpb	$105, (%rax)          ; Сравнить первый символ с 'i'
	je	.L72                   ; Если 'i', идти к итеративному
	; Частично развёрнутое рекурсивное вычисление
	cmpl	$1, %ebx              ; Сравнить n с 1
	jle	.L73                   ; Если n <= 1, пропустить цикл
	movl	%ebx, %ebp            ; ebp = n
	xorl	%r12d, %r12d          ; r12 = 0 (аккумулятор)
.L66:                               ; Цикл частичного развёртывания
	leal	-1(%rbp), %edi        ; edi = n-1
	subl	$2, %ebp              ; n = n-2
	call	fib_rec               ; Вызвать fib_rec(n-1)
	addq	%rax, %r12            ; Добавить к аккумулятору
	cmpl	$1, %ebp              ; Проверить, не достигли ли 1
	jg	.L66                   ; Продолжить цикл
	leal	-2(%rbx), %eax        ; eax = n-2
	shrl	%eax                  ; / 2 (получить число итераций)
	imull	$-2, %eax, %eax       ; * -2
	leal	-2(%rax,%rbx), %edx   ; edx = n - 2 - 2*(n/2) (остаток)
.L67:                               ; Завершение рекурсивного расчёта
	movslq	%edx, %rdx            ; Расширить до 64 бит
	addq	%r12, %rdx            ; Добавить аккумулятор
.L64:                               ; Вывод результата
	movl	%ebx, %esi            ; n во 2-й аргумент
	leaq	.LC1(%rip), %rdi      ; Строка формата
	xorl	%eax, %eax
	call	printf@PLT           ; Вывести результат
	xorl	%eax, %eax            ; Код возврата 0
	jmp	.L59                   ; Выйти
.L72:                               ; Итеративное вычисление (заинлайнено)
	movslq	%ebx, %rdx            ; Расширить n до 64 бит
	cmpl	$1, %ebx              ; Сравнить n с 1
	jle	.L64                   ; Если n <= 1, сразу вывести
	leal	1(%rbx), %edi         ; edi = n+1 (предел цикла)
	movl	$2, %eax              ; i = 2
	movl	$1, %edx              ; b = 1
	xorl	%ecx, %ecx            ; a = 0
	.p2align 4
	.p2align 4
	.p2align 3
.L65:                               ; Цикл (заинлайненая fib_iter)
	movq	%rdx, %rsi            ; tmp = b
	addl	$1, %eax              ; i++
	addq	%rcx, %rdx            ; b = b + a
	movq	%rsi, %rcx            ; a = tmp
	cmpl	%edi, %eax            ; Сравнить i с n+1
	jne	.L65                   ; Продолжить
	jmp	.L64                   ; Вывести результат
.L73:                               ; Случай n <= 1 для рекурсивного пути
	movl	%ebx, %edx            ; edx = n
	xorl	%r12d, %r12d          ; r12 = 0
	jmp	.L67
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-17) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
