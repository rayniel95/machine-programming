%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    mov eax, 33 ; muevo a eax el numero
    and eax, 1 ; le hago and bit a bit con 1 para ver si el ultimo bit es uno se deja el resultado en el eax
    cmp eax, 0 ; lo comparo con cero, si es par sera 0 1 si es impar
    
    jnz Impar ; salto si es impar
        PRINT_STRING 'Par' ; si no salte imprimo par y salto al final
    jmp Finaliza
    
    Impar:
        PRINT_STRING 'Impar'
    
    Finaliza:
    
    xor eax, eax
    ret