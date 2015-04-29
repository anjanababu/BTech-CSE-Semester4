; Write a recursive subroutine to check whether string is palindrome or not?
; Write a recursive program to find the sum of digits of a number.
section .data
	enter_str: db "Enter the string 			:	"
	len_enter_str: equ $-enter_str
	
	enter_num: db "Enter the number			:	"
	len_enter_num: equ $-enter_num
	
	yes: db "YES..The string is a palindrome",10
	len_yes: equ $-yes
	
	no: db "NO..The string is not a palindrome",10
	len_no: equ $-no
	
	result: db "Sum of digits of this number		=	"
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
	
	mov ebx,str
	movzx eax,BYTE[str_len]
	dec eax
	mov edx,str
	add edx,eax
	mov eax,1
	call CHECK_PALINDROME
	
	cmp eax,1
	je print_yes
	jne print_no
print_yes:
	mov ecx,yes
	mov edx,len_yes
	call WRITE
	jmp second_part
print_no:
	mov ecx,no
	mov edx,len_no
	call WRITE
	jmp second_part
second_part:
	mov ecx,enter_num
	mov edx,len_enter_num
	call WRITE
	
	call GETANYNUMBER
	
	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov eax,DWORD[number]
	mov DWORD[temp],eax
	mov DWORD[sum],0
	call SUMOFDIGITS
	mov eax,DWORD[sum]
	
	call DISPLAYNUMBER
	call NEWLINE
	
	jmp exit
exit:
	mov eax,1
	mov ebx,0
	int 80h
;SUBROUTINES
CHECK_PALINDROME:
	cmp ebx,edx
	jbe continue
	mov eax,1
	jmp check_palindrome_done
continue:
	mov al,BYTE[ebx]
	cmp al,BYTE[edx]
	je skip
	mov eax,0
	jmp check_palindrome_done
skip:	
	inc ebx
	dec edx
	call CHECK_PALINDROME
check_palindrome_done:
	ret
SUMOFDIGITS:
	mov edx,0
	mov eax,DWORD[temp]
	
	cmp eax,0
	je got_sum
	
	mov ebx,10
	div ebx
	add DWORD[sum],edx
	mov DWORD[temp],eax
	call SUMOFDIGITS
got_sum:
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
