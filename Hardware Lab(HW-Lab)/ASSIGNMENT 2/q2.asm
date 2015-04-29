;Write a program to merge 2 arrays
section .data
	msglimit1: db "No. of elements in array1 : "
	lenmsglimit1: equ $-msglimit1
	msgenter1: db "Enter the elements of array1",10
	lenmsgenter1: equ $-msgenter1
	msglimit2: db "No. of elements in array2 : "
	lenmsglimit2: equ $-msglimit2
	msgenter2: db "Enter the elements of array2",10
	lenmsgenter2: equ $-msgenter2
	result: db "Resulting Array",10
	lenresult: equ $-result
	newline: db 10
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	;a digit
	string: resb 10 
        stringlen: resb 1
	
	array1: resd 200
	array2: resd 200
	limit1: resd 1
	limit2: resd 1
	temp: resd 1
section .text
	global _start:
_start:

	;get array1
	mov ecx,msglimit1
	mov edx,lenmsglimit1
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[limit1],eax
	mov DWORD[temp],eax 
	
	cmp DWORD[limit1],0
	je skipnull                        ;dont input array1
	
	mov ebx,array1
	call GETARRAY
	
skipnull:
	;get array2
	mov ecx,msglimit2
	mov edx,lenmsglimit2
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[limit2],eax
	mov DWORD[temp],eax       
	
	cmp DWORD[limit2],0
	je printfirstarrayonly                  
	
	mov ebx,array2
	call GETARRAY

	;copying array2 to array1
	mov eax,DWORD[limit2]
	mov DWORD[temp],eax
	
	mov eax,DWORD[limit1]
	mov ebx,4
	mul ebx
	mov ebx,array1
	add ebx,eax       ;JUST COPY eax
	mov ecx,array2
	
copy:
	pusha

	mov eax,DWORD[ecx]
	mov DWORD[ebx],eax
	
	popa
	
	add ebx,4
	add ecx,4
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja copy
	
	;merging over nw print the merged array
	mov ecx,result
	mov edx,lenresult
	call WRITE
	
	mov eax,DWORD[limit1]
	add eax,DWORD[limit2]
	mov DWORD[temp],eax
	mov ebx,array1
print:
	push ebx
	
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	pop ebx
	
	add ebx,4
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja print
	
	jmp exit
	
printfirstarrayonly:
	cmp DWORD[limit1],0
	je exit	
	mov eax,DWORD[limit1]
	mov DWORD[temp],eax
	mov ebx,array1
dothis:
	push ebx
	
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	pop ebx
	add ebx,4
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja dothis
	
	jmp exit
	
;;;;;;;SUB PROGRAMS
GETARRAY:
readelement:
	push ebx
	
	call GETANYNUMBER
	mov eax,DWORD[number]

	pop ebx
	mov DWORD[ebx],eax
	
	add ebx,4
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja readelement
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
	
exit:
	mov eax,1
	mov ebx,0
	int 80h



 
