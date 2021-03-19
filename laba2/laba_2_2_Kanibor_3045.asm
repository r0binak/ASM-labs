%include "io.inc"

section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
mov esi, array
movzx ecx, BYTE [len]
mov dl, [array]
and dl, 0x80
check:
lodsb
and al, 0x80 ;check high bit(sign)
cmp al, dl
jnz bad
xor dl, 0x80 ;change sign
loop check
good:
mov ebx, 1
bad:
ret

section .data
array db -1,4,-5,7,-10,12
len db 6
