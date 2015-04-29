;Write a program to Reverse the String using Recursion
section .data
	enter_str: db "Enter the string 			:	"
	len_enter_str: equ $-enter_str
	
	result: db "Reversed string				:	"
	len_result: equ $-result
	
	blank: db 10

	str_len: db 0
	flag: db 1
section .bss	
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1
	
	str: resb 100
	char: resb 1

	temp: resd 1
	sum: resd 1
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
	
	mov ecx,result
	mov edx,len_result
	call WRITE

	mov ebx,str
	movzx eax,BYTE[str_len]
	dec eax
	mov edx,str
	add edx,eax
	call STRREVERSE
	
	mov ecx,str
	movzx edx,BYTE[str_len]
	call WRITE	
	
	call NEWLINE

	jmp exit
exit:
	mov eax,1
	mov ebx,0
	int 80h
;SUBROUTINES
	;ebx-points to start of the string
	;edx-points to end of the string
STRREVERSE:
	cmp ebx,edx
	ja str_reverse_done

	mov al,BYTE[ebx]
	mov cl,BYTE[edx]
	mov BYTE[ebx],cl
	mov BYTE[edx],al
	
	inc ebx
	dec edx
	call STRREVERSE
str_reverse_done:
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
	mov BYTE[str_len],0
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
	inc BYTE[str_len]
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
