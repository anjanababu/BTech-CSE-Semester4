section .data
	message: db "Enter 3 two digit numbers",0Ah
	size: equ $-message
section .bss
	a1: resb 1
	a2: resb 1
	a3: resb 2
	a: resb 1
	b1: resb 1
	b2: resb 1
	b3: resb 2
	b: resb 1
	c1: resb 1
	c2: resb 1
	c3: resb 2
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
	mov edx,1
	int 80h

	
	mov eax,3
	mov ebx,0
	mov ecx,a3
	mov edx,2
	int 80h
	
	sub byte[a2], 30h
	sub byte[a3], 30h ;now digits contain exact value

	mov al, byte[a2]
	mov bl, 10
	mul bl
	movzx bx,byte[a3]
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
	mov edx,1
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,b3
	mov edx,2
	int 80h
	
	
	sub byte[b2], 30h
	sub byte[b3], 30h ;now digits contain exact value

	mov al, byte[b2]
	mov bl, 10
	mul bl
	movzx bx,byte[b3]
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
	mov edx,1
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,c3
	mov edx,2
	int 80h
	
	sub byte[c2], 30h
	sub byte[c3], 30h ;now digits contain exact value

	mov al, byte[c2]
	mov bl, 10
	mul bl
	movzx bx,byte[c3]
	add ax, bx
	mov byte[c], al ;c is made in exact form

	;cmp byte[a1],45
	;jne donormal
	;cmp byte[b1],45
	;jne donormal
	;cmp byte[c1],45
	;jne donormal

donormal:
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
	add byte[a2], 30h
	add byte[a3], 30h
	
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
	
	mov eax,4
	mov ebx,1
	mov ecx,a3
	mov edx,1
	int 80h
	jmp exit
printb:
	add byte[b2], 30h
	add byte[b3], 30h
	
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

		
	mov eax,4
	mov ebx,1
	mov ecx,b3
	mov edx,1
	int 80h
	jmp exit
printc:
	add byte[c2], 30h
	add byte[c3], 30h
	
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
	
		
	mov eax,4
	mov ebx,1
	mov ecx,c3
	mov edx,1
	int 80h
	jmp exit

exit:
	mov eax,1
	mov ebx,0
	int 80h





