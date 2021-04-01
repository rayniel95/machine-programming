%include "io.inc"

section .data
text db "Hello World", 0
format db "%s", 0
section .text
extern _printf

global CMAIN
CMAIN:
    push text
    push format
    call _printf
    add esp, 8
    xor eax, eax
    ret