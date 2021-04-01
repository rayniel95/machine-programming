%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    GET_DEC 4, ecx ; consigo el numero y lo pongo en el ecx
                    ; diferencio el caso de 0, lo trato como caso aparte
    mov ebx, 0 ; voy a verificar si el numero que se me paso es 0, pongo 0 en el ebx y si es cero en el ecx termino
    cmp ecx, 0 ; devolvinedo lo que esta en el ebx (0)
    
    je Retorna ; salto al final si se me paso un 0
    
    mov eax, 0 ; preparo las cosas para fibonacci, eax sera f(x-2) y ebx f(n-1)
    mov ebx, 1 
    
    Ciclo: ; creo un ciclo
    loop Continuar ; se le resta uno al numero(sencillamente hago fib la cantidad de veces que me indica el numero)
    jmp Retorna ; como no es cero se va a ejecutar el cuerpo del ciclo (continuar) en caso de ser 0 se rompe el 
    Continuar: ; en caso de ser 0 se rompe el ciclo
        mov edx, ebx ; se hace fib, sencillamente se usa edx como registro temporal
        add ebx, eax
        mov eax, edx
    jmp Ciclo ; se empieza el ciclo de nuevo
    
    Retorna:
        PRINT_DEC 4, ebx
    
    xor eax, eax
    ret