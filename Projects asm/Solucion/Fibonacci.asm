%include "io.inc"

section .data
u dd 1
p dd 0
temp dd 0
num dd 0
format db "%i",0

section .text
extern _scanf
extern _printf

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push num
    push format
    call _scanf
    add esp, 8
   
    cmp dword[num], 0
    je Cero
    cmp dword[num], 1
    je Uno
    
    xor ecx, ecx
    mov ecx, [num]
    dec ecx
    ciclo:
        mov eax, [u]
        mov [temp], eax
        mov ebx, [u]
        add ebx, [p]
        mov [u], ebx
        mov edx, [temp]
        mov [p], edx
        loop ciclo
    push dword[u]          
    push format
    call _printf
    add esp, 8
    jmp fin
    
    Cero:
        PRINT_DEC 1, 0
        jmp fin
    Uno:
        PRINT_DEC 1, 1    
        fin:
    xor eax, eax
    ret
    
    
    