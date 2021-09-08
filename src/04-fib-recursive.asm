; Compile it with: 
; nasm -f elf32 fib-recursive.asm -o fib-recursive.o
; gcc -m32 fib-recursive.o -o fib-recursive
; 
; Run by executing:
; ./fib-recursive

; Program to calculate fibonacci numbers using recursion

global main
extern printf
extern scanf

section .data
    error_msg db "Invalid input", 0x0a, 0x00
    output_msg db "Fib(%i) = %i", 0x0a, 0x00
    input_prompt db "Enter the number: ", 0
    input_format db "%d", 0

    number dd 0


section .text


main:
    push ebp
    mov ebp, esp

    push input_prompt
    call printf
    add esp, 4

    push dword number
    push input_format
    call scanf
    add esp, 8

    mov ecx, [number]

    cmp ecx, 0
    jl invalid

    push ecx
    call calc_fib

    push eax
    push ecx
    push output_msg
    call printf

    mov eax, 0
    jmp epilog

calc_fib:
    push ebp
    mov ebp, esp

    mov eax, [esp + 8]

    cmp eax, 1
    jle epilog
    
    push eax

    mov ebx, eax
    sub ebx, 1
    push ebx
    call calc_fib
    add esp, 4

    pop ebx
    push eax

    sub ebx, 2
    push ebx
    call calc_fib
    add esp, 4

    pop ebx

    add eax, ebx
    jmp epilog

invalid:
    push error_msg
    call printf
    mov eax, 1
    jmp epilog

epilog:
    mov esp, ebp
    pop ebp
    ret