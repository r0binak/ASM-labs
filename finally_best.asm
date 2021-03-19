%include "io.inc"

section .text
global vv 
CMAIN:
    mov ebp, esp; for correct debugging
    xor ecx,ecx
    xor edx,edx
    mov ebx,test1   ;Загрузка массива с исходным деревом
    mov [fm],ebx
    mov cx,16        ;Элемент, наличие которого в дереве надо проверить 
    mov ax,21     ;+1 0   ;Количество элементов которые надо добавить (количество элементов в массиве "dobavim" считая первый 0)
    mov [fq],ax
    mov [fw],cx
    ;call dobavka  ;Подпрограмма создающая ветви дерева (Важно! Перед поиском или добавлением новых элементов данная подпрограмма должна выполняться первая)
    call pp       ;Подпрограмма поиска элемента, который мы задали в cx, в дереве
    call element  ;Подпрограмма добавления новых элементов и балансировки дерева
    ret
dobavka:
    mov cx,-1
dobavka2:
    mov ax,[ebx]
    cmp ax,cx
    je dobavka3
    call levo
    jmp dobavka2
dobavka3:
    add ebx,4
    mov ax,[ebx]
    mov cx,[fq]
    mul cx
    mov cx,ax
    imul cx,10
    mov ax,[ebx]
    add ebx,2
    mov esi,[ebx]
    add ebx,2
    mov dx,-1
dobavka4:
    mov [ebx],dx
    add ebx,2
    inc ax
    mov [ebx],ax
    add ebx,2
    inc ax
    mov [ebx],ax
    add ebx,2
    cmp si,1
    je pr13
    cmp si,3
    je pr31
vz13:
    mov [ebx],si
    add ebx,2 
    loop dobavka4
    ret
pp:
    mov ebx,[fm]
    mov cx,[fw]
pp2:
    mov ax,[ebx]
    cmp ax,-1
    je exit
    cmp cx,ax
    je ura
    ja p1
    call levo
    jmp pp2
p1:
    call pravo
    jmp pp2
ura:
    PRINT_CHAR fa
    ret
exit:
    PRINT_CHAR fb
    ret
pr13:
    mov si,3
    jmp vz13
    ret
pr31:
    mov si,1
    jmp vz13
element:
    call Sortirovka
    mov ebp,dobavim
    mov cx,[fq]
    dec cx
    xor eax,eax
x1:
    mov ebx,[fm]
    mov dx,[ebp]
x2:          ;Ищем место для нового элемента
   mov ax,[ebx]
   cmp ax,-1
   je x11
   cmp dx,ax
   ja x3
   je d11
   call levo
   jmp x2
x3:
   call pravo
   jmp x2
x11:
   mov [ebx],dx
   mov [fL],cx
   jmp d1
d11:
   add ebp,2
   mov cx,[fL]
   loop x1
   ret
r1:
   add ebx,6
   mov ax,[ebx]
   shl ax,4
   sub ebx,4
   mov dx,[ebx]
   shl dx,1
   sub ebx,2
   add ax,dx
   sub ebx,eax  ;1--->2
   ret
d1:
   mov [fk],ebx
   jmp i1
i11:
   mov ebx,[fk]
   call r1
   mov cx,[ebx]
   mov dx,[ebp]
   cmp cx,dx
   jb d2 ;зеленая метка
   call pravo
   mov ax,[ebx]
   cmp ax,-1
   je f1 ;прыгаем проверять вторую -1
   jmp d11 ;если не равно -1, то все хорошо, идем добавлять следующий элемент
   ret
d2:
   call levo
   mov ax,[ebx]
   cmp ax,-1
   je f2;прыгаем проверять вторую -1
   jmp d11
   ret
f1:
   call r1
   call r1
   mov si,[ebx]
   cmp cx,si
   jb g1   ;2<6
   ja g2   ;8>6
   ret
f2:
   call r1
   call r1
   mov ax,[ebx]
   cmp ax,cx
   ja h1  ;3>1
   jb h2  ;3<4
   ret
g1:
   call pravo
   mov ax,[ebx]
   cmp ax,-1
   je balans
   jmp d11
   ret
g2:
   call levo
   mov ax,[ebx]
   cmp ax,-1
   je balans4
   jmp d11
   ret
h1:
   mov si,[ebx]
   call pravo
   mov ax,[ebx]
   cmp ax,-1
   je balans2
   jmp d11
   ret
h2:
   mov si,[ebx]
   call levo
   mov ax,[ebx]
   cmp ax,-1
   je balans3
   jmp d11
   ret
balans:
   mov [ebx],si
   call r1
   mov [ebx],cx
   call levo
   mov ax,[ebp]
   mov [ebx],ax
   call levo  
   mov ax,-1
   mov [ebx],ax  
   jmp d11
   ret
balans2:
   mov [ebx],si
   call r1
   mov ax,[ebp]
   mov [ebx],ax
   call levo
   call pravo
   mov ax,-1
   mov [ebx],ax
   jmp d11
   ret 
balans3:
   mov [ebx],si
   call r1
   mov [ebx],cx
   call pravo
   mov ax,[ebp]
   mov [ebx],ax
   call pravo
   mov ax,-1
   mov [ebx],ax
   jmp d11
   ret
balans4:
   mov [ebx],si
   call r1
   mov ax,[ebp]
   mov [ebx],ax
   call pravo
   call levo
   mov ax,-1
   mov [ebx],ax
   jmp d11
   ret 
