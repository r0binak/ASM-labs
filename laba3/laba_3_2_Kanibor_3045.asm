%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, 19 ; добавляемый ключ
    xor ebx, ebx
    mov ebx, array
    xor ecx, ecx
    xor esi, esi
find_key:
    mov esi, ecx
    xor ecx, ecx
    mov edx, [ebx]
    cmp eax, edx
    jne deep
deep:
    ja right   
    mov ecx, [ebx+4]
    jmp check
right:
    mov ecx, [ebx+8]
check:
    cmp ecx, -1
    jne next
    mov [ebx+4], ax
    jmp finally_add
next:
    shl ecx, 4
    sub ebx, esi
    add ebx, ecx
    jmp find_key
finally_add:
    mov dx, [ebx+4]
    ret


section .data
array dd 13, 1, 2, 0, 8, 3, 4, 1, 21, 5, 6, 2, 6, 7, -1, 3, 10, 8, -1, 4, 17, -1, -1, 5, 29, -1, 9, 6, 5, -1, -1, 7, 9, -1, -1, 8, 30, -1, -1, 9