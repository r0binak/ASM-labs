%include "io.inc"

section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
xor edi, edi
xor ebx, ebx
_loop: 
mov eax, [edi+array]
test eax, eax ;and
jns _positive ; check flags
neg eax
_positive: 
cmp eax, ebx
cmova ebx, eax
inc edi
or eax, eax
jne _loop
ret

section .data
array: db 3, -67, -34, 222, -45, 75, 777, -443, 634, -666, 32, 0
