;Write a  program to read 2 integers and add them using procedure
section .data
	enter1: db "Enter the first number	:	"
	len_enter1: equ $-enter1
	
	enter2: db "Enter the second number	: 	"
	len_enter2: equ $-enter2
	
	result: db "Addition Result 	:      	"
	len_result: equ $-result
	
	blank: db 10
	space: db 32
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1
	
	num1: resd 1
	num2: resd 1
	addresult: resd 1
section .text
	global _start:
_start:
	mov ecx,enter1
	mov edx,len_enter1
	call WRITE
	
	call GETANYNUMBER
	mov eax,DWORD[number]
	mov DWORD[num1],eax
	
	mov ecx,enter2
	mov edx,len_enter2
	call WRITE
	
	call GETANYNUMBER
	mov eax,DWORD[number]
	mov DWORD[num2],eax
	
	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov eax,DWORD[num1]
	mov ebx,DWORD[num2]
	call ADDITION
	
	mov eax,DWORD[addresult]
	call DISPLAYNUMBER
	
	call NEWLINE
	
	jmp exit	
	
exit:
	mov eax,1
	mov ebx,0
	int 80h
	
	;eax-first number
	;ebx-second number
	;addresult-result
ADDITION:
	add eax,ebx
	mov DWORD[addresult],eax
	ret
	;result in number
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

	;eax-number to be displayed
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
	mov ecx,blank
	mov edx,1
	call WRITE
	ret
