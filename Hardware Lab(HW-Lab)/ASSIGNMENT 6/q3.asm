;Write a program to calculate the roots of a quadratic equation.
section .data
	msg1: db "Enter the coefficients(a,b,c)	 : ",10
	len_msg1: equ $-msg1
	blank: db 10
	
	imag: db "Roots are Imaginary",10
	len_imag: equ $-imag
	notq: db "Not Quadratic Equation",10
	len_notq: equ $-notq

	format1 db "%lf",0
	format2 db 10,"Root1		=	  %lf",0
	format3 db 10,"Root2		=	  %lf",10
section .bss
	count: resd 1
	two: resd 1
	four: resd 1
	zero: resd 1
	
	RDis: resd 1
	twoa: resd 1
	minb: resd 1

	r1: resd 1
	r2: resd 1
	waste: resd 1
section .text
	global main
	extern scanf
	extern printf
	
main:
	mov ecx, msg1
	mov edx, len_msg1
	call WRITE

	mov eax,2
	mov DWORD[two],eax

	mov eax,4
	mov DWORD[four],eax

	mov eax,3
	mov DWORD[count],eax
	
	mov eax,0
	mov DWORD[zero],eax
get_coefficients:
	call read ;stores value to ST0....pushes other values down
	fst ST1
	dec DWORD[count]
	cmp DWORD[count],0
	jne get_coefficients
	
	;ST0----c
	;ST1----c
	;ST2----b
	;ST3----a
calcutating_roots:
	fild DWORD[four]        ;ST0---4
	fmul ST1		;ST0---4c
	fldz
	fsub ST1		;ST0---  -4c
	
	fld ST4
	fmul ST0
	fadd ST1

	;;;;check for imaginary roots
	fcom DWORD[zero]
	fstsw ax
	sahf
	jb imaginary

	fsqrt			;ST----sqrt(b^2-4ac)
		
	fstp DWORD[RDis]
	
	fstp DWORD[waste]
	fstp DWORD[waste]
	fstp DWORD[waste]	;ST0--c ST1--b ST2--a
		
	fild DWORD[two]
	fmul ST3
	
	fcom DWORD[zero]
	fstsw ax
	sahf 
	je not_quadratic

	fstp DWORD[twoa]	
	
	fldz
	fsub ST2
	fstp DWORD[minb]

	fld DWORD[minb]
	fadd DWORD[RDis]
	fdiv DWORD[twoa]
	call print2
	fstp DWORD[r1]

	fld DWORD[minb]
	fsub DWORD[RDis]
	fdiv DWORD[twoa]
	call print3
	fstp DWORD[r2]		
	
exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
imaginary:
	mov ecx,imag
	mov edx,len_imag
	call WRITE
	jmp exit

not_quadratic:
	mov ecx,notq
	mov edx,len_notq
	call WRITE
	jmp exit
WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret

	
print2:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format2
	 call printf
	 
	 mov esp, ebp
	 pop ebp
	 ret
	
print3:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format3
	 call printf
	 
	 mov esp, ebp
	 pop ebp
	 ret

read:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 lea eax, [esp] ;load effective adress
	 push eax
	 push format1
	 call scanf
	 fld qword[ebp-8]
	 
	 mov esp, ebp
	 pop ebp
	 ret

