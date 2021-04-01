%include "io.inc"

section .data
    ;mem dw 0
    format db "%i", 0
    A dw 3, 1, 2, 5, 9, 6, 7, 10
    length db 8
    
    result db 0
    result_temp db 0
    
    index1 db 0
    index2 db 0

section .text
extern _scanf
extern _printf

global CMAIN
CMAIN:
    push A
    call MSC
    add 4
    
    push [result]
    push format
    call _printf
    add esp, 4
                    
    xor eax, eax
    ret
    
MSC:
    mov eax, [esp+4]
    mov al, 0
    ciclo:
        push dword 1 ;count
        mov bl , al
        inc bl
        push bl  ;b
        push al  ;a
        push eax ;direccion del array  
        call MSC
        add esp, 16
        
        cmp ebx, result
        jbe itera
            mov [result], ebx  ;actualizar resultado
        itera:
        inc al
        cmp al, [length]  ;VERIFICA que no este haciendo el ciclo de mas
        je ciclo
        
    ret

; int MSCR(int[]* A, int a, int b, int count) devuelve en ebx
MSCR:
    mov eax, [esp+4]
    mov 
    ret