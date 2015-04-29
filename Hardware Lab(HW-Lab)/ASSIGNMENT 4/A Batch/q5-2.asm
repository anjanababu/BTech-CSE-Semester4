;Program to Reverse every Word of given String 
section .data
	enter: db "Enter the string 			:	"
	len_enter: equ $-enter
	result: db "String after reversing words		:	"
	len_result: equ $-result
	blank: db 10

	str_len: db 0
	str2_len: db 0
	last: db 0
section .bss
	str: resb 100
	str2: resb 200
	char: resb 1
	temp: resb 1
	temp1: resb 1
section .text
	global _start:
_start:

reading:
	;;read string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str
	call READSTRING

	mov ebx,str
	
	mov al,BYTE[str_len]
	mov BYTE[temp],al
	
start_get_word:
	mov edx,ebx
get_word:
	dec BYTE[temp]
	
	cmp BYTE[temp],0
	je swap_entire
	
	cmp BYTE[ebx],32
	je swap_entire
	
	inc ebx
	jmp get_word
	
swap_entire:
	push ebx
	cmp BYTE[ebx],32
	jne swap
	dec ebx
swap:
	cmp edx,ebx
	jnb swap_over
	
	mov al,BYTE[edx]
	mov cl,BYTE[ebx]
	mov BYTE[ebx],al
	mov BYTE[edx],cl
	
	inc edx
	dec ebx
	jmp swap
swap_over:
	pop ebx
	
	cmp BYTE[temp],0
	je print_string
	inc ebx
	jmp start_get_word	

print_string:
	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov ecx,str
	movzx edx,BYTE[str_len]
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
