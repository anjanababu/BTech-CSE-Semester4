;Write a program to find first capital letter in a string using recursion
section .data
	enter: db "Enter the string 		:	"
	len_enter: equ $-enter
	result: db "First capital letter		:	"
	len_result: equ $-result
	no: db "NO capitals"
	lenno: equ $-no	
	blank: db 10
	str_len: db 0
section .bss
	str: resb 100
	char: resb 1
	temp: resb 1
	temp1: resb 1
	len: resb 1
section .text
	global _start:
_start:

	;;read string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str
	call READSTRING
	
	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov ebx,str
	call CAPITAL

	cmp eax,0
	je no_caps

	mov ecx,eax
	mov edx,1
	call WRITE
	call NEWLINE
	jmp exit
no_caps:
	mov ecx,no
	mov edx,lenno
	call WRITE 
	call NEWLINE
exit:
	mov eax,1
	mov ebx,0
	int 80h
;SUBROUTINES
	
CAPITAL:
	cmp BYTE[ebx],0
	jne next1
	mov eax,0
	jmp capital_finding_done
next1:
	cmp BYTE[ebx],'A'
	jb next
	cmp BYTE[ebx],'Z'
	ja next
	mov eax,ebx
	jmp capital_finding_done
	
next:
	inc ebx
	call CAPITAL
capital_finding_done:
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
	mov BYTE[ebx],0
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
