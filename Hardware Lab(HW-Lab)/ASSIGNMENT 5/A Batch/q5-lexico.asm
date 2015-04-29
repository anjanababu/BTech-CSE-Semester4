;Compare two strings using recursive subroutines(lexicographicall comparison-same as strcmp in C)
section .data
	enter_str1: db "Enter first string 			:	"
	len_enter_str1: equ $-enter_str1

	
	enter_str2: db "Enter second string 			:	"
	len_enter_str2: equ $-enter_str2
	
	equal: db "Both the strings are equal",10
	len_equal: equ $-equal
	
	first: db "First string is lexicographically larger than the second-i.e first string occurs after the second string in dictionary.",10
	len_first: equ $-first
	
	second: db "Second string is lexicographically larger than the first-i.e second string occurs after the first string in dictionary.",10
	len_second: equ $-second
	
	blank: db 10
	str_len: db 0
section .bss	
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1
	
	string1: resb 100
	string2: resb 100
	char: resb 1
section .text
	global _start:
_start:
	;;read string
	mov ecx,enter_str1
	mov edx,len_enter_str1
	call WRITE
	
	mov ebx,string1
	call READSTRING
	mov BYTE[ebx],0
	
	mov ecx,enter_str2
	mov edx,len_enter_str2
	call WRITE
	
	mov ebx,string2
	call READSTRING
	mov BYTE[ebx],0
	
	mov ebx,string1
	mov ecx,string2
	call STRCMP
	
	cmp eax,256
	je both
	ja first_string
	jb second_string
	
both:
	mov ecx,equal
	mov edx,len_equal
	call WRITE
	jmp exit
first_string:
	mov ecx,first
	mov edx,len_first
	call WRITE
	jmp exit
second_string:
	mov ecx,second
	mov edx,len_second
	call WRITE
	jmp exit
exit:
	mov eax,1
	mov ebx,0
	int 80h
	
	;ebx-points to string1
	;ecx-points to string2
	;eax-return value
	;> 256 if the first string is larger,
	;256 if both strings are similar,
	;< 256 otherwise.
STRCMP:
	movzx eax,BYTE[ebx]
	movzx edx,BYTE[ecx]
	add eax,256
	sub eax,edx
	
	;formula 256+c1-c2
	;min value =1 (256+0-255) thats positive
	cmp eax,256
	jne comparison_done
	
	cmp edx,0
	je comparison_done;if both strings equal...termination condition

	inc ebx
	inc ecx
	call STRCMP
comparison_done:
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