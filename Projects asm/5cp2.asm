%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov eax, -32    ; mueve el numero al eax
    not eax    ; se niega para cambiar todos los bits
    add eax, 1    ; se le adiciona 1
    call PRINT_DEC 4, EAX    ; se imprime
    xor eax, eax
    ret