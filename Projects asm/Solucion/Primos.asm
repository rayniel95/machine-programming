%include "io.inc"

section .data
num db 0
format db "%i",0

section .text
extern _scanf

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push num
    push format
    call _scanf
    add esp, 8
    
    mov ecx, [num]
    sub ecx, 2
    mov eax, [num]
    mov bx, [num]
    
    ciclo:
    xor edx, edx
        dec bx
        div bx
        cmp dx, 0
        je Falso
            loop ciclo
    
    PRINT_STRING "YES"
    jmp fin
    
    Falso:
        PRINT_STRING "NO"
    fin:
    
    xor ebx, ebx
    xor eax, eax
    xor edx, edx
    ret