%include "io.inc"

section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
xor ebx, ebx
mov esi, array
_loop: 
lodsd ; cpy dword from esi to eax
and eax, eax
jns _positive ;check sf flag if not 0 jump to positive
neg eax
_positive: 
cmp eax, ebx
cmova ebx, eax ;check zf and cf flags , if they equal 0
or eax, eax ;check current el zero
jne _loop
ret
    
section .data
 
array dd -9,18,-10,22,0  