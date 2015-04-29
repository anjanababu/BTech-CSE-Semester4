;Write a program to identify number of occurrences of a number in an array. 
section .data
	msg1: db "Enter the number of elements in the array : "
	lenmsg1: equ $-msg1
	msg2: db "Enter the elements of the array",10
	lenmsg2: equ $-msg2
	msg3: db "Enter the number whose frequency to be found: "
	lenmsg3: equ $-msg3
	msg4: db "No. of Occurence = "
	lenmsg4: equ $-msg4
	newline: db 10

section .bss
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1

	array: resd 100 
	limit: resd 1   
	temp: resd 1    ;temporary storage of limit
	freq: resb 1   
	key: resd 1   
section .text
	global _start:
_start:
	;get the number of elements in array(limit)
	mov ecx,msg1
	mov edx,lenmsg1
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[limit],eax
	
	cmp DWORD[limit],0
	je exit                                   ;if 0 elements exit
	
	;get elements of the array
	mov ecx,msg2
	mov edx,lenmsg2
	call WRITE
	
	call SETTEMP
	mov ebx,array
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
	
	;get the number whose frequency to be found(key)
	mov ecx,msg3
	mov edx,lenmsg3
	call WRITE
	
	call GETANYNUMBER
	
	mov eax,DWORD[number]
	mov DWORD[key],eax

	call SETTEMP
	mov ebx,array
	mov eax,DWORD[key]	
	mov DWORD[freq],0
comparing:
	cmp eax,DWORD[ebx]
	jne skip
	add DWORD[freq],1	
skip:
	add ebx,4
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja comparing 
	
	mov eax,DWORD[freq]	
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
	jmp exit

;;;;;;;SUB PROGRAMS
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
	
SETTEMP:
	mov eax,DWORD[limit]
	mov DWORD[temp],eax
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
exit:
	mov eax,1
	mov ebx,0
	int 80h


 
