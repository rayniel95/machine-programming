%include "io.inc"
%include 'PrimeLib'

section .text
global CMAIN
CMAIN:
    
    GET_DEC 4, ebx ; consigo el numero y lo pongo en ebx
    mov ecx, ebx ; copio el numero al ecx para irlo disminuyendo con el ciclo y asi divido el numero con el indice 
                ; del ciclo
    mov eax, ebx ; copio el numero al edx para poderlo dividir con el indice, en el ebx dejo una copia
    mov edx, 0
    
    Ciclo:
    loopz NoPrimo
        cmp ecx, 1 ; comparo primero el indice con 1, pues ya cuando eso pase el numero es divisible entre uno y 
                    ; no salio del ciclo anteriormente y entonces es primo, no tiene sentido dividir entre 1 y 0
        jz Primo ; salto si se cumple lo de arriba
        idiv ecx ; divido el numero inicial con el indice del ciclo
        cmp edx, 0 ; verifico si el resto es cero, de ser asi se activa la flag y cuando se salte para ciclo 
                    ; loop y se salta a noprimo
        mov eax, ebx ; vuelvo a copiar el numero del ebx al edx para volverlo a dividir entre el proximo indice
        mov edx, 0
    jmp Ciclo ; salto de nuevo al ciclo

    
    xor eax, eax
    ret