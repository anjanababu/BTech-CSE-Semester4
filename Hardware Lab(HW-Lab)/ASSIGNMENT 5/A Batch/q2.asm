;Read 10 numbers and calculates the average using subroutine
section .data
	enter: db "Enter the 10 number",10
	len_enter: equ $-enter
	
	result: db "Average of these 10 numbers    =      	"
	len_result: equ $-result
	
	blank: db 10
	space: db 32
	dot: db 46
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	  ;a digit
	string: resb 10 
        stringlen: resb 1
	
	array:resd 100
	array_size: resd 1
	average: resd 1
	sum: resd 1
	remainder: resd 1
section .text
	global _start:
_start:
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov DWORD[array_size],10
	
	mov ebx,array
	mov ecx,DWORD[array_size]
	call GETNUMBERS

	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov ebx,array
	mov ecx,DWORD[array_size]
	call GET_AVERAGE	
	
	
	mov eax,DWORD[average]
	call DISPLAYNUMBER
	
	call DOT
	
	mov eax,DWORD[remainder]
	call DISPLAYNUMBER
	
	call NEWLINE
exit:
	mov eax,1
	mov ebx,0
	int 80h
	
		
	;ebx-array
	;ecx-array_size
	;average-result
	;remainder-decimal part
GET_AVERAGE:
	mov DWORD[sum],0
calculate_sum_loop:
	cmp ecx,0
	je got_sum
	
	dec ecx
	
	push ecx
	mov eax,DWORD[sum]
	mov ecx,DWORD[ebx]
	add eax,ecx
	pop ecx
	
	mov DWORD[sum],eax
	add ebx,4
	jmp calculate_sum_loop
got_sum:
	mov edx,0
	mov eax,DWORD[sum]
	mov ebx,DWORD[array_size]
	div ebx
	mov DWORD[average],eax
	mov DWORD[remainder],edx
	ret	
		
	;ebx-points to base address of array
	;ecx-array_size
GETNUMBERS:
	cmp ecx,0
	je read_numbers_done
read_numbers_loop:
	dec ecx
	
	pusha
	call GETANYNUMBER
	popa
	
	mov eax,DWORD[number]
	mov DWORD[ebx],eax
	
	add ebx,4
	call GETNUMBERS
read_numbers_done:
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

	;eax-number to be displayed
DISPLAYNUMBER:
  	mov BYTE[stringlen], 0
  	mov ebx, string
  	add ebx, 9           ;pointing to end of string
   convert_number:
	mov edx, 0
  	mov ecx, 10
  	div ecx
  
 	mov BYTE[ebx], dl
	add BYTE[ebx], 48  ;coverting the got digit to ascii equivalent
  
  	inc BYTE[stringlen]
  	cmp eax, 0
  	je convert_done
  	dec ebx
  	jmp convert_number
  convert_done:
  	mov ecx, ebx
  	movzx edx, BYTE[stringlen]
  	call WRITE
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
DOT:
	mov ecx,dot
	mov edx,1
	call WRITE
	ret
	