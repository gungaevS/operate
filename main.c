#include <stdio.h>
#include <stdlib.h>
#include "fib.h"
int main(int argc, char *argv[]){
if (argc !=3) {
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
