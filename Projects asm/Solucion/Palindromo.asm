%include "io.inc"

section .data
length db 0
txt db "",0
format db "%s", 0

section .text
extern _scanf
extern _printf

global CMAIN
CMAIN:
mov ebp, esp
    push txt
    push format
    call _scanf
    add esp, 8
    
    call Length
    cmp dword[length], 0 ;en caso de que sea la cadena vacia
    je final
    
    mov eax, txt
    mov ebx, txt
    add ebx, [length-1]
    Pa:
        mov al, [eax]
        mov bl, [ebx]
        cmp al, bl 
        jne Fal ;si no coinciden entonces ya no es palindromo
            inc eax
            dec ebx
            cmp eax, ebx ;para ver si ya se revisaron todos los caracteres
            jae Verd 
                loop Pa ;caso contrario sigue revisando
        Fal: 
            PRINT_STRING "No"
            jmp final
        Verd:
            PRINT_STRING "YES"
        final:               
    
    xor eax, eax
    xor ecx, ecx
    ret

Length:
    mov eax, txt
    xor ecx, ecx                  
    ciclo:
        mov al, [eax]
        cmp al, 0
        je fin
            inc eax
            inc ecx
            loop ciclo
        fin:
        mov [length], ecx
        ret
        