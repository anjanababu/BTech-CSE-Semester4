;Program to get an array and print the arrayvalue + index
section .data
	msg1: db "Enter the number of elements of the array : "
	lenmsg1: equ $-msg1
	msg2: db "Enter the elements of the array",10
	lenmsg2: equ $-msg2
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
section .txt
	global _start:
_start:
	
	mov ecx,msg1
	mov edx,lenmsg1
	call WRITE

	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[limit],eax
	
	cmp DWORD[limit],0
	ja continue
	jmp exit
continue:
	mov ecx,msg2
	mov edx,lenmsg2
	call WRITE

	mov ebx,array
	call GETARRAY
	
	mov ebx,array
	mov DWORD[index],0
	call PRINTINDEX_NUMARRAY
	
	jmp exit
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
GETARRAY:
	call SETTEMP
		
get_element:
	push ebx
	call GETNUMBER

	mov eax,DWORD[number]
	pop ebx
	mov DWORD[ebx],eax
	
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja get_ready
	ret
get_ready:
	add ebx,4
	jmp get_element
		
	
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
exit:
	mov eax,1
	mov ebx,0
	int 80h
SETTEMP:
	mov eax,DWORD[limit]
	mov DWORD[temp],eax
	ret

PRINTINDEX_NUMARRAY:
	call SETTEMP
		
print_element:
	push ebx
	mov eax,DWORD[ebx]
	add eax,DWORD[index]
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
