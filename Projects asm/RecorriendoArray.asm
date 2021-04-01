%include "io.inc"

section .data
    numeros dd 3, 5, 7, 8, 2

section .text

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov ecx, 5    ; muevo al ecx la longitud de mi array numeros
    
    Ciclo:    ; una etiqueta que se llama ciclo
        loop Continuar    ; decrementa en uno el ecx si es distino de cero entro en mi ciclo(continuar)
        jmp Finaliza    ; si es igual a cero se ejecuta esta linea y se rompe el ciclo
    Continuar:    ; continuo el ciclo
        PRINT_DEC 4, [numeros+4*5-4*ecx]    ; imprimo el numero en la direccion
        jmp Ciclo    ; retorno al inicio del ciclo
    
    Finaliza: ; finaliza el programa 
    xor eax, eax
    ret
    
    ;[20:15:39] Warning! Errors have occurred in the build:
    ;/tmp/SASM/program.asm:18: error: invalid effective address
    ;gcc: error: /tmp/SASM/program.o: No existe el archivo o el directorio
