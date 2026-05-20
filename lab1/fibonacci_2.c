#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
unsigned long long fib_iter(int n){
if (n<=1) return n;
unsigned long long a = 0, b=1, c;
for (int i = 2; i <=n; i++) {
c = a+b;
a=b;
b=c;
}
return b;
}
int main() {
int n1=40, n2=45;
int pipefd[2];
if (pipe(pipefd) == -1) {
perror("pipe");
return 1;
}
pid_t pid = fork();
if (pid == -1) {
perror("fork");
return 1;
}
if (pid == 0) {
close(pipefd[0]);
printf("[Child PID=%d] Vychislau fib(%d)...\n", getpid(), n2);
unsigned long long res2 = fib_iter(n2);
write(pipefd[1], &res2, sizeof(res2));
close(pipefd[1]);
printf("[Child] Resultat otpravlen\n");
exit(0);
}else{
close(pipefd[1]);
printf("[Parent PID=%d] Vychislau fib(%d)...\n", getpid(), n1);
unsigned long long res1 = fib_iter(n1);
unsigned long long res2;
read(pipefd[0], &res2, sizeof(res2));
close(pipefd[0]);
wait(NULL);
printf("\nResultat\n");
printf("fib(%d)= %llu (parent)\n", n1, res1);
printf("fib(%d) = %llu (child)\n", n2, res2);
printf("Summ = %llu\n", res1 + res2);
}
return 0;
}
