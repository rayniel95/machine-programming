%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    GET_DEC 4, ebx    ; consigo el numero y lo pongo en ebx
    mov ecx, ebx    ; copio el numero al ecx para irlo disminuyendo con el ciclo y asi divido el numero con el indice 
                ; del ciclo
    mov eax, ebx    ; copio el numero al edx para poderlo dividir con el indice, en el ebx dejo una copia
    mov edx, 0    ; al dividir se usa el eax y el edx pero solo el numero es de 30bits luego relleno con 0 edx
    
    dec ecx    ; decremento el ecx en 1 para que se ejecute el ciclo la primera vez
    
    Ciclo:
        cmp ecx, 1    ; comparo primero el indice con 1, pues ya cuando eso pase el numero es divisible entre uno y 
                    ; no salio del ciclo anteriormente y entonces es primo, no tiene sentido dividir entre 1 y 0
        jz Primo    ; salto si se cumple lo de arriba
        idiv ecx    ; divido el numero inicial con el indice del ciclo
        cmp edx, 0    ; verifico si el resto es cero, de ser asi se activa la flag y cuando se salte para ciclo se rompe
                    ; loop y se salta a noprimo
        je NoPrimo
        mov eax, ebx    ; vuelvo a copiar el numero del ebx al eax para volverlo a dividir entre el proximo indice
        mov edx, 0    ; relleno de nuevo
    loop Ciclo    ; decremento ecx y salto de nuevo al ciclo
    
    Primo:
        PRINT_STRING 'YES'
        jmp Finaliza
    
    NoPrimo:
        PRINT_STRING 'NO'
    
    Finaliza:
    xor eax, eax
    ret