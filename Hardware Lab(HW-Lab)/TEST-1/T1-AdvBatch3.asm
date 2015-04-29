;Input an array and a and b and check whether a+b,a-b,a*b are present or not
section .data
	msg1: db "Enter the number of elements of the array 	:	 "
	lenmsg1: equ $-msg1
	msg2: db "Enter the elements of the array",10
	lenmsg2: equ $-msg2
	entera: db "a	=	"
	lenentera: equ $-entera
	enterb: db "b	=	"
	lenenterb: equ $-enterb
	s1: db "a+b	:	"
	lens1: equ $-s1
	s2: db "a-b	:	"
	lens2: equ $-s2
	s3: db "a*b	:	"
	lens3: equ $-s3
	pre: db "Present",10
	lenpre: equ $-pre
	notpre: db "Not Present",10
	lennotpre: equ $-notpre
	newline: db 10
section .bss
	number: resd 1
	digit: resb 1
	string: resb 10
	stringlen: resb 1

	array: resd 100
	limit: resd 1
	temp: resd 1
	prev: resd 1
	a: resd 1
	b: resd 1
section .txt
	global _start:
_start:
	
	mov ecx,msg1
	mov edx,lenmsg1
	call WRITE

	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[limit],eax
	
	cmp DWORD[limit],0
	ja continue
	jmp exit
continue:
	mov ecx,msg2
	mov edx,lenmsg2
	call WRITE

	mov ebx,array
	call GETARRAY
	
	mov ecx,entera
	mov edx,lenentera
	call WRITE
	
	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[a],eax
	
	mov ecx,enterb
	mov edx,lenenterb
	call WRITE
	
	call GETNUMBER
	mov eax,DWORD[number]
	mov DWORD[b],eax
	;;;;;;;;;;;;;;;;;a+b
	mov ecx,s1
	mov edx,lens1
	call WRITE
	
	call SETTEMP
	mov eax,DWORD[a]
	add eax,DWORD[b]
	
	call SEARCH
	;;;;;;;;;;;;;;;;;a-b
	mov ecx,s2
	mov edx,lens2
	call WRITE
	
	call SETTEMP
	mov eax,DWORD[a]
	sub eax,DWORD[b]
	call SEARCH
	;;;;;;;;;;;;;;;;;a*b
	mov ecx,s3
	mov edx,lens3
	call WRITE
	
	call SETTEMP
	mov eax,DWORD[a]
	mul DWORD[b]
	call SEARCH
	
	jmp exit
;;SUBROUTINES
SEARCH:
	mov ebx,array
search:
	cmp eax,DWORD[ebx]
	je setflag
	dec DWORD[temp]
	cmp DWORD[temp],0
	jne proceed
	mov ecx,notpre
	mov edx,lennotpre
	call WRITE
	call NEWLINE
	ret
proceed:
	add ebx,4
	jmp search
setflag:
	mov ecx,pre
	mov edx,lenpre
	call WRITE
	call NEWLINE
	ret
	
GETNUMBER:
	mov DWORD[number],0
get_digit:
	mov ecx,digit
	mov edx,1
	call READ

	cmp BYTE[digit],10
	jne carry_on
	ret
carry_on:
	sub BYTE[digit],30h
	mov eax,DWORD[number] 	
	mov ebx,10
	mul ebx

	movzx ebx,BYTE[digit]
	add eax,ebx
	mov DWORD[number],eax
	jmp get_digit

GETARRAY:
	call SETTEMP
		
get_element:
	push ebx
	call GETNUMBER

	mov eax,DWORD[number]
	pop ebx
	mov DWORD[ebx],eax
	
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja get_ready
	ret
get_ready:
	add ebx,4
	jmp get_element
		
	
READ:
	mov eax,3
	mov ebx,0
	int 80h
	ret

WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret
exit:
	mov eax,1
	mov ebx,0
	int 80h
SETTEMP:
	mov edx,DWORD[limit]
	mov DWORD[temp],edx
	ret
NEWLINE:
	mov ecx,newline
	mov edx,1
	call WRITE
	ret