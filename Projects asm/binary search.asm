%include "io.inc"
section .data
data db 1, 2, 4, 5, 6, 8, 10, 14, 15, 16, 18, 19, 20, 21, 22, 24, 25, 27, 30, 31, 32, 33, 34, 36, 39, 44, 45, 46, 48, 50, 51, 52, 53
len equ $ - data
section .bss

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor ebx,ebx
 mov ebx,2
 mov esi,0
 mov edi,len
 dec edi
 GET_DEC 1, cl
 call BS
 xor eax,eax
 ret
 ;==============================================================================================================================================
 BS:
 cmp esi, edi
 jg no
 mov eax,esi
 add eax,edi
 xor edx,edx
 div ebx 
 mov dl,[data + eax]
 cmp dl,cl
 je yes
 jg way1
 jl way2 
 way1:
 dec eax
 mov edi,eax
 call BS
 jmp end
 way2:
 inc eax
 mov esi,eax
 call BS
 jmp end
 yes:
 PRINT_DEC 4 ,eax
 ret
 no:
 PRINT_DEC 4, -1d
 ret
 end:
 ret