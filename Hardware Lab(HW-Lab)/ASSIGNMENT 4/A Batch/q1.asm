;Write a program to read a matrix and check whether it is identity matrix
section .data
	msgrow: db "No. of rows in matrix	 : "
	lenmsgrow: equ $-msgrow
	msgcol: db "No. of columns in matrix : "
	lenmsgcol: equ $-msgcol
	msgenter: db "Enter the elements of matrix",10
	lenmsgenter: equ $-msgenter
	mat: db "Matrix",10
	lenmat: equ $-mat

	msgno: db "NO!!!Its not an Identity Matrix",10
	lenmsgno: equ $-msgno
	msgyes: db "YES!!!Its an Identity Matrix",10
	lenmsgyes: equ $-msgyes
	sqmat: db "NO!!!Identity Matrix must be a SQUARE MATRIX",10
	lensqmat: equ $-sqmat

	space: db 32
	blank: db 10
	count: db 0
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	;a digit
	string: resb 10 
        stringlen: resb 1
	
	matrix: resd 100
	row: resd 1
	col: resd 1

	temp: resd 1
	
	i:resd 1
	j: resd 1
section .text
	global _start:
_start:

	;get matrix
	mov ecx,msgrow
	mov edx,lenmsgrow
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[row],eax      
	
	cmp DWORD[row],0
	je exit
	
	mov ecx,msgcol
	mov edx,lenmsgcol
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[col],eax  
	
	cmp DWORD[col],0
	je exit
	
	mov eax,DWORD[row]
	mov ecx,DWORD[col]
	cmp eax,ecx
	jne nosquaremat
	mul ecx
	mov DWORD[temp],eax
	
	mov ebx,matrix
	call GETMATRIX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Got the matrix
	mov ecx,mat
	mov edx,lenmat
	call WRITE
	
	mov ebx,matrix
	call DISPLAYMATRIX
	;..........................
	mov ebx,matrix
	mov BYTE[i],0
i_loop:
	inc DWORD[i]
	mov BYTE[j],0
	mov eax,DWORD[col]
	cmp DWORD[i],eax
	ja printyes
j_loop:
	inc DWORD[j]
	mov eax,DWORD[row]
	cmp DWORD[j],eax
	ja i_loop
	
	mov eax,DWORD[i]
	cmp eax,DWORD[j]
	jne inotj
	
	cmp DWORD[ebx],1
	jne printno
	add ebx,4
	jmp j_loop
inotj:
	cmp DWORD[ebx],0
	jne printno
	add ebx,4
	jmp j_loop

printyes:
	mov ecx,msgyes
	mov edx,lenmsgyes
	call WRITE	
	jmp exit
printno:
	mov ecx,msgno
	mov edx,lenmsgno
	call WRITE
	jmp exit
nosquaremat:
	mov ecx,sqmat
	mov edx,lensqmat
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
NEWLINE:
	mov ecx,blank
	mov edx,1
	call WRITE
	ret
SPACE:
	mov ecx,space
	mov edx,1
	call WRITE
	ret
exit:
	mov eax,1
	mov ebx,0
	int 80h

DISPLAYMATRIX:
	mov eax,DWORD[row]
	mov ecx,DWORD[col]
	mul ecx
	mov DWORD[temp],eax
	mov DWORD[count],0
nextnum:
	cmp DWORD[temp],0
	jne doo
	ret
doo:
	push ebx
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	inc DWORD[count]
	mov eax,DWORD[col]
	cmp DWORD[count],eax
	jne skipnewline
	call NEWLINE
	mov DWORD[count],0
	jmp ready
skipnewline:
	call SPACE
ready:
	pop ebx
	dec DWORD[temp]
	add ebx,4
	jmp nextnum
