section .data
	message: db "Enter 3 two digit numbers",0Ah
	size: equ $-message
section .bss
	a1: resb 1
	a2: resb 2
	a: resb 1
	b1: resb 1
	b2: resb 2
	b: resb 1
	c1: resb 1
	c2: resb 2
	c: resb 1
section .text
	global _start:
_start:

	mov eax,4
	mov ebx,1
	mov ecx,message
	mov edx,size
	int 80h
;FIRST NUMBER
	mov eax,3
	mov ebx,0
	mov ecx,a1
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,a2
	mov edx,2
	int 80h
	
	sub byte[a1], 30h
	sub byte[a2], 30h ;now digits contain exact value

	mov al, byte[a1]
	mov bl, 10
	mul bl
	movzx bx,byte[a2]
	add ax, bx
	mov byte[a], al ;a is made in exact form
;SECOND NUMBER
	mov eax,3
	mov ebx,0
	mov ecx,b1
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,b2
	mov edx,2
	int 80h
	
	sub byte[b1], 30h
	sub byte[b2], 30h ;now digits contain exact value

	mov al, byte[b1]
	mov bl, 10
	mul bl
	movzx bx,byte[b2]
	add ax, bx
	mov byte[b], al ;b is made in exact form
;THIRD NUMBER
	mov eax,3
	mov ebx,0
	mov ecx,c1
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,c2
	mov edx,2
	int 80h
	
	sub byte[c1], 30h
	sub byte[c2], 30h ;now digits contain exact value

	mov al, byte[c1]
	mov bl, 10
	mul bl
	movzx bx,byte[c2]
	add ax, bx
	mov byte[c], al ;c is made in exact form

;check A>B or B>A
	mov al,byte[a]
	cmp al,byte[b]
	ja lb ;if a>b
	jmp la ;if a<b

la:
	mov al,byte[b]
	cmp al,byte[c]
	jb printb ;bcoz a>b>c
	mov al,byte[a]
	cmp al,byte[c]
	ja printa ;a>b<c and a<c
	jmp printc

	
lb:
	mov al,byte[b]
	cmp al,byte[c]
	ja printb ;bcoz a<b<c
	mov al,byte[a]
	cmp al,byte[c]
	ja printc ;a<b>c and c>a
	jmp printa
printa:
	add byte[a1], 30h
	add byte[a2], 30h
	
	mov eax,4
	mov ebx,1
	mov ecx,a1
	mov edx,1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,a2
	mov edx,1
	int 80h
	jmp exit
printb:
	add byte[b1], 30h
	add byte[b2], 30h
	
	mov eax,4
	mov ebx,1
	mov ecx,b1
	mov edx,1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,b2
	mov edx,1
	int 80h
	jmp exit
printc:
	add byte[c1], 30h
	add byte[c2], 30h
	
	mov eax,4
	mov ebx,1
	mov ecx,c1
	mov edx,1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,c2
	mov edx,1
	int 80h
	jmp exit

exit:
	mov eax,1
	mov ebx,0
	int 80h





