section .data
	message: db "Enter a number between 0 and 9",0Ah
	size: equ $-message
	
	newline: db 10

section .bss
	num: resb 2
	val: resb 1
	temp: resb 1

section .text
	global _start
_start:

	mov eax,4
	mov ebx,1
	mov ecx,message
	mov edx,size
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,num
	mov edx,2
	int 80h

	mov byte[val],48

print:		
	mov eax,4
	mov ebx,1
	mov ecx,val
	mov edx,1
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h
	
	inc byte[val]
	
	mov cl, byte[val]
	cmp cl,byte[num]	
	jna print
	
	test:
	mov eax,1
	mov ebx,0
	int 80h

