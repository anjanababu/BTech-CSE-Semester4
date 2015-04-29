;WAP to Determine if One String is a Circular Permutation of Another String 
section .data
	enter: db "Enter the string 	:	"
	len_enter: equ $-enter
	no: db "NO...String's are not circular permutation of each other"
	len_no: equ $-no
	yes: db "YES...String's are circular permutation of  each other"
	len_yes: equ $-yes
	blank: db 10

	str_len: db 0
	str1_len: db 0
	str2_len: db 0
section .bss
	str1: resb 100
	str2: resb 100
	char: resb 1
	temp: resb 1
section .text
	global _start:
_start:

	;;read a string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str1
	call READSTRING
	mov BYTE[ebx],0
	mov al,BYTE[str_len]
	mov BYTE[str1_len],al
got_str1:
	;;read a string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str2
	call READSTRING
	mov BYTE[ebx],0
	mov al,BYTE[str_len]
	mov BYTE[str2_len],al
got_str2:
	
	mov al,BYTE[str1_len]
	cmp al,BYTE[str2_len]
	jne not_circularperm
	
	mov ebx,str1
	mov edx,str2
	mov BYTE[temp],al
get_one_match:
	mov al,BYTE[ebx]
	cmp al,BYTE[edx]
	je check_for_circular
	
	dec BYTE[temp]
	cmp BYTE[temp],0
	je not_circularperm
	inc edx
	jmp get_one_match

check_for_circular:
	cmp BYTE[ebx],0
	je yes_circularperm
	
	inc ebx
	inc edx
	cmp BYTE[ebx],0
	je yes_circularperm
	
	cmp BYTE[edx],0
	jne check
	
	mov edx,str2
check:
	mov al,BYTE[ebx]
	cmp al,BYTE[edx]
	je check_for_circular
	
not_circularperm:
	mov ecx,no
	mov edx,len_no
	call WRITE
	call NEWLINE
	jmp exit
yes_circularperm:
	mov ecx,yes
	mov edx,len_yes
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
	
