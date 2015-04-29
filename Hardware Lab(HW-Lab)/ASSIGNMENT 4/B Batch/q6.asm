;Write a Program to Find the Largest & Smallest Word in a String(lexically)
section .data
	enter: db "Enter the string :  "
	len_enter: equ $-enter
	resultsmall: db "Smallest word 	 :  "
	len_resultsmall: equ $-resultsmall
	resultlar: db "Largest word 	 :  "
	len_resultlar: equ $-resultlar
	blank: db 10
	space: db 32
	str_len:db 0
section .bss
	number: resd 1
	digit: resb 1
	
	char: resb 1
	
	strings: resb 100000
	tempstring: resb 100
	numstr: resd 1
	
	str1: resb 1000
section .text
	global _start:
_start:

reading:
	;;read first string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str1
	call READSTRING
	mov BYTE[ebx],0
	
	;;extact words and store to strings array
	mov eax,strings
	mov DWORD[numstr],0
	
	mov ebx,str1
	call EXTRACTWORDS
	
	;;bubblesortstrings
	mov eax, strings
	mov ebx, 100
	mov ecx, DWORD[numstr]
	call STRBUBBLESORT
	
	;;print strings in sorted order
	mov ecx, resultsmall
	mov edx, len_resultsmall
	call WRITE
   
	mov eax, strings
	call PRINTS
	call NEWLINE
	
	mov ecx, resultlar
	mov edx, len_resultlar
	call WRITE
	
	mov eax,DWORD[numstr]
	dec eax
	mov ebx,100
	mul ebx
	mov edx,eax
	mov eax,strings
	add eax,edx
	call PRINTS
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
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;STRING FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;STRLEN
;;;;;;;;;;;;;;;;;;;;;;;;STRCPY
;;;;;;;;;;;;;;;;;;;;;;;;STRCAT
;;;;;;;;;;;;;;;;;;;;;;;;STRCMP

	;eax-base address of a string
	;returns value in eax
STRLEN:
	mov ecx,0
str_len_calculate_loop:
	cmp BYTE[eax],0
	je got_strlen
	
	inc ecx
	inc eax
	jmp str_len_calculate_loop
got_strlen:
	mov eax,ecx
	ret
	
	;copies a string from one location to another(not swapping)
	;eax-destination 
	;ebx-source
STRCPY:
	mov dl,BYTE[ebx]
	mov BYTE[eax],dl
	
	cmp BYTE[eax],0
	je strcpy_done
	
	inc eax
	inc ebx
	jmp STRCPY
strcpy_done:
	ret

	;concantanates two strings.
	;eax-string1
	;ebx-string2
STRCAT:
	push eax
	call STRLEN
	pop eax
	add eax,ecx ;nw points to the location where the sec string is to be copied
strcat_loop:
	mov cl,BYTE[ebx]
	mov BYTE[eax],cl
	
	cmp cl,0
	je strcat_done
	
	inc eax
	inc ebx
	jmp strcat_loop
strcat_done:
	ret  
	
	;compares two given strings.
	;eax - str1, ebx - str2
	;Return value - eax
	;> 256 if the first string is larger,
	;256 if both strings are similar,
	;< 256 otherwise.
STRCMP:
	movzx ecx,BYTE[eax]
	movzx edx,BYTE[ebx]
	
	;formula 256+c1-c2
	;min value =1 (256+0-255) thats positive
	add ecx,256
	sub ecx,edx
	
	cmp ecx,256
	jne strcmp_done
	
	cmp edx,0
	je strcmp_done ;if both strings equal...termination condition
	
	inc eax
	inc ebx
	jmp STRCMP
strcmp_done:
	mov eax,ecx ;retiurns a val depending on which v can compare
	ret

STRBUBBLESORT:
	;eax - base adress of string array.
	;ebx - size of each string
	;ecx - number of strings to sort.
	mov edx,0
str_bubble_sort_loop:
	cmp edx,ecx
	je str_bubble_sort_done
	
	pusha
	sub ecx,edx
	call STRBUBBLEUP
	popa
	
	inc edx
	jmp str_bubble_sort_loop
str_bubble_sort_done:
	ret

STRBUBBLEUP:
	;Bubbles up the largest element of the array to the last element.
	;eax = base address of the array
	;ebx = string size
	;ecx = number of elements
	dec ecx
	mov edx,0
str_bubbleup_loop:
	cmp ecx,edx
	je str_bubble_up_done
	
	pusha
	add ebx,eax
	call STRCMP
	cmp eax,256
	popa
	
	jbe no_swap_or_increment
	
	pusha

	add ebx,eax
	
	push eax
	push ebx
	mov ebx,eax
	mov eax,tempstring
	call STRCPY
	pop ebx
	pop eax
	
	push eax
	push ebx
	call STRCPY
	pop ebx
	pop eax
	
	push eax
	push ebx
	mov eax,ebx
	mov ebx,tempstring
	call STRCPY
	pop ebx
	pop eax
	
	popa
	
no_swap_or_increment:
	inc edx
	add eax,100
	jmp str_bubbleup_loop
str_bubble_up_done:
	ret
	
	;Prints a string to the standard output.
	;Provide the string in eax.  
PRINTS:
	push eax
	call STRLEN
	mov edx,eax
	pop eax
	
	mov ecx,eax
	call WRITE
	ret
EXTRACTWORDS:
	push eax
copy_word:
	cmp BYTE[ebx],32
	je next_word
	cmp BYTE[ebx],0
	je next_word
	
	mov cl,BYTE[ebx]
	mov BYTE[eax],cl
	inc eax
	inc ebx
	jmp copy_word
next_word:
	inc DWORD[numstr]
	cmp BYTE[ebx],0
	jne incrementby
	mov BYTE[eax],0
	pop eax
	add eax,100
	ret
	incrementby:
		pop eax
		add eax,100
		inc ebx
		jmp EXTRACTWORDS
SPACE:
	mov ecx,space
	mov edx,1
	call WRITE
	ret
	
	
