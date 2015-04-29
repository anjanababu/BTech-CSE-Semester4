;Program to Sort Elements in Length Order.
section .data
	hwmany: db "Enter the number of stings : 	"
	lenhwmany: equ $-hwmany
	enter: db "Enter the strings",10
	len_enter: equ $-enter
	result: db "String after sorting",10
	len_result: equ $-result
	blank: db 10
section .bss
	number: resd 1
	digit: resb 1
	
	strings: resb 100000
	tempstring: resb 100
	numstr: resd 1

	templen1: resd 1
	templen2: resd 1
section .text
	global _start:
_start:

reading:
	;;get the number of strings-numstr
	mov ecx,hwmany
	mov edx,lenhwmany
	call WRITE
	
	call GETANYNUMBER
	mov eax,DWORD[number]
	mov DWORD[numstr],eax
	cmp DWORD[numstr],0
	je exit
	;;read string-strings
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov eax,strings
	mov ecx,DWORD[numstr]
	call READSTRINGS
	
	;;bubblesortstrings
	mov eax, strings
	mov ebx, 100
	mov ecx, DWORD[numstr]
	call STRBUBBLESORT
	
	;;print strings in sorted order
	mov ecx, result
	mov edx, len_result
	call WRITE
   
	mov eax, strings
	mov ecx, DWORD[numstr]
	call PRINTSTRINGS

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

	;eax-base address of "strings" array
	;ecx-"numstr"
READSTRINGS:	
	mov edx,0 ;keep track of hw many words inputted
get_string:
	cmp edx,ecx
	je got_strings
	
	pusha
	call READWORD
	popa
	
	inc edx
	add eax,100
	jmp get_string
got_strings:
	ret	
READWORD: ;only eax need to be preserved
	push eax
	mov ecx,eax
	mov edx,1
	call READ
	pop eax
	
	cmp BYTE[ecx],10
	je got_word
	
	inc eax
	jmp READWORD
got_word:
	mov BYTE[eax],0 ;explicitly putting a null character at the end
	ret	
	
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
;length
	push eax
	call STRLEN
	mov DWORD[templen1],eax	
	pop eax

	push eax
	push ebx	
	mov eax,ebx
	call STRLEN
	mov DWORD[templen2],eax
	pop ebx
	pop eax
	
	mov eax,DWORD[templen1]
	cmp eax,DWORD[templen2]
	ja set_one
	mov eax,0
	ret
set_one:
	mov eax,1
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
	cmp eax,0
	popa
	
	je no_swap_or_increment
	
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

	;eax - Base address of the array
	;ecx - number of strings to print
PRINTSTRINGS:
	mov edx,0
print_strings_loop:
	cmp edx,ecx
	je print_strings_done
	
	pusha
	call PRINTS
	call NEWLINE
	popa
	
	inc edx
	add eax,100
	jmp print_strings_loop
print_strings_done:
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

GETANYNUMBER:
	mov DWORD[number],0
  getnumber:
	mov ecx,digit
	mov edx,1
	call READ

	cmp BYTE[digit],10                 ;is digit=newline
	jne carryon
	ret			   	   ;got the n digit number
  carryon:				   ;to change number from ascii
	sub byte[digit],30h
	mov eax,DWORD[number]
	mov ebx,10
	mul ebx
	
	movzx ebx,byte[digit]
	add eax,ebx
	mov DWORD[number],eax
	jmp getnumber

