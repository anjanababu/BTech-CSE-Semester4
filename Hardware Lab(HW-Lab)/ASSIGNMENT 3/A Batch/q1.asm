;Write a program to read a string, print the string and its size also.
section .data
	enter: db "Enter the string 	:	"
	len_enter: equ $-enter
	print: db "The string is		:	"
	len_print: equ $-print
	length: db "Length of string	:	"
	len_length: equ $-length
	blank: db 10

	str_len: db 0
section .bss
	number: resd 1
	string: resb 10
	stringlen: resb 1
	
	str: resb 100
	char: resb 1
section .text
	global _start:
_start:

	;;read a string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str
	call READSTRING
	
got_str:

	;print string
	mov ecx,print
	mov edx,len_print
	call WRITE
	
	mov ecx,str
	movzx edx,BYTE[str_len]
	call WRITE
	
	call NEWLINE	
	
	;print length
	mov ecx,length
	mov edx,len_length
	call WRITE
	
	movzx eax,BYTE[str_len]
	call DISPLAYNUMBER
	
	call NEWLINE
exit:
	mov eax,1
	mov ebx,0
	int 80h
;SUBROUTINES
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
	
