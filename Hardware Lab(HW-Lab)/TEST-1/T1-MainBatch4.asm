;Input 2 integers a and b make an array containing elements from a to b and print the array
section .data
	lower: db "Enter the value of a 	:	"
	lenlower: equ $-lower
	upper: db "Enter the value of b	:	"
	lenupper: equ $-upper
	errormsg: db "ERROR:Please enter a<=b";
	lenerrormsg: equ $-errormsg
	result: db "The array created",10
	lenresult: equ $-result
	space: db " "
	newline: db 10

section .bss
	number: resd 1
	digit: resb 1
	string: resb 10
	stringlen: resb 1

	array: resd 100
	limit: resd 1
	index: resd 1
	temp: resd 1
	a: resd 1
	b: resd 1
section .txt
	global _start:
_start:
	
	;read a
	mov ecx,lower
	mov edx,lenlower
	call WRITE

	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[a],eax
	
	;read b
	mov ecx,upper
	mov edx,lenupper
	call WRITE

	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[b],eax
	;;;;;;;;;;
	;;;;;;;;;;
	mov eax,DWORD[a]
	cmp eax,DWORD[b]
	jna fine
	
	mov ecx,errormsg
	mov edx,lenerrormsg
	call WRITE
	jmp exit
fine:	
	mov ebx,array
create:
	mov eax,DWORD[a]
	mov DWORD[ebx],eax
	cmp eax,DWORD[b]
	je array_created
	
	add ebx,4
	inc DWORD[a]
	jmp create
array_created:
	mov ebx,array
dothis:	
	push ebx
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	pop ebx
	
	mov eax,DWORD[ebx]
	cmp eax,DWORD[b]
	je exit
	push ebx
	call SPACE
	pop ebx
	add ebx,4
	jmp dothis
exit:
	call NEWLINE
	mov eax,1
	mov ebx,0
	int 80h
;;SUBROUTINES
GETNUMBER:
	mov DWORD[number],0
get_digit:
	mov ecx,digit
	mov edx,1
	call READ

	cmp BYTE[digit],10
	jne carry_on
	ret
carry_on:
	sub BYTE[digit],30h
	mov eax,DWORD[number] 	
	mov ebx,10
	mul ebx

	movzx ebx,BYTE[digit]
	add eax,ebx
	mov DWORD[number],eax
	jmp get_digit

DISPLAYNUMBER:
	mov BYTE[stringlen],0
	mov ebx,string
	add ebx,9
get_rem:
	mov edx,0
	mov ecx,10
	div ecx
	
	mov BYTE[ebx],dl
	add BYTE[ebx],30h
	inc BYTE[stringlen]
	
	cmp eax,0
	je printnum
	
	dec ebx
	jmp get_rem
printnum:
	mov ecx,ebx
	movzx edx,BYTE[stringlen]
	call WRITE
	ret	
READ:
	mov eax,3
	mov ebx,0
	int 80h
	ret

WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret

SETTEMP:
	mov eax,DWORD[limit]
	mov DWORD[temp],eax
	ret

PRINTSQUAREARRAY:
	call SETTEMP
		
print_element:
	push ebx
	mov eax,DWORD[ebx]
	mul DWORD[ebx]
	call DISPLAYNUMBER
	call SPACE
	pop ebx
	
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja get_ready2
	
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	ret
get_ready2:
	add ebx,4
	inc DWORD[index]
	jmp print_element

SPACE:
	mov ecx,space
	mov edx,1
	call WRITE
	ret
NEWLINE:
	mov ecx,newline
	mov edx,1
	call WRITE
	ret
