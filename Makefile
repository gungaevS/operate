CC = gcc
CFLAGS = -Wall -O2
TARGET = fibonacci
OBJS = main.o fib_iter.o fib_rec.o
all: $(TARGET)
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)
main.o: main.c fib.h
	$(CC) $(CFLAGS) -c main.c
fib_iter.o: fib_iter.c fib.h
	$(CC) $(CFLAGS) -c fib_iter.c
fib_rec.o: fib_rec.c fib.h
	$(CC) $(CFLAGS) -c fib_rec.c
asm: fib_iter.s fib_rec.s main.s
%.s: %.c
	$(CC) -S $(CFLAGS) -o $@ $<
clean:
	rm -f *.o *.s $(TARGET)
	.PHONY: all asm clean
