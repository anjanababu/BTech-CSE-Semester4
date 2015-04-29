section .data
	msg1: db "Enter 1st number : ",0Ah
	l1: equ $-msg1 
	msg2: db "Enter 2nd number : ",0Ah
	l2: equ $-msg2 
	msg3: db "Sum is : ",0Ah
	l3: equ $-msg3 

section .bss
	dig1: resb 1
	dig2: resb 1
	dig3: resb 1
	dig4: resb 1
	dig5: resb 2
	num1: resb 1
	num2: resb 1
	num3: resb 1
	num4: resb 1
	num5: resb 2
	res1: resb 1
	res2: resb 1
	res3: resb 1
	res4: resb 1
	res5: resb 1
	res6: resb 1
	c: resb 1

section .text
	global _start:
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, dig1
	mov edx, 1
	int 80h
;Reading second digit
	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h
;Reading third digit
	mov eax, 3
	mov ebx, 0
	mov ecx, dig3
	mov edx, 1
	int 80h
;Reading fourth dig
	mov eax,3
	mov ebx,0
	mov ecx,dig4
	mov edx,1
	int 80h
;Reading fifth digit
	mov eax, 3
	mov ebx, 0
	mov ecx, dig5
	mov edx, 2
	int 80h

sub byte[dig1], 30h
sub byte[dig2], 30h
sub byte[dig3], 30h
sub byte[dig4], 30h
sub byte[dig5], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

;Reading first digit
	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 1
	int 80h
;Reading second digit
	mov eax,3
	mov ebx,0
	mov ecx,num2
	mov edx,1
	int 80h
;Reading third digit
	mov eax, 3
	mov ebx, 0
	mov ecx, num3
	mov edx, 1
	int 80h
;Reading fourth digit
	mov eax,3
	mov ebx,0
	mov ecx,num4
	mov edx,1
	int 80h
;Reading fifth digit
	mov eax, 3
	mov ebx, 0
	mov ecx, num5
	mov edx, 2
	int 80h

sub byte[num1], 30h
sub byte[num2], 30h
sub byte[num3], 30h
sub byte[num4], 30h
sub byte[num5], 30h


movzx ax, byte[dig5]
mov bl,byte[num5]
add al,bl
mov bl,10
div bl
mov byte[res6], ah 
mov byte[c],al


movzx ax, byte[dig4]
mov bl, byte[num4]
add al,bl
add al,byte[c]
mov bl,10
div bl
mov byte[res5], ah 
mov byte[c],al


movzx ax, byte[dig3]
mov bl, byte[num3]
add al,bl
add al,byte[c]
mov bl,10
div bl
mov byte[res4], ah 
mov byte[c],al


movzx ax, byte[dig2]
mov bl, byte[num2]
add al,bl
add al,byte[c]
mov bl,10
div bl
mov byte[res3], ah 
mov byte[c],al


movzx ax, byte[dig1]
mov bl, byte[num1]
add al,bl
add al,byte[c]
mov bl,10
div bl
mov byte[res2], ah 
mov byte[c],al

mov byte[res1],al

add byte[res1], 30h
add byte[res2], 30h
add byte[res3], 30h
add byte[res4], 30h
add byte[res5], 30h
add byte[res6], 30h

;Printing each digit of result

cmp byte[res1],48
je here

mov eax, 4
mov ebx, 1
mov ecx, res1
mov edx, 1
int 80h

here:
mov eax, 4
mov ebx, 1
mov ecx, res2
mov edx, 1
int 80h 

mov eax, 4
mov ebx, 1
mov ecx, res3
mov edx, 1
int 80h 

mov eax, 4
mov ebx, 1
mov ecx, res4
mov edx, 1
int 80h 

mov eax, 4
mov ebx, 1
mov ecx, res5
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, res6
mov edx, 1
int 80h

mov eax, 1
mov ebx, 0
int 80h

