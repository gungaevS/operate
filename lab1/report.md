# Лабораторная работа 1

**Тема:** Исследование компилятора GCC, язык ассемблера, Makefile, Git

---

## 1. Исходная программа

Реализована программа вычисления чисел Фибоначчи на языке C.
- fib_iter — итеративный метод
- fib_rec — рекурсивный метод

Программа принимает два аргумента: n (номер числа) и метод (i или r).

---

## 2. Трансляция в ассемблер

Команды для получения ассемблерных листингов:

gcc -S -O0 -o fibonacci_O0.s fibonacci.c
gcc -S -O1 -o fibonacci_O1.s fibonacci.c
gcc -S -O2 -o fibonacci_O2.s fibonacci.c
gcc -S -O3 -o fibonacci_O3.s fibonacci.c

### Сравнение уровней оптимизации

| Уровень | Особенности |
|---------|-------------|
| -O0 | Переменные в стеке, код читаемый |
| -O2 | Переменные в регистрах, цикл оптимизирован |
| -O3 | Развёртывание рекурсии, fib_iter заинлайнена в main |

| Уровень | Строк кода |
|---------|------------|
| -O0 | 89 |
| -O2 | 67 |
| -O3 | 183 |

---

## 3. Анализ ассемблерного кода (-O2)

Разобрана функция fib_iter:

- Переменные: n в edi, a в ecx, b в rax, i в edx
- Цикл for: метка L4 и переход jne L4
- Условие n <= 1: cmpl 1, edi и jle L7
- Обмен значений через временный регистр rsi
- Оптимизация: вместо i <= n используется i != n+1

Добавлен swap с использованием инструкции xchg.

---

## 4. Модульная структура

fib_project/
  incl/
    fib.h
  source/
    fib_iter.c
    fib_rec.c
    fibonacci.c
    fibonacci_parallel.c
    main.c
  assembler/
    fibonacci_O0.s
    fibonacci_O1.s
    fibonacci_O2.s
    fibonacci_O3.s
  Makefile

| Цель | Действие |
|------|----------|
| all | Сборка программы |
| asm | Генерация ассемблерных листингов |
| clean | Очистка |

---

## 5. Параллельный процесс

- fork() — создание дочернего процесса
- Родитель вычисляет fib(40), потомок — fib(45)
- Синхронизация через pipe
- Ожидание завершения: wait()

---

## 6. Git и GitHub

- Локальный репозиторий, .gitignore
- Репозиторий: github.com/gungaavs/opera

---

## Файлы

- [fib.h](incl/fib.h)
- [fibonacci.c](source/fibonacci.c)
- [fibonacci_paralel.c](source/fibonacci_paralel.c)
- [main.c](source/main.c)
- [Makefile](Makefile)
- [fibonacci_parallel.c](fibonacci_parallel.c)

## Ассемблер

- [fibonacci_O0.s](fibonacci_O0.s)
- [fibonacci_O2.s](fibonacci_O1.s)
- [fibonacci_O2.s](fibonacci_O2.s)
- [fibonacci_O3.s](fibonacci_O3.s)

---

## Вывод

Изучена работа GCC с флагами -O0, -O1, -O2, -O3. Проведён анализ ассемблерного кода: найдены циклы, переменные, условные переходы. Реализован swap (xchg). Разработана модульная структура и Makefile. Освоены fork(), pipe, git и GitHub.
