; Compile it with: 
; nasm -f elf32 fib-loop.asm -o fib-loop.o
; gcc -m32 fib-loop.o -o fib-loop
; 
; Run by executing:
; ./fib-loop

; Program to calculate fibonacci numbers using loops (jumps)

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
    mov eax, 0 ; a = 0
    mov ebx, 1 ; b = 1

iter:
    cmp ecx, 0
    je end_loop
    dec ecx

    mov edx, ebx ; tmp = b
    add ebx, eax ; b = b + a
    mov eax, edx ; a = tmp

    jmp iter

invalid:
    push error_msg
    call printf
    mov eax, 1
    jmp epilog

end_loop:
    pop ecx

    push eax
    push ecx
    push output_msg
    call printf

    mov eax, 0

epilog:
    mov esp, ebp
    pop ebp
    ret

