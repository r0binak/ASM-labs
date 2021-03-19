%include "io.inc"

section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
mov ecx, [array] ; put in ecx amount of array elements
xor ebx, ebx
_loop: 
mov eax, [ecx*4 + array] ; put in eax array elements in order
test eax, eax ; high bit check, flag setting
jns _positive ; if flag is not set, jump to positive
neg eax ; change number sigh if it was negative
_positive:
cmp eax, ebx
cmova ebx, eax ;check zf and cf flags , if they equal 0
loop _loop
ret

section .data
array dd 10,7,0,33,-66,77,-1223,0,99,12,3