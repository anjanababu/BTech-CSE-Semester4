;Read a single digit number and print multiplication table of the number .
section .data
	message: db "Enter a single digit number",0Ah
	size: equ $-message
	table: db "Multiplication Table",0Ah
	tablesize: equ $-table
	newline: db 10

section .bss
	num: resb 2
	temp: resb 1
	digit1: resb 1
	digit2: resb 1
	
section .text
	global _start:
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

	mov eax,4
	mov ebx,1
	mov ecx,table
	mov edx,tablesize
	int 80h

	
	mov byte[temp],1

nextmultiple:
	sub byte[num],30h
	mov al,byte[num]
	mov bl,byte[temp]
	mul bl
	mov bl,10
	div bl
	mov byte[digit1],al
	mov byte[digit2],ah
	add byte[digit1],30h
	add byte[digit2],30h
	cmp byte[temp],11
	jb print
	jmp exit
	
print:
	cmp byte[digit1],48
	je skip

	mov eax,4
	mov ebx,1
	mov ecx,digit1
	mov edx,1
	int 80h

skip:
	mov eax,4
	mov ebx,1
	mov ecx,digit2
	mov edx,1
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	
	
	inc byte[temp]
	add byte[num],30h
	jmp nextmultiple
exit:
	mov eax,1
	mov ebx,0
	int 80h
	
	
