%include "io.inc"

section .data
    numeros dd 4, 5, 6, 2, 323, 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    ;GET_DEC 4, numeros
    mov ecx, 6
    
    loop Finaliza
        mov eax, [4*ecx - numeros - 4*6]
        PRINT_DEC 4, eax
    
    Finaliza:
    xor eax, eax
    ret