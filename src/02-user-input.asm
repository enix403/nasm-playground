; Compile it with: 
; nasm -f elf32 user-input.asm -o user-input.o
; gcc -m32 user-input.o -o user-input
; 
; Run by executing:
; ./user-input

; nasm -f elf32 src/user-input.asm -o user-input.o && gcc -m32 user-input.o -o user-input

global main
extern printf
extern scanf

section .data
    inputMsg db "Please enter a number: ", 0
    inputFormat db "%d", 0

    outputMsg db "The number is: %d", 10, 0

    integer dd 0


section .text
main:
    push ebp
    mov ebp, esp

    push inputMsg
    call printf
    add esp, 4

    push integer
    push inputFormat
    call scanf
    add esp, 8

    mov ebx, [integer]
    push ebx
    push outputMsg
    call printf
    add esp, 8

    xor eax, eax

    mov esp, ebp
    pop ebp
    ret