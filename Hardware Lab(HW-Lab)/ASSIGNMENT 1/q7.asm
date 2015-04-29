section .data

	msg1: db "Enter 1st number(2 digit):"
	len1: equ $-msg1
	msg2: db "Enter 2nd number(2 digit):"
	len2: equ $-msg2
	msg3: db "gcd of two numbers is : "
	len3: equ $-msg3

section .bss
	dig1: resb 1
	dig2: resb 1
	dig3: resb 1
	dig4: resb 1
	num1: resb 1
	num2: resb 1
	sum: resb 1

section .text
	global _start:
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 80h
;FIRST NUMBER
	mov eax, 3
	mov ebx, 0
	mov ecx, dig1
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, dig2
	mov edx, 2
	int 80h

	sub byte[dig1], 30h
	sub byte[dig2], 30h ;now digits contain exact value

	mov al, byte[dig1]
	mov bl, 10
	mul bl
	movzx bx,byte[dig2]
	add ax, bx
	mov byte[num1], al ;num1 is made in exact form
;SECOND NUMBER
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 80h

	mov eax, 3
	mov ebx, 0 
	mov ecx, dig1
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, dig2
	mov edx, 2
	int 80h

	sub byte[dig1], 30h
	sub byte[dig2], 30h ;now digits contain exact value

	mov al, byte[dig1]
	mov bl, 10
	mul bl
	movzx bx, byte[dig2]
	add eax, ebx
	mov byte[num2],al ;num2
do:
	movzx ax,byte[num1]
	mov bl,byte[num2]
	div bl
	mov cl,ah
	mov byte[num1],bl
	mov byte[num2],cl
	cmp byte[num2],0
	ja do

	movzx ax,byte[num1]
	mov bl,10
	div bl
	mov byte[dig1],al
	mov byte[dig2],ah

	add byte[dig1],48
	add byte[dig2],48

	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, dig1
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, dig2
	mov edx, 1
	int 80h	

	mov eax,1
	mov ebx,0
	int 80h
