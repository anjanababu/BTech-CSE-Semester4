;Find the mode of 'n' two digit numbers. Also print the number of occurrence of each number.
section .data
	msg1: db "Enter the number of element in the array : "
	lenmsg1: equ $-msg1
	msg2: db "Enter the elements of the array",10
	lenmsg2: equ $-msg2
	msg3: db "OCCURRENCES ",10
	lenmsg3: equ $-msg3
	time: db "   x  "
	lentime: equ $-time
	msg4: db "MODE ",10
	lenmsg4: equ $-msg4
	newline: db 10
	comma: db ", "
	lencomma: equ $-comma
section .bss
	number: resd 1  ;anynumber
	digit: resb 1	;a digit
	string: resb 10 
        stringlen: resb 1
	
	array: resd 100 
	limit: resd 1   
	temp: resd 1    ;temporary storage of limit
	freqarray: resd 100
	counter1: resd 1
	counter2: resd 1
	freq: resb 1   
	key: resd 1   
	prev resd 1
	largest: resb 1
section .text
	global _start:
_start:

	;get the number of elements in array(limit)
	mov ecx,msg1
	mov edx,lenmsg1
	call WRITE
	
	call GETANYNUMBER

	mov eax,DWORD[number]
	mov DWORD[limit],eax	
	
	cmp DWORD[limit],0
	je exit                                   ;if 0 elements exit
	
	;get elements of the array
	mov ecx,msg2
	mov edx,lenmsg2
	call WRITE

	call SETTEMP
	mov ebx,array
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
	je sortover
	mov eax,DWORD[counter1],
	mov DWORD[counter2],eax
	mov ecx,ebx
	jmp bubble
	
sortover:
	mov ebx,array
	mov ecx,freqarray
	mov eax,DWORD[limit]
	mov DWORD[counter1],eax
	
MAKEFREQUENCYARRAY: ;nw the array is in sorted order so freq order also change
	;get the number whose frequency to be found
	call SETTEMP
	push ebx
	push ecx

	mov eax,DWORD[ebx]
	mov DWORD[key],eax

	mov ebx,array
	mov eax,DWORD[key]	
	mov DWORD[freq],0
comparing:
	cmp eax,DWORD[ebx]
	jne skip1
	add DWORD[freq],1	
skip1:
	add ebx,4
	dec DWORD[temp]
	cmp DWORD[temp],0      
	jne comparing 
	
	pop ecx
	pop ebx
	
	mov eax,DWORD[freq]	
	mov DWORD[ecx],eax
	
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je freqarraymade
	add ebx,4
	add ecx,4
	jmp MAKEFREQUENCYARRAY
	
freqarraymade:
	mov ecx,msg3
	mov edx,lenmsg3
	call WRITE
	
	call SETTEMP
	mov DWORD[counter1],eax
	
	mov ebx,array
	push ebx
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	
	mov ecx,time
	mov edx,lentime
	call WRITE
	
	mov ecx,freqarray
	push ecx
	mov eax,DWORD[ecx]
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	pop ecx
	pop ebx
	mov eax,DWORD[ebx]
	mov DWORD[prev],eax
	
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je printingover
	add ebx,4
	add ecx,4
printoccurrences:
	push ebx
	push ecx
	
	mov eax,DWORD[prev]
	cmp eax,DWORD[ebx]
	je taken
	
	mov eax,DWORD[ebx]
	mov DWORD[prev],eax
	
	push ebx
	push ecx
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	
	mov ecx,time
	mov edx,lentime
	call WRITE
	pop ecx
	mov eax,DWORD[ecx]
	push ecx
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	pop ecx
	pop ebx
	
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je printingover
	add ebx,4
	add ecx,4
	jmp printoccurrences	
taken:
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je printingover
	
	pop ecx
	pop ebx
	add ebx,4
	add ecx,4
	jmp printoccurrences

printingover:
FINDLARGEST:
	mov ebx,freqarray
	mov eax,DWORD[ebx]
	mov DWORD[largest],eax
	
	call SETTEMP
	mov DWORD[counter1],eax
finding:
	push ebx
	mov eax,DWORD[ebx]
	cmp eax,DWORD[largest]
	jna skiplar
	mov DWORD[largest],eax
skiplar:
	dec DWORD[counter1]
	cmp DWORD[counter1],0
	je found
	pop ebx
	add ebx,4
	jmp finding
	
found:
	mov ecx,msg4
	mov edx,lenmsg4
	call WRITE
	;;;;;;;;;;;;;;;;;;;;FINDING MODE
	mov ebx,array
	mov ecx,freqarray	
	call SETTEMP
	
	push ebx
	push ecx
	mov eax,DWORD[ebx]
	mov DWORD[prev],eax
	
	mov eax,DWORD[ecx]
	cmp eax,DWORD[largest]
	jne notmode
	
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
	
	pop ecx
	pop ebx
	dec DWORD[temp]
	cmp DWORD[temp],0
	je exit
	add ebx,4
	add ecx,4	
	jmp findingmode
notmode:
	pop ecx
	pop ebx
	dec DWORD[temp]
	cmp DWORD[temp],0
	je exit
	add ebx,4
	add ecx,4
findingmode:
	push ebx
	push ecx
	mov eax,DWORD[ecx]
	cmp eax,DWORD[largest]
	jne notmode2
	mov eax,DWORD[ebx]
	cmp DWORD[prev],eax
	je taken2
	
	mov DWORD[prev],eax
	mov eax,DWORD[ebx]
	call DISPLAYNUMBER
	
	mov ecx,newline
	mov edx,1
	call WRITE
notmode2:
taken2:
	dec DWORD[temp]
	cmp DWORD[temp],0
	je exit
	pop ecx
	pop ebx
	add ebx,4
	add ecx,4
	jmp findingmode
	
;;;;;;;SUB PROGRAMS
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
 
