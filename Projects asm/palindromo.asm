%include "io.inc"
section .data
tmp dd 0
no db 'NO',0
yes db 'YES',0

section .bss
string resb 100
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging    
    xor ecx, ecx
    xor eax, eax
    xor ebx, ebx
    GET_STRING string , 100
    call get_length
    call palindromo
    xor eax,eax
    ret
;===============================================================================================================================================
    get_length:
    mov al, [string + ecx]
    cmp al,0
    je _end
    cmp al, 10
    je _end
    inc ecx
    jmp get_length
    _end:
    xor eax,eax
    ret
;===============================================================================================================================================
    palindromo:
    mov [tmp],ecx
    mov al,[tmp]
    mov bl, 2
    mov al,[tmp]    
    mov esi,0
    dec ecx
    algorithm:
        mov al,[string + esi]
        mov bl,[string + ecx]
        cmp al, bl
        jnz _no
        dec ecx
        inc esi
        cmp ecx,[tmp]
        jge algorithm
        jmp _yes
        _no:
        PRINT_STRING no
        jmp finish
        _yes:
        PRINT_STRING yes
        finish:
    ret
    
    
    
