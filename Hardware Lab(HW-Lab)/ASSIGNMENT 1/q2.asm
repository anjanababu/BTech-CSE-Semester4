section .data
	message: db "Enter a number(max 9 digit)",0Ah
	size: equ $-message
	messageeven: db "Divisible by two",0Ah
	sizeeven: equ $-messageeven
	messageodd: db "NOT Divisble by two",0Ah
	sizeodd: equ $-messageodd
	;messageerr: db "Sorry!!number entered is out of bound...error occured",0Ah
	;sizeerr: equ $-messageerr

section .bss
	digit: resb 1
	number: resd 1

section .text
	global _start:
_start:

	mov eax,4
	mov ebx,1
	mov ecx,message
	mov edx,size
	int 80h
	
	mov dword[number],0 ;set number to zero

getnumber:
	mov eax,3
	mov ebx,0
	mov ecx,digit
	mov edx,1
	int 80h

	cmp byte[digit],10;is digit=\n
	je check;got the entire number
	
	;to make the number into real form
	sub byte[digit],30h
	mov eax,dword[number]
	mov ebx,10
	mul ebx
	;jc error;if carry is there then broke the bound
	

	movzx ebx,byte[digit]
	add eax,ebx
	mov dword[number],eax
	jmp getnumber

	
check:

	mov eax,dword[number]
	mov ebx,2
	div ebx
	cmp edx,0	
	je even
	
	mov eax,4
	mov ebx,1
	mov ecx,messageodd
	mov edx,sizeodd
	int 80h
	jmp exit

even:
	mov eax,4
	mov ebx,1
	mov ecx,messageeven
	mov edx,sizeeven
	int 80h
	jmp exit
;error:
	;mov eax,4
	;mov ebx,1
	;mov ecx,messageerr
	;mov edx,sizeerr
	;int 80h
	;jmp exit
	
exit:
	mov eax,1
	mov ebx,0
	int 80h
