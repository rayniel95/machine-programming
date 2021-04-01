%include "io.inc"

;cada contacto esta definido por nombre-telefono-grupos-enlace_al_proximo_contacto

section .data
    lista dd 0 ;guarda la direccion a la lista de contactos
    inicio dd 0
    entry db "Pedro", 0
    entry1 db "Su", 0
    entry2 db "Robin", 0
    length db 0
    index db 0
    
    temp dd "", 0
    
    format db "%s", 0
    format1 db "%s %s", 0
    
    msg dw "", 0
    
    msg2 db "El contacto ya ha sido añadido", 0 ;contacto repetido
    msg3 db "El contacto no existe", 0 ;eliminar o mostrar un contacto que no existe
    msg4 db "No existen contactos", 0 ;cuando piden listar contactos, y la lista es vacia
    msg5 db "", 0
    
    
section .text
    extern _scanf
    extern _printf
    extern _malloc

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    call INITIATE
    
    push dword 8
    push dword [entry]
    ;push lista
    call ADD_CONTACT ;Add(Pedro, 8)
    add esp, 8
    
    push dword 15
    push dword [entry1]
    ;push lista
    call ADD_CONTACT
    add esp, 8
    
    push dword 23
    push dword [entry2]
    ;push lista
    call ADD_CONTACT
    add esp, 8
    
    xor eax, eax
    ret
    
INITIATE:
    mov dword[inicio], lista
    ret
    
;void ADD_CONTACT(nombre, telefono)
ADD_CONTACT:
    push dword[esp + 4] ;nombre
    push lista
    call SEARCH
    add esp, 8

    cmp bl, 2
    je contacto_repetido 
    
;sino esntonces hay que insertar
    inc dword[length] ;porque se inserta un nuevo contacto
    push dword 4
    call _malloc
    add esp, 4
    
    ;obteniendo los valores de la pila
    mov ecx, [esp + 4] ;nombre
    mov edx, [esp + 8] ;telef
    mov [eax], ecx ;guardando nombre 
    mov [eax + 2], edx ;guardando telef  ######REVISAR POR LO DE DW O DD########
    mov dword[eax + 4], 0 ;la direccion a los grupos estara en 0 si no tiene.
    
    mov ecx, [ebx] ;en caso de que ya estuviera enlazado con otro contacto guardar para no perder info
    mov [ebx], eax ;enlazando el nuevo contacto con el anterior
    
    cmp bl, 0 ;bl=0 es que es el ultimo contacto, bl=1 es correr lista
    je fin
        mov [eax + 6], ecx ;sino entonces me queda correr la lista enlazando con el de la derecha ######REVISAR POR LO DE DW O DD########
        jmp fin

    contacto_repetido:
    push msg2
    push format
    call _printf
    add esp, 8
    
    fin:
    ret
    
REMOVE_CONTACT:
    push dword[esp + 4]
    push lista
    call SEARCH
    add esp, 8

    cmp bl, 2
    jne not_found
    
    ;sino entonces lo encontro y lo elimino
    mov eax, [ebx] ;la direccion de memoria que apunta al contacto proximo
    mov ebx, [eax + 6] ;enlazo el contacto anterior con el proximo
    jmp fin1
    
    not_found:
    push msg3
    push format
    call _printf
    add esp, 8
    
    fin1:
    xor eax, eax
    ret

;void UPDATE(nombre, numero)
UPDATE_CONTACT:
    push dword[esp + 4]
    push lista
    call SEARCH
    add esp, 8

    cmp bl, 2
    jne not_found1
    
    ;sino entonces lo encontro y modifico el numero
    mov eax, [ebx] ;la direccion de memoria que apunta al contacto a modificar
    add eax, 2
    mov eax, [esp + 8]  ;sacar de la pila el nuevo # y guardarlo actualizado
    jmp fin2
    
    not_found1:
    push msg3
    push format
    call _printf
    add esp, 8
    
    fin2:
    xor eax, eax
    ret

;void SHOW(nombre)
SHOW_CONTACT:
    push dword[esp + 4]
    push lista
    call SEARCH
    add esp, 8

    cmp bl, 2
    jne not_found2
    
    ;sino entonces lo encontro y lo imprimo
    mov eax, [ebx] ;la direccion de memoria que apunta al contacto a imprimir
    mov ecx, [eax]
    mov dword[msg], ecx
    PRINT_STRING msg ;nombre
    mov ecx, [eax + 2]
    mov dword[msg], ecx
    PRINT_STRING msg ;telefono
    mov ebx, [eax + 4] ;grupo                   ##############PREGUNTAR SI HACE FALTA#########
    cmp ebx, 0
    je fin3
        call LIST_GROUPS
    jmp fin3
    
    not_found2:
    push msg3
    push format
    call _printf
    add esp, 8
    
    fin3:
    xor eax, eax
    ret

;void LIST(lista)
LIST_CONTACTS:
    mov al, [length]
    cmp al, [index]
    je fin4
    
    mov eax, [esp + 4] ;guardando la lista
    mov ebx, [eax] ;guardo la direccion a los contactos
    mov ecx, [ebx] ;guardando nombre
    mov edx, [ebx + 2] ;guardando telefono
    
    ;imprimir
    push ecx
    push edx
    push format1
    call _printf
    add esp, 12
    
    push dword[ebx + 6]
    inc dword[index]
    call LIST_CONTACTS
    add esp, 4
    
    fin4:
    mov dword[index], 0
    ret
    
;*ebx SEARCH(lista, nombre)    
SEARCH:
    xor bl, bl
    mov ebx, [esp + 4] ;lista
    mov ecx, [ebp + 8] ;nombre
    
    mov al, [length]
    cmp al, [index]
    je fin6 ;devolver_lista ;entonces no existen contactos a la derecha
    
    mov edx, [lista] ;copiar la direccion del contacto actual
    cmp [edx], ecx
    je propio_elemento
    ja correr_lista ;devolver_lista
    
    ;si no entonces hay que seguir revisando hasta ubicarlo correctamente
    push ecx
    add ebx, 6 ;porque es doble palabra #######REVISAR SI VAS A HACERLO CON DD######
    push ebx
    inc dword[index]
    call SEARCH
    add esp, 8
    jmp fin6
    
    propio_elemento:
        mov bl, 2 ;senala que es devuelve el mismo elemento que se busca
        jmp fin6
    correr_lista:
        inc bl
    fin6:
    mov dword[index], 0
    ret
    
LIST_GROUPS:
    ret