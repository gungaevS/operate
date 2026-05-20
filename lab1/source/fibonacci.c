#include <stdio.h>
#include <stdlib.h>
unsigned long long fib_iter(int n){
if (n<=1) return n;
unsigned long long a=0, b=1, c;
for (int i = 2; i<=n; i++){
c = a+b;
a=b;
b=c;
}
return b;
}
unsigned long long fib_rec(int n){
if (n<=1) return n;
return fib_rec(n-1) + fib_rec(n-2);
}
int main(int argc, char *argv[]) {
if (argc != 3){
fprintf(stderr, "Usage: %s <n> <method>\n", argv[0]);
return 1;
}
int n = atoi(argv[1]);
unsigned long long result;
if (argv[2][0] == 'i')
result = fib_iter(n);
else 
result = fib_rec(n);
printf("Fibonacci(%d) = %llu\n", n, result);
return 0;
}
