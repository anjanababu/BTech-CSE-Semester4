;Check whether a number is prime using procedure.
section .data
	enter: db "Enter the number	:	"
	len_enter: equ $-enter
	
	yes: db "YES....The number is prime",10
	len_yes: equ $-yes
	
	no: db "NO...The number is not prime",10
	len_no: equ $-no
	
	blank: db 10
	space: db 32
	flag: db 1
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1
	
	limit: resd 1
section .text
	global _start:
_start:
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	call GETANYNUMBER

	mov ebx,DWORD[number]
	call CHECK_PRIME
	
	cmp BYTE[flag],1
	je print_yes
	jmp print_no
	
print_yes:
	mov ecx,yes
	mov edx,len_yes
	call WRITE
	jmp exit	
print_no:
	mov ecx,no
	mov edx,len_no
	call WRITE
	jmp exit
	
exit:
	mov eax,1
	mov ebx,0
	int 80h

	;ebx-number
CHECK_PRIME:
	cmp ebx,1
	jna no_flag
	cmp ebx,2
	je check_prime_done
	
	mov edx,0
	push ebx
	mov eax,ebx
	mov ebx,2
	div ebx
	pop ebx
	
	mov DWORD[limit],eax
	mov ecx,2
check_prime_loop:
	cmp ecx,DWORD[limit]
	ja check_prime_done
	
	mov edx,0
	mov eax,ebx
	div ecx
	cmp edx,0
	je no_flag
	
	inc ecx
	jmp check_prime_loop
no_flag:
	mov BYTE[flag],0
check_prime_done:
	ret

	



	;result in number
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