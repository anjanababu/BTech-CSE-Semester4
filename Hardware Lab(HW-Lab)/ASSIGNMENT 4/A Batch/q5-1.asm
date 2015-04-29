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
	movzx eax,BYTE[str_len]
	add ebx,eax
	dec ebx ;points to the end of str
	mov edx,ebx;copy of end pos of each word
	
	mov ecx,str2
	mov al,BYTE[str_len]
	mov BYTE[temp],al
	
begin:
	mov edx,ebx
	
check:
	cmp BYTE[temp],0
	je copy
	cmp BYTE[ebx],32
	jne next
	push ebx
	jmp copy
next:
	dec ebx
	dec BYTE[temp]
	jmp check
copy:
	inc ebx
	cmp edx,ebx
	jnb dothis
	cmp BYTE[temp],0
	je over
	mov BYTE[ecx],32
	inc ecx
	inc BYTE[str2_len]
	pop ebx
	dec ebx
	dec BYTE[temp]
	jmp begin
dothis:
	mov al,BYTE[ebx]
	mov BYTE[ecx],al
	
	inc ecx
	inc BYTE[str2_len]
	jmp copy

over:
	mov ecx,result
	mov edx,len_result
	call WRITE
	
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
