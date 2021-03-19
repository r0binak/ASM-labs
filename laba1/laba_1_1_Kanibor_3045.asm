%include "io.inc"

section .text
global CMAIN
CMAIN:
    
    mov ebp, esp; for correct debugging      
    xor edx,edx
    xor ebx,ebx
    xor ecx,ecx
    mov ax, 0x15
    mov bx, 0xc
    div bl
    mov cx, 0x5
    add cl, al  ; result in ecx
    ret