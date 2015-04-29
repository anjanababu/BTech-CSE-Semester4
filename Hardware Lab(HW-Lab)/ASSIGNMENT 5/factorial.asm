;Write a program to read a number and find it's factorial using recursive subroutine.
section .data
	enter: db "Enter the number	:	"
	len_enter: equ $-enter
	
	result: db "FACTORIAL of this number",10
	len_result: equ $-result
	
	blank: db 10
	space: db 32
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1
	
section .text
	global _start:
_start:
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	call GETANYNUMBER
	
	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov ebx,DWORD[number]
	call FACTORIAL
	
	call DISPLAYNUMBER
	call NEWLINE
	
	jmp exit	
	
exit:
	mov eax,1
	mov ebx,0
	int 80h
	
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
SPACE:
	mov ecx,space
	mov edx,1
	call WRITE
	ret
