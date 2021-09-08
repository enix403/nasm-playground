section .text             ; Executable code goes in the .text section
global _start             ; The linker looks for this symbol to set the process entry point, so execution start here
;;;a name followed by a colon defines a symbol.  The global _start directive modifies it so it's a global symbol, not just one that we can CALL or JMP to from inside the asm.
;;; note that _start isn't really a "function".  You can't return from it, and the kernel passes argc, argv, and env differently than main() would expect.
 _start:
    ;;; write(1, msg, len);
    ; Start by moving the arguments into registers, where the kernel will look for them
    mov     edx, len       ; 3rd arg goes in edx: buffer length
    mov     ecx, msg       ; 2nd arg goes in ecx: pointer to the buffer
    ;Set output to stdout (goes to your terminal, or wherever you redirect or pipe)
    mov     ebx, 1         ; 1st arg goes in ebx: Unix file descriptor. 1 = stdout, which is normally connected to the terminal.

    mov     eax, 4         ; system call number (from SYS_write / __NR_write from unistd_32.h).
    int     0x80          ; generate an interrupt, activating the kernel's system-call handling code.  64-bit code uses a different instruction, different registers, and different call numbers.
    ;; eax = return value, all other registers unchanged.

    ;;;Second, exit the process.  There's nothing to return to, so we can't use a ret instruction (like we could if this was main() or any function with a caller)
    ;;; If we don't exit, execution continues into whatever bytes are next in the memory page,
    ;;; typically leading to a segmentation fault because the padding 00 00 decodes to  add [eax],al.

    ;;; _exit(0);
    xor     ebx, ebx  ; equivalent to `mov ebx, 0`     
                      ; first arg = exit status = 0.  (will be truncated to 8 bits).  Zeroing registers is a special case on x86, and mov ebx, 0 would be less efficient.
                      ;; leaving out the zeroing of ebx would mean we exit(1), i.e. with an error status, since ebx still holds 1 from earlier.
    mov     eax, 1         ; put __NR_exit into eax
    int     0x80          ;Execute the Linux function

section     .rodata       ; Section for read-only constants

             ;; msg is a label, and in this context doesn't need to be msg:.  It could be on a separate line.
             ;; db = Data Bytes: assemble some literal bytes into the output file.
msg     db  'Hello, world!', 0xa     ; ASCII string constant plus a newline (ACSII Code for newline is 10 = 0x0a)

             ;;  No terminating zero byte is needed, because we're using write(), which takes a buffer + length instead of an implicit-length string.
             ;; To make this a C string that we could pass to puts or strlen, we'd need a terminating 0 byte. (e.g. "...", 0x10, 0)

len     equ $ - msg       ; Define an assemble-time constant (not stored by itself in the output file, but will appear as an immediate operand in insns that use it)
                          ; Calculate len = string length.  subtract the address of the start
                          ; of the string from the current position ($)
  ;; equivalently, we could have put a str_end: label after the string and done len equ str_end - str