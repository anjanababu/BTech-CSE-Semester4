;Make 2 arrays of limit n,print them and also print which array has greatest sum
section .data
	msg1: db "Enter the number of elements of the 2 arrays : "
	lenmsg1: equ $-msg1
	getarr1: db "Enter the elements of the array 1",10
	lengetarr1: equ $-getarr1
	getarr2: db "Enter the elements of the array 2",10
	lengetarr2: equ $-getarr2
	printarr1: db "Array 1 : "
	lenprintarr1: equ $-printarr1
	printarr2: db "Array 2 : "
	lenprintarr2: equ $-printarr2
	great1: db "Array 1 has greatest sum",10
	lengreat1: equ $-great1
	great2: db "Array 2 has greatest sum",10
	lengreat2: equ $-great2
	bothgreat: db "Both arrays have same sum",10
	lenbothgreat: equ $-bothgreat
	space: db 32
	newline: db 10
section .bss
	number: resd 1
	digit: resb 1
	string: resb 10
	stringlen: resb 1

	array1: resd 100
	array2: resd 100
	limit: resd 1
	temp: resd 1
	sum1: resd 1
	sum2: resd 1
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
	mov ecx,getarr1
	mov edx,lengetarr1
	call WRITE

	mov ebx,array1
	call GETARRAY
	
	mov ecx,getarr2
	mov edx,lengetarr2
	call WRITE

	mov ebx,array2
	call GETARRAY
	
	mov ecx,printarr1
	mov edx,lenprintarr1
	call WRITE
	
	mov ebx,array1
	call SETTEMP
	mov DWORD[sum1],0
findsum1:
	push ebx
	mov eax,DWORD[ebx]
	add DWORD[sum1],eax
	call DISPLAYNUMBER
	call SPACE
	pop ebx
	dec DWORD[temp]
	cmp DWORD[temp],0
	je got1
	add ebx,4
	jmp findsum1
got1:
	call NEWLINE
	mov ecx,printarr2
	mov edx,lenprintarr2
	call WRITE
	
	mov ebx,array2
	call SETTEMP
	mov DWORD[sum2],0
findsum2:
	push ebx
	mov eax,DWORD[ebx]
	add DWORD[sum2],eax
	call DISPLAYNUMBER
	call SPACE
	pop ebx
	dec DWORD[temp]
	cmp DWORD[temp],0
	je got2
	add ebx,4
	jmp findsum2
got2:
	call NEWLINE
	mov eax,DWORD[sum2]
	cmp DWORD[sum1],eax
	ja pa1
	jb pa2
	je both
pa1:
	mov ecx,great1
	mov edx,lengreat1
	call WRITE
	jmp exit
pa2:
	mov ecx,great2
	mov edx,lengreat2
	call WRITE
	jmp exit
both:
	mov ecx,bothgreat
	mov edx,lenbothgreat
	call WRITE
exit:
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