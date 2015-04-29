section .data
	enter1: db "Enter the string			: 	"
	len_enter1: equ $-enter1
	
	result: db "New String(Copy of the previous)	:	"
	len_result: equ $-result
	
	blank: db 10
	space: db 32
section .bss
	string1: resb 100
	string2: resb 100
	
	str_len: resd 1
	str1_len: resd 1
	str2_len: resd 1
	
	char: resb 1
section .text
	global _start:
_start:
	mov ecx,enter1
	mov edx,len_enter1
	call WRITE
	
	mov ebx,string1
	call STRREAD
	
	mov eax,DWORD[str_len]
	mov DWORD[str2_len],eax
	
	mov ebx,string1
	mov ecx,string2
	call STRCPY
	mov BYTE[ecx],0
	
	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov ecx,string2
	mov edx,DWORD[str2_len]
	call WRITE
	
	call NEWLINE
	
exit:
	mov eax,1
	mov ebx,0
	int 80h
	
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
STRREAD:
	;ebx-points to base address of string
	;string assumed to terminate with 0
	;stringlen is the exact length
	mov DWORD[str_len],0
read_loop:
	push ebx
	
	mov ecx,char
	mov edx,1
	call READ
	
	pop ebx
	
	cmp BYTE[char],10
	je read_loop_done
	
	mov al,BYTE[char]
	mov BYTE[ebx],al
	
	inc DWORD[str_len]
	inc ebx
	jmp read_loop
read_loop_done:
	mov BYTE[ebx],0
	ret

	;ebx-points to base address of the source string
	;ecx-points to base address of the destination string
STRCPY:
	
	mov al,BYTE[ebx]
	mov BYTE[ecx],al
	
	
	cmp BYTE[ebx],0
	je strcpy_done
	
	inc ebx
	inc ecx
	call STRCPY
strcpy_done:
	ret
