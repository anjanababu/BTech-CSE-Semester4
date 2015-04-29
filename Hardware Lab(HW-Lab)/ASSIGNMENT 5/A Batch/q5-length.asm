;Compare two strings using recursive subroutines(lengthwise comparison)
section .data
	enter_str1: db "Enter first string 			:	"
	len_enter_str1: equ $-enter_str1

	
	enter_str2: db "Enter second string 			:	"
	len_enter_str2: equ $-enter_str2
	
	equal: db "Both the strings are lengthwise equal",10
	len_equal: equ $-equal
	
	first: db "First string is length wise larger than the second",10
	len_first: equ $-first
	
	second: db "Second string is length wise larger than the first",10
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
	
	cmp eax,1
	je first_string
	jb both
	ja second_string
	
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
	;0-equal
	;1-firstlarger
	;2-secondlarger
STRCMP:
	movzx eax,BYTE[ebx]
	movzx edx,BYTE[ecx]

	cmp eax,0
	je check_for_second
	cmp edx,0
	jne strcmp_recursive
	mov eax,1
	jmp comparison_done
	
check_for_second:
	cmp edx,0
	jne larg_sec
	mov eax,0
	jmp comparison_done
larg_sec:
	mov eax,2
	jmp comparison_done
strcmp_recursive:
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