%include "io.inc"

section .data
a times 100 db "", 0
b times 100 db "", 0
format db "%s %s", 0

section .text
extern _scanf
extern _printf

global CMAIN
CMAIN:
mov ebp, esp
    push b
    push a
    push format
    call _scanf
    add esp, 12
    
    mov eax, a
    mov ebx, b
    
    Comp:
        mov al, [eax]
        mov bl, [ebx]
        cmp al, bl
        jb Menor
        ja Mayor
            inc eax ;si son iguales
            inc ebx
            cmp dword[eax], 0 ;si se acado el primer string
            je Preg
            cmp dword[ebx], 0 ;si se acado el segundo string
            je Mayor
            loop Comp
        Preg:
            cmp dword[ebx], 0
            je Igual
        Menor:
            PRINT_DEC 1, -1
            jmp fin
        Mayor:
            PRINT_DEC 1, 1
            jmp fin
        Igual:
            PRINT_DEC 1, 0
        fin:              
    
    xor eax, eax
    xor ecx, ecx
    ret


        