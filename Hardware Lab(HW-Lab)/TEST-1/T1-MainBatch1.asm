;Program to print the common elements of 2 array
section .data
	msg1: db "Enter the number of elements of the array : "
	lenmsg1: equ $-msg1
	msg2: db "Enter the elements of the array",10
	lenmsg2: equ $-msg2
	msg3: db "Elements in common are .....",10
	lenmsg3: equ $-msg3
	space: db " "
	newline: db 10

section .bss
	number: resd 1
	digit: resb 1
	string: resb 10
	stringlen: resb 1

	array1: resd 100
	limit1: resd 1
	counter1: resd 1
	counter2: resd 1
	array2: resd 100
	limit2: resd 1
	temp: resd 1
	prev: resd 1
section .txt
	global _start:
_start:
	;read first array
	mov ecx,msg1
	mov edx,lenmsg1
	call WRITE

	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[limit1],eax
	mov DWORD[temp],eax

	cmp DWORD[limit1],0
	ja continue1
	jmp exit
continue1:
	mov ecx,msg2
	mov edx,lenmsg2
	call WRITE

	mov ebx,array1
	call GETARRAY

	;read second array
	mov ecx,msg1
	mov edx,lenmsg1
	call WRITE

	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[limit2],eax
	mov DWORD[temp],eax
	
	cmp DWORD[limit2],0
	ja continue2
	jmp exit
continue2:
	mov ecx,msg2
	mov edx,lenmsg2
	call WRITE

	mov ebx,array2
	call GETARRAY
	;;;;;;;;;;;;;;;;;ARRAYS READ
	
	mov ebx,array1
	mov ecx,array1
	mov eax,DWORD[limit1]
	mov DWORD[counter1],eax
	call BUBBLESORT

	mov ebx,array2
	mov ecx,array2
	mov eax,DWORD[limit2]
	mov DWORD[counter1],eax
	call BUBBLESORT
	;;;;;;;;;;;;;;;;BOTH ARRAYS SORTED

	;find which array is small
	mov ecx,msg3
	mov edx,lenmsg3
	call WRITE
	
	mov DWORD[prev],48
	mov eax,DWORD[limit1]
	cmp eax,DWORD[limit2]
	ja setarray2
	
	mov ebx,array1
	mov ecx,array2
	mov eax,DWORD[limit1]
	mov DWORD[counter1],eax
	mov eax,DWORD[limit2]
	mov DWORD[counter2],eax
	jmp COMPARE
	
setarray2:
	mov ebx,array2
	mov ecx,array1
	mov eax,DWORD[limit2]
	mov DWORD[counter1],eax
	mov eax,DWORD[limit1]
	mov DWORD[counter2],eax
	jmp COMPARE
	
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
	mov ecx,newline
	mov edx,1
	call WRITE
	
	mov eax,1
	mov ebx,0
	int 80h
SETTEMP:
	mov eax,DWORD[limit1]
	mov DWORD[temp],eax
	ret

PRINTARRAY:
print_element:
	push ebx
	mov eax,DWORD[ebx]
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
	jmp print_element

SPACE:
	mov ecx,space
	mov edx,1
	call WRITE
	ret
BUBBLESORT:
startbubble:
	mov eax,DWORD[counter1]
	mov DWORD[counter2],eax
do:
	mov eax,DWORD[ebx]
	cmp eax,DWORD[ecx]
	jna skip
	call SWAP
skip:
	dec DWORD[counter2]
	cmp DWORD[counter2],0
	je inciloop
	
	add ecx,4
	jmp do
inciloop:
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je sortingover

	add ebx,4
	mov ecx,ebx
	jmp startbubble
sortingover:
	ret
SWAP:
	mov eax,DWORD[ebx]
	mov edx,DWORD[ecx]
	mov DWORD[ebx],edx
	mov DWORD[ecx],eax
	ret

COMPARE:
	mov eax,DWORD[ebx]
	cmp eax,DWORD[ecx]
	jb incsmall2
	cmp eax,DWORD[ecx]
	ja incbig2
	cmp eax,DWORD[ecx]
	je gotone2
incsmall2:
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je exit

	add ebx,4
	jmp COMPARE
incbig2:
	dec DWORD[counter2]
	cmp DWORD[counter2],0
	je exit

	add ecx,4
	jmp COMPARE
gotone2:
	cmp eax,DWORD[prev]
	je taken
	pusha
	mov eax,DWORD[ebx]
	mov DWORD[prev],eax
	call DISPLAYNUMBER
	popa
taken:
	pusha
	mov ecx,space
	mov edx,1
	call WRITE
	popa
	
	dec DWORD[counter1]
	dec DWORD[counter2]
	cmp DWORD[counter1],0
	je exit
	
	cmp DWORD[counter2],0
	je exit
	add ebx,4
	add ecx,4
	jmp COMPARE

			
