%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov bx, 45    ; muevo a bx el primer numero
    mov ax, 50    ; muevo al ax el segundo
    imul ebx    ; multiplico lo que esta en el ax con lo que esta en el ebx
    call PRINT_DEC 2, eax    ; como el resultado es menor que 2pow16 menor que 4bytes cabe en el ax que son 16 bit
                            ; luego basta imprimirlo
    xor eax, eax
    ret