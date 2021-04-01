%include "io.inc"

section .data
a dd 0
b dd 0
format db "%i", 0

section .text
extern _printf

global CMAIN
CMAIN:
    push a
    push format
    call _scanf
    add esp, 8
    
    push b
    push format
    call _scanf
    add esp, 8
    
    mov eax, [a]
    add eax, [b]
    push eax
    push format
    call _printf
    add esp, 8
    
    xor eax, eax
    ret