;Write a Program to find the Length of the String using Recursion
section .data
	enter_str: db "Enter the string 			:	"
	len_enter_str: equ $-enter_str
	
	result: db "Length of the string			=	"
	len_result: equ $-result
	
	blank: db 10

	str_len: db 0
section .bss	
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1
	
	str: resb 100
	char: resb 1
section .text
	global _start:
_start:

reading:
	;;read string
	mov ecx,enter_str
	mov edx,len_enter_str
	call WRITE
	
	mov ebx,str
	call READSTRING
	mov BYTE[ebx],0

	mov ecx,result
	mov edx,len_result
	call WRITE

	mov ebx,str
	mov BYTE[str_len],0
	call STRLEN
	
	movzx eax,BYTE[str_len]
	call DISPLAYNUMBER

	call NEWLINE

	jmp exit
exit:
	mov eax,1
	mov ebx,0
	int 80h
;SUBROUTINES
	;ebx-points to start of the string
	;str_len holds the value
STRLEN:
	cmp BYTE[ebx],0
	je str_len_calculation_done

	inc BYTE[str_len]
	inc ebx
	call STRLEN
str_len_calculation_done:
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
READSTRING:
	;mov BYTE[str_len],0
read_character:
	push ebx
	mov ecx,char
	mov edx,1
	call READ
	pop  ebx
	
	cmp BYTE[char],10
	jne carry_on
	ret
carry_on:	
	;inc BYTE[str_len]
	mov al,BYTE[char]
	mov BYTE[ebx],al
	add ebx,1
	jmp read_character

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
