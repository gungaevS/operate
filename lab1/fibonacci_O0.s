	.file	"fibonacci.c"        ; Исходный файл
	.text
	.globl	fib_iter              ; Делаем fib_iter видимой для других файлов
	.type	fib_iter, @function
fib_iter:
.LFB6:
	.cfi_startproc
	pushq	%rbp                 ; Сохраняем старый указатель базы стека
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp           ; Устанавливаем новый указатель базы стека
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)      ; Сохраняем аргумент n в стеке (по адресу rbp-36)
	
	; ПРОВЕРКА if (n <= 1) 
	cmpl	$1, -36(%rbp)        ; Сравниваем n с 1
	jg	.L2                    ; Если n > 1, переходим к циклу
	
	; ВОЗВРАТ n (для n <= 1) 
	movl	-36(%rbp), %eax      ; Загружаем n в eax
	cltq                         ; Расширяем 32 бита в 64 бита (со знаком)
	jmp	.L3                    ; Переходим к выходу из функции
	
.L2:
	; ИНИЦИАЛИЗАЦИЯ ПЕРЕМЕННЫХ a, b, i 
	movq	$0, -8(%rbp)         ; a = 0 (64 бита, rbp-8)
	movq	$1, -16(%rbp)        ; b = 1 (64 бита, rbp-16)
	movl	$2, -20(%rbp)        ; i = 2 (32 бита, rbp-20)
	jmp	.L4                    ; Переходим к проверке условия цикла
	
.L5:
	; ТЕЛО ЦИКЛА for 
	movq	-8(%rbp), %rdx       ; Загружаем a в rdx
	movq	-16(%rbp), %rax      ; Загружаем b в rax
	addq	%rdx, %rax           ; rax = a + b
	movq	%rax, -32(%rbp)      ; c = a + b (сохраняем в стеке, rbp-32)
	
	movq	-16(%rbp), %rax      ; Загружаем старое b
	movq	%rax, -8(%rbp)       ; a = старое b
	
	movq	-32(%rbp), %rax      ; Загружаем c
	movq	%rax, -16(%rbp)      ; b = c
	
	addl	$1, -20(%rbp)        ; i++ (увеличиваем счётчик)
	
.L4:
	; ПРОВЕРКА УСЛОВИЯ ЦИКЛА i <= n 
	movl	-20(%rbp), %eax      ; Загружаем i в eax
	cmpl	-36(%rbp), %eax      ; Сравниваем i и n
	jle	.L5                    ; Если i <= n, продолжаем цикл
	
	; ВОЗВРАТ b 
	movq	-16(%rbp), %rax      ; Загружаем b в rax (возвращаемое значение)
	
.L3:
	popq	%rbp                 ; Восстанавливаем старый указатель базы стека
	.cfi_def_cfa 7, 8
	ret                          ; Выходим из функции
	.cfi_endproc
.LFE6:
	.size	fib_iter, .-fib_iter
	
	.globl	fib_rec              ; Делаем fib_rec видимой
	.type	fib_rec, @function
fib_rec:
.LFB7:
	.cfi_startproc
	pushq	%rbp                 ; Сохраняем rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp           ; Устанавливаем новый rbp
	.cfi_def_cfa_register 6
	pushq	%rbx                 ; Сохраняем rbx (callee-saved регистр)
	subq	$24, %rsp            ; Выделяем 24 байта в стеке
	.cfi_offset 3, -24
	movl	%edi, -20(%rbp)      ; Сохраняем n в стеке
	
	; ПРОВЕРКА if (n <= 1) 
	cmpl	$1, -20(%rbp)        ; Сравниваем n с 1
	jg	.L7                    ; Если n > 1, идём вычислять рекурсивно
	
	; ВОЗВРАТ n
	movl	-20(%rbp), %eax      ; Загружаем n
	cltq                         ; Расширяем до 64 бит
	jmp	.L8                    ; Выходим
	
.L7:
	; ВЫЧИСЛЕНИЕ fib_rec(n-1) 
	movl	-20(%rbp), %eax      ; Загружаем n
	subl	$1, %eax             ; n - 1
	movl	%eax, %edi           ; Передаём n-1 как аргумент
	call	fib_rec              ; Вызываем fib_rec(n-1)
	movq	%rax, %rbx           ; Сохраняем результат в rbx
	
	; ВЫЧИСЛЕНИЕ fib_rec(n-2) 
	movl	-20(%rbp), %eax      ; Загружаем n
	subl	$2, %eax             ; n - 2
	movl	%eax, %edi           ; Передаём n-2 как аргумент
	call	fib_rec              ; Вызываем fib_rec(n-2)
	
	; СЛОЖЕНИЕ РЕЗУЛЬТАТОВ 
	addq	%rbx, %rax           ; rax = fib_rec(n-1) + fib_rec(n-2)
	
