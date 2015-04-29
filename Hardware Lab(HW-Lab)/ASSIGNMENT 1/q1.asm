;Read a key stroke and report whether caps lock is on.

section .data
	message1: db "Enter a key stroke",0Ah
	size1: equ $-message1
	message2: db "CapsLock is ON",0Ah
	size2: equ $-message2
	message3: db "CapsLock is OFF",0Ah
	size3: equ $-message3
	errormsg: db "Enter an alphabet",0Ah
	size: equ $-errormsg

section .bss
	key: resb 1
section .text
	global _start:
_start:

	mov eax,4
	mov ebx,1
	mov ecx,message1
	mov edx,size1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,key
	mov edx,1
	int 80h
	
	cmp byte[key],65
	jnb nextcheck
	jmp error

printoff:
	mov eax,4
	mov ebx,1
	mov ecx,message3
	mov edx,size3
	int 80h

	jmp exit

nextcheck:
	cmp byte[key],90
	jna printon
	cmp byte[key],97
	jb notcharactercheck
	cmp byte[key],122
	ja notcharactercheck
	jmp printoff
	
printon:	
	mov eax,4
	mov ebx,1
	mov ecx,message2
	mov edx,size2
	int 80h
	jmp exit
	
exit:
	mov eax,1
	mov ebx,0
	int 80h
error: 
	mov eax,4
	mov ebx,1
	mov ecx,errormsg
	mov edx,size
	int 80h
	jmp exit

notcharactercheck:
	cmp byte[key],97
	jna error
	cmp byte[key],123
	jnb error
	jmp exit
	


