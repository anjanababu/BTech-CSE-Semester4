;Write a program to input an arrray and create a new array with factorial of the numbers of the previous array
section .data
	msglimit: db "No. of elements in array : "
	lenmsglimit: equ $-msglimit
	msgele: db "Elements of the array : ",10
	lenmsgele: equ $-msgele
	result: db "Resulting Array",10
	lenresult: equ $-result
	newline: db 10
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	;a digit
	string: resb 10 
        stringlen: resb 1
	
	array1: resd 200
	array2: resd 200
	limit: resd 1
	temp: resd 1
section .text
	global _start:
_start:

	;get array
	mov ecx,msglimit
	mov edx,lenmsglimit
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[limit],eax
	mov DWORD[temp],eax 
	
	cmp DWORD[limit],0
	je exit                        ;dont input array1
	
	mov ebx,array1
	call GETARRAY

	mov ecx,result
	mov edx,lenresult
	call WRITE


creating_new_array:
	mov ecx,array1
	mov edx,array2
	mov eax,DWORD[limit]
	mov DWORD[temp],eax
	
	new_array_loop:
		cmp DWORD[temp],0
		je new_array_made

		mov ebx,DWORD[ecx]

		push ecx
		push edx
		call FACTORIAL
		pop edx
		pop ecx

		mov DWORD[edx],eax
		dec DWORD[temp]	
		add ecx,4
		add edx,4
		jmp new_array_loop
new_array_made:
	mov ebx,array2
	mov eax,DWORD[limit]
	mov DWORD[temp],eax

	call DISPLAYARRAY

	jmp exit
	
;;;;;;;SUB PROGRAMS
	;ebx-number
	;eax-result
FACTORIAL:
	cmp ebx,1
	ja recursive_call_factorial
	mov eax,1 ;n<=1
	ret
recursive_call_factorial:
	push ebx
	dec ebx
	call FACTORIAL
	pop ebx
	mul ebx
	ret

GETARRAY:
readelement:
	push ebx
	
	call GETANYNUMBER
	mov eax,DWORD[number]

	pop ebx
	mov DWORD[ebx],eax
	
	add ebx,4
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja readelement
	ret
	
	;ebx-points to the base address of the array
	;temp-limit of the array
DISPLAYARRAY:
	cmp DWORD[temp],0
	je display_array_done

	dec DWORD[temp]
	mov eax,DWORD[ebx]
	
	push ebx
	call DISPLAYNUMBER
	call NEWLINE
	pop ebx

	add ebx,4
	call DISPLAYARRAY
display_array_done:
	ret

GETANYNUMBER:
	mov DWORD[number],0
  getnumber:
	mov ecx,digit
	mov edx,1
	call READ

	cmp BYTE[digit],10                 ;is digit=newline
	jne carryon
	ret			   	   ;got the n digit number
  carryon:				   ;to change number from ascii
	sub byte[digit],30h
	mov eax,DWORD[number]
	mov ebx,10
	mul ebx
	
	movzx ebx,byte[digit]
	add eax,ebx
	mov DWORD[number],eax
	jmp getnumber

DISPLAYNUMBER:
  	mov BYTE[stringlen], 0
  	mov ebx, string
  	add ebx, 9           ;pointing to end of string
  
   convert_number:
	mov edx, 0
  	mov ecx, 10
  	div ecx
  
 	mov BYTE[ebx], dl
	add BYTE[ebx], 48  ;coverting the got digit to ascii equivalent
  
  	inc BYTE[stringlen]
  	cmp eax, 0
  	je convert_done
  	dec ebx
  	jmp convert_number
  convert_done:
  	mov ecx, ebx
  	movzx edx, BYTE[stringlen]
  	call WRITE
 	ret
  

WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret
READ:
	mov eax,3
	mov ebx,0
	int 80h
	ret
NEWLINE:
	mov ecx,newline
	mov edx,1
	call WRITE
	ret
exit:
	mov eax,1
	mov ebx,0
	int 80h



 