.L8:
	movq	-8(%rbp), %rbx       ; Восстанавливаем rbx
	leave                        ; Восстанавливаем rsp и rbp (mov rsp,rbp; pop rbp)
	.cfi_def_cfa 7, 8
	ret                          ; Выходим
	.cfi_endproc
.LFE7:
	.size	fib_rec, .-fib_rec
	
	.section	.rodata
.LC0:
	.string	"Usage: %s <n> <method>\n"     ; Строка для вывода справки
.LC1:
	.string	"Fibonacci(%d) = %llu\n"       ; Строка для вывода результата
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	pushq	%rbp                 ; Пролог функции: сохраняем rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp            ; Выделяем 32 байта локальных переменных
	movl	%edi, -20(%rbp)      ; argc сохраняем в стеке
	movq	%rsi, -32(%rbp)      ; argv сохраняем в стеке
	
	; ПРОВЕРКА КОЛИЧЕСТВА АРГУМЕНТОВ 
	cmpl	$3, -20(%rbp)        ; Сравниваем argc с 3
	je	.L10                   ; Если == 3, идём к обработке
	
	; ВЫВОД ПОДСКАЗКИ (если аргументов не 3)
	movq	-32(%rbp), %rax      ; Загружаем argv
	movq	(%rax), %rdx         ; argv[0] в rdx
	movq	stderr(%rip), %rax   ; Загружаем stderr
	leaq	.LC0(%rip), %rcx     ; Адрес строки "Usage: ..."
	movq	%rcx, %rsi           ; 2-й аргумент: строка
	movq	%rax, %rdi           ; 1-й аргумент: stderr
	movl	$0, %eax             ; 0 векторных регистров
	call	fprintf@PLT          ; Вызываем fprintf
	movl	$1, %eax             ; Код возврата 1
	jmp	.L11                   ; Выходим
	
.L10:
	; ПРЕОБРАЗОВАНИЕ argv[1] В ЧИСЛО 
	movq	-32(%rbp), %rax      ; argv
	addq	$8, %rax             ; argv + 8 = &argv[1]
	movq	(%rax), %rax         ; Загружаем argv[1] (строка)
	movq	%rax, %rdi           ; Передаём строку в atoi
	call	atoi@PLT             ; Вызываем atoi
	movl	%eax, -12(%rbp)      ; n = atoi(argv[1])
	
	; ПРОВЕРКА МЕТОДА (argv[2][0]) 
	movq	-32(%rbp), %rax      ; argv
	addq	$16, %rax            ; argv + 16 = &argv[2]
	movq	(%rax), %rax         ; Загружаем argv[2]
	movzbl	(%rax), %eax         ; Берём первый символ argv[2][0]
	cmpb	$105, %al            ; Сравниваем с 'i' (код 105)
	jne	.L12                   ; Если не 'i', идём к рекурсии
	
	; ИТЕРАТИВНЫЙ МЕТОД 
	movl	-12(%rbp), %eax      ; Загружаем n
	movl	%eax, %edi           ; Передаём n в fib_iter
	call	fib_iter             ; Вызываем fib_iter
	movq	%rax, -8(%rbp)       ; Сохраняем результат
	jmp	.L13
	
.L12:
	; РЕКУРСИВНЫЙ МЕТОД
	movl	-12(%rbp), %eax      ; Загружаем n
	movl	%eax, %edi           ; Передаём n в fib_rec
	call	fib_rec              ; Вызываем fib_rec
	movq	%rax, -8(%rbp)       ; Сохраняем результат
	
.L13:
	; ВЫВОД РЕЗУЛЬТАТА 
	movq	-8(%rbp), %rdx       ; Результат в rdx (3-й аргумент printf)
	movl	-12(%rbp), %eax      ; n в eax
	leaq	.LC1(%rip), %rcx     ; Строка формата
	movl	%eax, %esi           ; n во 2-й аргумент
	movq	%rcx, %rdi           ; Строка в 1-й аргумент
	movl	$0, %eax             ; 0 векторных регистров
	call	printf@PLT           ; Вызываем printf
	movl	$0, %eax             ; Код возврата 0
	
.L11:
	leave                        ; Восстанавливаем стек (mov rsp,rbp; pop rbp)
	.cfi_def_cfa 7, 8
	ret                          ; Выходим из main
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-17) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
