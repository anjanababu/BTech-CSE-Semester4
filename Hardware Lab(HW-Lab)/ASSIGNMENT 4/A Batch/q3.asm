;Program to Remove all Characters in a String except alphabet
section .data
	enter: db "Enter the string 		:	"
	len_enter: equ $-enter
	result: db "Only alphabets strings		:	"
	len_result: equ $-result
	blank: db 10

	str_len: db 0
section .bss
	str: resb 100
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
	
removing:
	mov ebx,str
	mov al,BYTE[str_len]
	mov BYTE[temp],al	
begin:
	cmp BYTE[temp],0
	je over
check_for_capitals:
	cmp BYTE[ebx],'A'
	jnb ub_caps
	push ebx
	call SHIFT
	pop ebx
	dec BYTE[temp]
	jmp begin
	
ub_caps:
	cmp BYTE[ebx],'Z'
	jna next_char
	cmp BYTE[ebx],'a'
	jnb ub_small
	push ebx
	call SHIFT
	pop ebx
	dec BYTE[temp]
	jmp begin
ub_small:
	cmp BYTE[ebx],'z'
	jna next_char
	push ebx
	call SHIFT
	pop ebx
	dec BYTE[temp]
	jmp begin
	
next_char:
	inc ebx
	dec BYTE[temp]
	jmp begin
	
over:
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
	
SHIFT:
	dec BYTE[str_len]
	
	mov al,BYTE[temp]
	mov BYTE[temp1],al
process:
	cmp BYTE[temp1],0
	jne do 
	ret
do:
	mov al,BYTE[ebx+1]
	mov BYTE[ebx],al
	inc ebx
	dec BYTE[temp1]
	jmp process
