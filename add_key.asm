%include "io.inc"

section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
;write your code here
xor esi,esi
xor eax,eax
xor ebx,ebx
xor ecx,ecx
xor edx,edx
mov eax,7
lea ebx,[array]
add_key:
mov esi,ecx
xor ecx,ecx
mov edx,[ebx]
cmp eax,edx
jg right
mov ecx,[ebx+4]
cmp ecx,-1
jne next
mov [ebx+4],eax
ret
right:
mov ecx,[ebx+8]
cmp ecx,-1
jne next
mov [ebx+8],eax
ret
next:
shl ecx,4
sub ebx,esi
add ebx,ecx
jmp add_key
section .data
array dd 13, 1, 2, 0, 8, 3, 4, 1, 21, 5, 6, 2, 6, 7, -1, 3, 10, 8, -1, 4, 17, -1, -1, 5, 29, -1, 9, 6, 5, -1, -1, 7, 9, -1, -1, 8, 30, -1, -1, 9