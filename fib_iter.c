#include "fib.h"
unsigned long long fib_iter(int n) {
if (n<=1) return n;
unsigned long long a = 0, b=1,c;
for (int i=2;i<=n;i++){
c =a+b;
a=b;
b=c;
}
return b;
}
