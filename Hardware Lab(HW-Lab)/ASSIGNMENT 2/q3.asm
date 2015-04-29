;Identify the median of an array of elements of length n using bubble sort.
section .data
	msglimit: db "No. of elements in array : "
	lenmsglimit: equ $-msglimit
	msgenter: db "Enter the elements of array",10
	lenmsgenter: equ $-msgenter
	result: db "MEDIAN = "
	lenresult: equ $-result
	extra: db ".5",10
	lenextra: equ $-extra
	newline: db 10
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	;a digit
	string: resb 10 
        stringlen: resb 1

	array: resd 100
	limit: resd 1
	temp: resd 1
	counter1: resd 1
	counter2: resd 1
section .text
	global _start:
_start:

	;get array
	mov ecx,msglimit
	mov edx,lenmsglimit
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[limit],eax

	cmp DWORD[limit],0
	je exit                                   ;if 0 elements exit
	
	mov ecx,msgenter
	mov edx,lenmsgenter
	call WRITE
	
	call SETTEMP
	mov ebx,array
	call GETARRAY
	
	;bubblesort
	mov ebx,array  ;main pointer
	mov ecx,array  ;sub pointer
	
	mov eax,DWORD[limit]
	mov DWORD[counter1],eax
	mov DWORD[counter2],eax
bubble:
	mov eax,DWORD[ebx]
	cmp eax,DWORD[ecx]
	jna skip
	call SWAP
skip:
	add ecx,4
	dec DWORD[counter2]
	cmp DWORD[counter2],0
	je setsecpointer
	jmp bubble
setsecpointer:
	add ebx,4
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je sortovercheck
	mov eax,DWORD[counter1],
	mov DWORD[counter2],eax
	mov ecx,ebx
	jmp bubble
	
sortovercheck:         
	mov ecx,result
	mov edx,lenresult
	call WRITE
	
	mov eax,DWORD[limit]  ;checking whether n is odd or even
	mov ebx,eax	
	and ebx,1
	cmp ebx,0
	je evenprint 
	
	sub eax,1
	call FINDHALF
	mov ebx,4
	mul ebx
	mov ebx,array
	add ebx,eax   ;		;;nw ebx points to the crt location
oddprint:
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	jmp exit
evenprint:
	call FINDHALF
	mov ebx,4
	mul ebx
	mov ebx,array
	add ebx,eax        ;;;if array was 1 2 3 4 nw points to 3 

	;;;add the 2 middle terms   
	mov eax,DWORD[ebx]
	sub ebx,4                
	mov edx,DWORD[ebx]
	add eax,edx
	
	call FINDHALF
	
	cmp edx,0        
	jne pointfive     

	call DISPLAYNUMBER ;eax has the result
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	jmp exit
pointfive:
	call DISPLAYNUMBER
	mov ecx,extra
	mov edx,lenextra
	call WRITE
	jmp exit
	
;;;;;;;SUB PROGRAMS
FINDHALF:
	mov edx, 0
	mov ebx,2
	div ebx
	ret
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

SETTEMP:
	mov eax,DWORD[limit]
	mov DWORD[temp],eax
	ret
SWAP:
	mov eax,DWORD[ebx]
	mov edx,DWORD[ecx]
	mov DWORD[ebx],edx
	mov DWORD[ecx],eax
	ret
