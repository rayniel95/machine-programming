%include "io.inc"
section .data
lado dd 19
area dd 0 
msg1 db "el resultado es: ",0
msg2 db 10,13,0

section .text
global CMAIN
CMAIN:
    mov eax,[lado] ; aqui tengo eax=19
    mul eax        ; despues de esta linea eax = 19^2
    mov ebx, 6     ; tengo que buscar otro registro pa multiplicar
    mul ebx        ; cuando uno dice "mul ebx" esta sucediendo lo siquiente eax = eax*ebx
    mov [area], eax
    
    PRINT_STRING msg1
    PRINT_DEC 4, [area]
    PRINT_STRING msg2
    
        
            
    xor eax, eax   
    ret