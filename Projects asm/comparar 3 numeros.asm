%include "io.inc"
section .text
global CMAIN


CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    mov eax, 3
    mov ebx, 3
    mov ecx, 5
    
    cmp eax,ebx
    ja cmp1
    cmp ebx, ecx
    ja cmp2
    PRINT_DEC 1,ecx
    jmp end
    
    cmp2:
    PRINT_DEC 1, ebx
    jmp end
    
    cmp1:
    cmp eax,ecx
    ja print 
    
    print:
    PRINT_DEC 1, eax
    
    end:
    ret