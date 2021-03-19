%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ebp, esp; for correct debugging
    mov eax, 0x4    ; eax - min
    mov ebx, 0x2
    mov ecx, 0xe
frst_cmpr:    
    cmp eax, ebx
    jl sec_cmpr
    mov eax, ebx
sec_cmpr: 
    cmp ecx, eax
    jl thr_cmpr
    jmp exit
thr_cmpr:
    mov eax, ecx
    ret
exit:
    ret