# Makefile

NASM_X86 = nasm -f elf32
LD_X86 = ld -m elf_i386
GCC_X86 = gcc -m32

builddir = ./build
objects = $(builddir)/objects
srcdir = ./src

_dummy := $(shell mkdir -p $(objects))

all: example1 example2 example3 example4

.PHONY: clean
clean:
	rm -rf $(builddir)

example1: $(srcdir)/01-hello-world.asm
	$(NASM_X86) $(srcdir)/01-hello-world.asm -o $(objects)/01-hello-world.o
	$(LD_X86) $(objects)/01-hello-world.o -o $(builddir)/01-hello-world

example2: $(srcdir)/02-user-input.asm
	$(NASM_X86) $(srcdir)/02-user-input.asm -o $(objects)/02-user-input.o
	$(GCC_X86) $(objects)/02-user-input.o -o $(builddir)/02-user-input

example3: $(srcdir)/03-fib-loop.asm
	$(NASM_X86) $(srcdir)/03-fib-loop.asm -o $(objects)/03-fib-loop.o
	$(GCC_X86) $(objects)/03-fib-loop.o -o $(builddir)/03-fib-loop

example4: $(srcdir)/04-fib-recursive.asm
	$(NASM_X86) $(srcdir)/04-fib-recursive.asm -o $(objects)/04-fib-recursive.o
	$(GCC_X86) $(objects)/04-fib-recursive.o -o $(builddir)/04-fib-recursive
