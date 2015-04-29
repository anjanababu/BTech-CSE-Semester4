;Write a program to read 2 strings, print the string which is largest in terms of length.
section .data
	enter: db "Enter the string 	:	"
	len_enter: equ $-enter
	print: db "The largest string	:	"
	len_print: equ $-print
	blank: db 10
	space: db 32

	str1_len: db 0
	str2_len: db 0
	str_len: db 0
section .bss
	str1: resb 100
	str2: resb 100
	char: resb 1
section .text
	global _start:
_start:

	;;read first string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str1
	call READSTRING
	mov al,BYTE[str_len]
	mov BYTE[str1_len],al
	
got_str1:
	;;read second string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str2
	call READSTRING
	mov al,BYTE[str_len]
	mov BYTE[str2_len],al
	
	mov ecx,print
	mov edx,len_print
	call WRITE
	
	mov al,BYTE[str1_len]
	cmp al,BYTE[str2_len]
	je both
	ja first
	jb second
both:
	mov ecx,str1
	movzx edx,BYTE[str1_len]
	call WRITE
	
	call SPACE
	mov ecx,str2
	movzx edx,BYTE[str2_len]
	call WRITE
	call NEWLINE
	jmp exit
first:
	mov ecx,str1
	movzx edx,BYTE[str1_len]
	call WRITE
	call NEWLINE
	jmp exit
second:	
	mov ecx,str2
	movzx edx,BYTE[str2_len]
	call WRITE
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
SPACE:
	mov ecx,space
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
	
