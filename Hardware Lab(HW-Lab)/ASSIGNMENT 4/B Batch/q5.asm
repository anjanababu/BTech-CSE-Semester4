;Write a Program to Search a Word & Replace it with the Specified Word
section .data
	enter1: db "Enter the string 	:	"
	len_enter1: equ $-enter1
	enterword1: db "Replace 		:	"
	len_enterword1: equ $-enterword1
	enterword2: db "With	:	"
	len_enterword2: equ $-enterword2
	result: db "String after replacing	: 	"
	len_result: equ $-result
	blank: db 10

	str_len: db 0
	strold_len: db 0
	strnew_len: db 0
section .bss
	str1: resb 200
	str2: resb 200

	w1: resb 20
	w1_len: resb 1
	w2: resb 20

	char: resb 1
	temp: resb 1
	count: resb 1
section .text
	global _start:
_start:

reading:
	;;read string
	mov ecx,enter1
	mov edx,len_enter1
	call WRITE
	
	mov ebx,str1
	call READSTRING
	mov al,BYTE[str_len]
	mov BYTE[strold_len],al
	
	;;read first word
	mov ecx,enterword1
	mov edx,len_enterword1
	call WRITE
	
	mov ebx,w1
	call READSTRING
	mov al,BYTE[str_len]
	mov BYTE[w1_len],al
	mov BYTE[ebx],0
	
	;;read second word
	mov ecx,enterword2
	mov edx,len_enterword2
	call WRITE
	
	mov ebx,w2
	call READSTRING
	mov BYTE[ebx],0
	
	mov ebx,str1
	mov ecx,w1
	mov edx,str2
	
	mov al,BYTE[strold_len]
	mov BYTE[temp],al
	mov BYTE[count],0
copying_to_new:
	cmp BYTE[temp],0
	je over
	
	dec BYTE[temp]
	
	mov al,BYTE[ebx]
	mov BYTE[edx],al
	inc BYTE[strnew_len]
	
	cmp al,BYTE[ecx]
	jne no_match
	
	inc BYTE[count]
	mov al,BYTE[count]
	cmp al,BYTE[w1_len]
	jne count_not_reached	
	
	cmp BYTE[ebx+1],32
	je replace_word
	cmp BYTE[temp],0
	je replace_word
	jmp no_match
count_not_reached:	
	inc ebx
	inc ecx
	inc edx
	jmp copying_to_new
replace_word:
	movzx eax,BYTE[w1_len]
	dec eax
	sub edx,eax
	
	mov al,BYTE[strnew_len]
	push ebx
	mov bl,BYTE[w1_len]
	sub al,bl
	mov BYTE[strnew_len],al
	pop ebx
	
	push ebx
	mov ebx,w2
	replacing:
		cmp BYTE[ebx],0
		je done_replacing
	
		mov al,BYTE[ebx]
		mov BYTE[edx],al
		inc BYTE[strnew_len]
		inc ebx
		inc edx
		jmp replacing
	
		done_replacing:
			pop ebx
			inc ebx
			
			mov ecx,w1
			mov BYTE[count],0
			
			jmp copying_to_new
no_match:
	mov ecx,w1
	mov BYTE[count],0
	inc ebx
	inc edx
	jmp copying_to_new
	
over:
	mov ecx,str2
	movzx edx,BYTE[strnew_len]
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
	
