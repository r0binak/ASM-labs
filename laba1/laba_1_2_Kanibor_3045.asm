%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    fld dword [c]
    fld dword [a]
    fld dword [b]
    fdiv
    fadd 
    fst dword[c] ; result in c
    
    ret
section .data
a dd 0x41a80000
b dd 0x41400000
c dd 0x40a00000

