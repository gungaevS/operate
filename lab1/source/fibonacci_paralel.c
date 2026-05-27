#include <stdio.h>      // Для printf, fprintf, stderr
#include <stdlib.h>     // Для exit
#include <unistd.h>     // Для fork, pipe, read, write, close, getpid
#include <sys/wait.h>   // Для wait
#include <sys/types.h>  // Для pid_t

// Итеративное вычисление числа Фибоначчи
unsigned long long fib_iter(int n) {
    if (n <= 1) return n;                    // База: F(0)=0, F(1)=1
    unsigned long long a = 0, b = 1, c;      // a - предыдущее, b - текущее, c - временное
    for (int i = 2; i <= n; i++) {           // Цикл от 2 до n
        c = a + b;                           // Сумма двух предыдущих
        a = b;                               // Сдвиг: a получает старое b
        b = c;                               // Сдвиг: b получает сумму
    }
    return b;                                // Возвращаем F(n)
}

int main() {
    int n1 = 40, n2 = 45;                    // Числа для вычисления
    int pipefd[2];                           // Массив для дескрипторов канала

    // Создаём канал (pipe) для связи между процессами
    if (pipe(pipefd) == -1) {
        perror("pipe");                      // Вывод ошибки, если pipe не создался
        return 1;
    }

    pid_t pid = fork();                      // Создаём дочерний процесс

    if (pid == -1) {
        perror("fork");                      // Ошибка создания процесса
        return 1;
    }

    if (pid == 0) {                          // ДОЧЕРНИЙ ПРОЦЕСС (pid == 0)
        close(pipefd[0]);                    // Закрываем чтение из канала
        printf("[Child PID=%d] calculation fib(%d)...\n", getpid(), n2);
        unsigned long long res2 = fib_iter(n2); // Вычисляем fib(45)
        write(pipefd[1], &res2, sizeof(res2));  // Отправляем результат родителю
        close(pipefd[1]);                    // Закрываем запись
        exit(0);                             // Завершаем дочерний процесс
    } else {                                 // РОДИТЕЛЬСКИЙ ПРОЦЕСС (pid > 0)
        close(pipefd[1]);                    // Закрываем запись в канал
        printf("[Parent PID=%d] calculate fib(%d)...\n", getpid(), n1);
        unsigned long long res1 = fib_iter(n1); // Вычисляем fib(40)
        unsigned long long res2;
        read(pipefd[0], &res2, sizeof(res2));   // Читаем результат от потомка
        close(pipefd[0]);                    // Закрываем чтение
        wait(NULL);                          // Ждём завершения дочернего процесса

        printf("\nResults\n");
        printf("fib(%d) = %llu (parent)\n", n1, res1);
        printf("fib(%d) = %llu (child)\n", n2, res2);
        printf("Summ = %llu\n", res1 + res2);
    }
    return 0;
}
