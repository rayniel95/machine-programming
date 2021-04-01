%include "io.inc"


array dd 20,45,30,17,2,50,

section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    mov eax, [array]
    mov ecx,1
    
    WHILE:
    cmp ecx,4
    je END
    mov ebx,[array + ecx*4]
    cmp eax,ebx
    ja SIGUE
    mov eax, ebx
    SIGUE:
    inc ecx
    jmp WHILE
    END:
    PRINT_UDEC 4, eax 
    ret