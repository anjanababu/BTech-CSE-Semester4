;Write a program to read two matrices A and B, and print |A-B|
section .data
	msgrow1: db "No. of rows in matrix1 : "
	lenmsgrow1: equ $-msgrow1
	msgcol1: db "No. of columns in matrix1 : "
	lenmsgcol1: equ $-msgcol1
	msgenter1: db "Enter the elements of matrix1",10
	lenmsgenter1: equ $-msgenter1
	msgrow2: db "No. of rows in matrix2 : "
	lenmsgrow2: equ $-msgrow2
	msgcol2: db "No. of columns in matrix2 : "
	lenmsgcol2: equ $-msgcol2
	msgenter2: db "Enter the elements of matrix2",10
	lenmsgenter2: equ $-msgenter2
	msgerror: db "Sorry!!!Matrices cannot be Subtracted",10
	lenmsgerror: equ $-msgerror
	result: db "Result of Subtraction",10
	lenresult: equ $-result
	space: db 32
	newline: db 10
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	;a digit
	string: resb 10 
        stringlen: resb 1
	
	matrix1: resd 100
	matrix2: resd 100
	row1: resd 1
	col1: resd 1
	row2: resd 1
	col2: resd 1
	temp: resd 1
	count: resd 1	
section .text
	global _start:
_start:

	;get matrix1
	mov ecx,msgrow1
	mov edx,lenmsgrow1
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[row1],eax      
	
	cmp DWORD[row1],0
	je error                                ;if 0 elements exit
	
	mov ecx,msgcol1
	mov edx,lenmsgcol1
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[col1],eax  
	
	cmp DWORD[col1],0
	je error                               ;if 0 elements exit
	
	mov eax,DWORD[row1]
	mov ecx,DWORD[col1]
	mul ecx
	mov DWORD[temp],eax
	
	mov ebx,matrix1
	call GETMATRIX
	
	;get matrix2
	mov ecx,msgrow2
	mov edx,lenmsgrow2
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[row2],eax
	
	cmp DWORD[row2],0
	je error                                ;if 0 elements exit
	
	mov ecx,msgcol2
	mov edx,lenmsgcol2
	call WRITE
	
	call GETANYNUMBER
	
	mov eax,DWORD[number]
	mov DWORD[col2],eax   
	
	cmp DWORD[col2],0
	je error                                ;if 0 elements exit
	
	mov eax,DWORD[row2]
	mov ecx,DWORD[col2]
	mul ecx
	mov DWORD[temp],eax
	
	mov ebx,matrix2
	call GETMATRIX
	
	;check if can be subtracted
	mov eax,DWORD[row1]
	cmp eax,DWORD[row2]
	jne error
	mov eax,DWORD[col1]
	cmp eax,DWORD[col2]
	jne error

	;subtracting matrices
	mov ecx,result
	mov edx,lenresult
	call WRITE
	
	mov eax,DWORD[row1]
	mov ecx,DWORD[col1]
	mul ecx
	mov DWORD[temp],eax
	
	mov ebx,matrix1
	mov ecx,matrix2
	mov DWORD[count],0
subtraction:
	pusha
	mov eax,DWORD[ebx]
	cmp eax,DWORD[ecx]
	jb doreverse
	sub eax,DWORD[ecx]
	jmp do
doreverse:			 ;interchange and subtract
	mov eax,DWORD[ecx]
	sub eax,DWORD[ebx]
do:
	call DISPLAYNUMBER
	
	inc DWORD[count]
	mov eax,DWORD[col1]
	cmp eax,DWORD[count]
	jne printspace
	
	mov ecx,newline
	mov edx,1
	call WRITE
	mov DWORD[count],0
	jmp skipnewline

printspace:
	mov ecx,space
	mov edx,1
	call WRITE
skipnewline:
	popa

	add ebx,4
	add ecx,4
	
	dec DWORD[temp]
	cmp DWORD[temp],0
	ja subtraction	
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	jmp exit

;;;;;;;SUB PROGRAMS
GETMATRIX:
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
error: 
	mov ecx,msgerror
	mov edx,lenmsgerror
        call WRITE
	jmp exit
	


 
