%include "io.inc"

section .data


section .text
global CMAIN
CMAIN:
    mov eax, 5     ; aca se sustituye por el numero por el momento no se como poner io
    and eax, 1    ; se le hace and con 1 para saber el valor del ultimo bit
    call PRINT_DEC 4, EAX    ; se imprime el resultado, 0 para par 1 para impar
    xor eax, eax
    ret