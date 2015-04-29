;Write a program to read two matrices and multiply them.
section .data
	msgrow1: db "No. of rows in matrix A : "
	lenmsgrow1: equ $-msgrow1
	msgcol1: db "No. of columns in matrix A : "
	lenmsgcol1: equ $-msgcol1
	msgenter1: db "Enter the elements of matrix A",10
	lenmsgenter1: equ $-msgenter1
	
	msgrow2: db "No. of rows in matrix B : "
	lenmsgrow2: equ $-msgrow2
	msgcol2: db "No. of columns in matrix B : "
	lenmsgcol2: equ $-msgcol2
	msgenter2: db "Enter the elements of matrix B",10
	lenmsgenter2: equ $-msgenter2
	
	matA: db "MATRIX A",10
	lenmatA: equ $-matA
	matB: db "MATRIX B",10
	lenmatB: equ $-matB
	matC: db "MATRIX C = A * B",10
	lenmatC: equ $-matC
	
	msgno: db "SORRY!!!Matrix cannot be multiplied",10
	lenmsgno: equ $-msgno
	
	space: db 32
	blank: db 10
	count: db 0
	
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	;a digit
	string: resb 10 
        stringlen: resb 1
	
	matrix1: resd 100
	row1: resd 1
	col1: resd 1
	
	matrix2: resd 100
	row2: resd 1
	col2: resd 1
	
	temp: resd 1
	
	matrix3: resd 100
	tot: resd 1
	end: resd 1
	
	row:resd 1
	col: resd 1
	
	i: resd 1
	j: resd 1
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
	je exit
	
	mov ecx,msgcol1
	mov edx,lenmsgcol1
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[col1],eax  
	
	cmp DWORD[col1],0
	je exit
	
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
	je exit
	
	mov ecx,msgcol2
	mov edx,lenmsgcol2
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[col2],eax  
	
	cmp DWORD[col2],0
	je exit
	
	mov eax,DWORD[row2]
	mov ecx,DWORD[col2]
	mul ecx
	mov DWORD[temp],eax
	
	mov ebx,matrix2
	call GETMATRIX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Got the matrices
	mov eax,DWORD[col1]
	cmp eax,DWORD[row2]
	jne printno
	
	mov eax,DWORD[row2]
	mov ebx,DWORD[col2]
	mul ebx
	mov DWORD[tot],eax
	
	mov ebx,matrix1
	mov ecx,matrix2
	mov edx,matrix3
	;Matrix Multiply
	;D = B * C
	mov DWORD[i],0
i_loop:
	inc DWORD[i]
	mov DWORD[edx],0
	
	mov eax,DWORD[row1]
	cmp DWORD[i],eax
	
	ja matrix_multiply_done
	
	cmp DWORD[i],1
	je starts
	
	add ebx,4;goes to new row of first mat.....since wen this stmt is executed the pointer is at the end of prev line 4 is enough
	mov ecx,matrix2
starts:
	;set end for total number of iterations in j(r2*c2)
	mov eax,DWORD[tot]
	mov DWORD[end],eax
	
	mov DWORD[j],0
j_loop:
	push edx

	mov eax,DWORD[ecx];multiplication of 2 elements
	mov edx,DWORD[ebx]
	mul edx
	
	pop edx
	
	add DWORD[edx],eax;updating sum
	
	inc DWORD[j]
	
	mov eax,DWORD[j]
	cmp eax,DWORD[row2]
	jne incredown
	
	add edx,4
	mov DWORD[edx],0
	
	dec DWORD[end]
	cmp DWORD[end],0
	je i_loop
	
	push eax;mov matB to start of next col
	push ebx
	push edx
	mov eax,DWORD[row2]
	dec eax
	mov ebx,DWORD[col2]
	mul ebx
	mov ebx,4
	mul ebx
	pop edx
	sub ecx,eax
	add ecx,4
	
	push edx
	mov eax,DWORD[col1];mata to start of row
	dec eax
	mov ebx,4
	mul ebx
	pop edx
	pop ebx
	sub ebx,eax
	pop eax
	
	mov DWORD[j],0
	jmp j_loop
incredown:
	dec DWORD[end]
	cmp DWORD[end],0
	je i_loop
	
	add ebx,4
	
	push eax
	push ebx
	push edx
	
	mov eax,DWORD[col2]
	mov ebx,4
	mul ebx
	pop edx
	add ecx,eax
	
	pop ebx
	pop eax
	
	jmp j_loop
	
matrix_multiply_done:
	mov ecx,matA
	mov edx,lenmatA
	call WRITE
	
	mov ebx,matrix1
	
	mov eax,DWORD[row1]
	mov DWORD[row],eax
	
	mov eax,DWORD[col1]
	mov DWORD[col],eax
	
	call DISPLAYMATRIX
	;......................................
	mov ecx,matB
	mov edx,lenmatB
	call WRITE
	
	mov ebx,matrix2
	
	mov eax,DWORD[row2]
	mov DWORD[row],eax
	
	mov eax,DWORD[col2]
	mov DWORD[col],eax
	
	call DISPLAYMATRIX
	;......................................
	mov ecx,matC
	mov edx,lenmatC
	call WRITE
	
	mov ebx,matrix3
	
	mov eax,DWORD[row1]
	mov DWORD[row],eax
	
	mov eax,DWORD[col2]
	mov DWORD[col],eax
	
	call DISPLAYMATRIX
	
	jmp exit
printno:
	mov ecx,msgno
	mov edx,lenmsgno
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