pravo:
   add ebx,4
   mov ax,[ebx]
   shl ax,2
   add ax,4
   add ebx,eax
   xor eax,eax
   ret
levo:
   add ebx,2
   mov ax,[ebx]
   shl ax,2
   add ax,2
   add ebx,eax
   xor eax,eax
   ret
Sortirovka:
   xor esi,esi
   mov ebp,dobavim  
   mov cx,[fq]
   dec cx
   mov [ft],cx
   call sort
   call Sred
   ret
sort:
    mov ax,[ebp]
next:
    add ebp,2
    mov dx,[ebp]
    cmp ax,dx
    ja m1
    mov ax,dx
    jmp zanovo
m1:
    mov [ebp],ax
    sub ebp,2
    mov [ebp],dx
    inc si
    add ebp,2
    jmp zanovo
zanovo:
    loop next
    cmp si,0
    ja m2
    ret
m2:
    mov cx,[ft]
    xor esi,esi
    mov ebp,dobavim
    jmp sort
    ret
Sred:
    mov ebp,dobavim
    add ebp,2
    mov cx,[ft]
   test cx,1
   jnz j1
   jz j2
   ret
j1:
   dec cx
   add ebp,ecx
   mov ax,[ebp]
   mov ebp,dobavim
   mov [ebp],ax
   mov [fy],ax
   ret
j2:
   sub cx,2
   add ebp,ecx
   mov ax,[ebp]
   mov ebp,dobavim
   mov [ebp],ax
   mov [fy],ax
   ret 
 i1:
   call r1
   call r1
   mov ax,[fy]
   mov dx,[ebx]
   cmp ax,dx
   je d11
   jmp i11  
   ret  
section .data
fa db '1';Используется для вывода 1 на экран, если искомый элемент есть в дереве
fb db '0';Используется для вывода 0 на экран, если искомый элемент отсутствует в дереве
fq dw 0  ;Используется для сохранения значения количества элементов которые надо добавить
fw dw 0  ;Используется для сохранения значения, которое необходимо найти в дереве, чтобы освободить регистр для работы
fL dw 0  ;Используется для сохранения счетчика цикла
ft dw 0  ;1
fm dd 0  ;2 Переменные  1,2,3,4 используются для сохранения параметров при центральной балансировке (нахождении среднего и так далее)
fy dw 0  ;3
fk dd 0  ;4
dobavim:  ;Массив в который записываем все элементы которые надо добавить в дерево (Важно! Первый 0 должен быть всегда первым, так как используется для среднего числа. Если вам надо добавить значение равное "0", то просто вводим еще один 0 *чтобы было два нуля через запятую)
dw 0,1,7,9,10,12,16
test1:  ;Массив дерева (Смотри дополнение на 250 строке)
dd 13, 1, 2, 0, 8, 3, 4, 1, 21, 5, 6, 2, 6, 7, -1, 3, 10, 8, -1, 4, 17, -1, -1, 5, 29, -1, 9, 6, 5, -1, -1, 7, 9, -1, -1, 8, 30, -1, -1, 9
nulevoi: ;Массив дерева создаваемый с нуля
dw -1,1,2,3,-1,3,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0



;Дополнение к строке 241:
;Первоначально у вас уже может быть дерево (на бумаге например), 
;его следует записать в массив test1 согласно правилу 1 
;(как это сделать будет написано после этого дополнения с пометкой "Правило 1")
;Если же дерево создается впервые, то запиши в массив с деревом данные значения (именно так как дано, но без кавычек): "-1,1,2,0,-1,3,4,1"
;Так как еще не известно о динамическом массиве, то первоначально массив заполнен одними ноликами (пускай так и остаются, будут переделаны под ветки дерева автоматически подпрограммой "dobavka")
;=======================================================================================================
;Правило 1 (для добавления дерева с бумаги):
;Данное правило добавления используется только если вам надо выполнить
; какое-либо условие (например сделать несбалансированное дерево, в котором какой-то n элемент будет находиться уже на 2-3 шаге)
;В иных случаях следует воспользоваться способом описанным на 252 строке, 
;добавив только все значения дерева с бумаги в массив "dobavim", и программа 
;сама их вставит в дерево и сбалансирует (балансировка может незначительно отличаться от бумаги)
;Итак, правило записывания дерева в массив таково:
;Выписываем первый элемент дерева (самый верхний), пронумеровываем разветвления 
;(у первого элемента это будут 1 и 2, у следущего 3,4 и так далее) и записываем
;их через запятую после элемента, а в конце записываем число 0(Важно! Далее элемент на месте 0 будем называть возвратным числом!
;Также важно, что возвратным числом у первого элемента должна быть именно 0!,  0 - как возвратное число используется только у первого элемента, дальше идет чередование 1 и 3), 
;Точно также делаем с следующим элементом (это будет нижний левый элемент после предыдущего), 
;пронумеровываем его разветвления (соотв. 3 и 4 ) и добавляем возвратное число 
;после запятой 1 (Важно! Возвратные числа 1 и 3 чередуются, у первого элемента 
;возвратное число 0, у второго 1, у третьего 3, у четвертого 1 и т.д.)
;После того как элементы дерева на бумаге закончились, в конец следует добавить
;данные значения без ковычек "-1,x,y,z,", где x, это =(последнее пронумерованное разветвление+1),
; y это =(x+1), а z это инверсия последнего возвратного числа (Если было 3, то вместо z пишем 1, если было 1 , то вместо z пишем 3)
; К данному заданию будет также приложена схема с этим же правилом, если вдруг непонятно :)
;