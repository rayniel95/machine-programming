%include "io.inc"
section .data
l1 dd 0
l2 dd 0

addresses dd 0
sizes dd 0

top dd 0

type dd 4
section .bss
c1 resb 256
c2 resb 256

extern _malloc
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
;===== read from input =====    
    GET_DEC 4,eax     ;amount of cases
    mul dword [type]   
    
    ;saving space to reserve for strings and sizes 
    push eax
    push eax
    ;saving getlength - 1
    sub eax, 4        
    mov [top],eax
    
    ;reserving memory
    call _malloc
    mov [addresses],eax
    
    call _malloc
    mov [sizes],eax    
    
    ;reading the inputs
    mov ebx,0
    read:
    cmp ebx,[top]
    jg @_out
    
    GET_STRING c1,256       ;read the string
    xor ecx,ecx
    xor eax,eax
    call get_length          ;view if it is not null or empty
    mov ecx,[l1]        
    cmp ecx,0
    je read
    
    push dword [l1]         ;write it on memory
    call _malloc
    mov ecx,[l1]
    mov esi,c1
    mov edi,eax
    rep movsb
     
    mov eax,[addresses]     ;save it's direction on memory
    sub edi,[l1]
    mov [eax + ebx],edi
    
    mov eax,[sizes]         ;save it's size on memory
    mov ecx,[l1]
    mov [eax + ebx],ecx
    add ebx,4
    jmp read
    @_out:
    
    xor edx,edx
    call ordering   
    mov esp,ebp
    xor eax,eax
    ret
    
;==========================================================
    get_length:
    mov al, [c1 + ecx]
    cmp al,0
    je _end1
    cmp al, 10
    je _end1
    inc ecx
    jmp get_length
    _end1:
    mov [l1],ecx
    xor ecx,ecx
    xor eax,eax
    ret
;==========================================================
    get_length2:
    mov al, [c2 + ecx]
    cmp al,0
    je _end2
    cmp al, 10
    je _end2
    inc ecx
    jmp get_length2
    _end2:
    mov [l2],ecx
    xor ecx,ecx
    xor eax,eax
    ret
;==========================================================
ordering:    
    cmp edx,[top]   
    je _end_
    mov ebx, edx
    cycle:      
        add ebx,4  
        cmp ebx,[top]
        jg _out_
        call copy
        call copy2
        push ebx
        call compare
        pop ebx
        cmp eax, 0
        jle cycle
        mov eax,[addresses]
        mov esi,[eax + edx]
        mov edi,[eax + ebx]
        mov [eax + edx],edi
        mov [eax + ebx],esi
        mov eax,[sizes]
        mov esi,[eax + edx]
        mov edi,[eax + ebx]
        mov [eax + edx],edi
        mov [eax + ebx],esi
        jmp cycle        
    _out_:
    add edx, 4
    jmp ordering
    _end_:
    mov ebx,0
    prt:
    cmp ebx,[top]    
    jg finish
    mov eax,[addresses]
    mov esi, [eax + ebx]
    mov edi, c1
    mov eax,[sizes]
    mov ecx,[eax + ebx]
    rep movsb
    op:
       cmp ecx,[eax + ebx]
       je exit
       PRINT_CHAR [c1 + ecx]
       inc ecx
       jmp op
       exit:
    NEWLINE
    add ebx, 4
    jmp prt
    finish:
ret
;==========================================================
copy:
    mov eax,[addresses]
    mov esi,[eax + edx]
    mov eax,[sizes]
    mov ecx,[eax + edx]
    mov [l1],ecx
    mov edi,c1
    rep movsd
ret
copy2:
    mov eax,[addresses]
    mov esi,[eax + ebx]
    mov eax,[sizes]
    mov ecx,[eax + ebx]
    mov [l2],ecx
    mov edi,c2
    rep movsb
ret
;==========================================================
compare:
        mov ebx,[l1]
        cmp ebx,[l2]
        jle _ch2
        mov ebx,[l2]
        _ch2:
        mov ecx, 0
        xor eax,eax
        start:
        mov al,[c1 + ecx]
        cmp al,[c2 + ecx]
        jl _out2
        jg _out1
        inc ecx
        cmp ecx,ebx
        jl start 
        cmp ebx,[l1]
        jl _out1
    mov eax,0
    jmp end
    _out1:    
    mov eax,1
    jmp end    
    _out2:
    mov eax,-1
    end:
ret