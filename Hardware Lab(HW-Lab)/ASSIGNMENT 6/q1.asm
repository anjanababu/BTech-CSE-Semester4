;Write a program to read two floating point numbers and to print its sum, difference and product.
section .data
	msg1: db "Enter any two numbers : ",0Ah
	len_msg1: equ $-msg1
	blank: db 10

	format1 db "%lf",0
	format2 db 10,"Sum		=	  %lf",0
	format3 db 10,"Difference	=	 %lf",0
	format4 db 10,"Product		=	%lf",10
	

section .bss	
	count: resb 1
section .text
	global main
	extern scanf
	extern printf
	
main:

	mov ecx, msg1
	mov edx, len_msg1
	call WRITE

	mov BYTE[count], 2

get_numbers:
	call read ;stores value to ST0....pushes other values down
	fst ST1
	dec BYTE[count]
	cmp byte[count], 0
	jne get_numbers
	
	fadd ST2 ;ST0 = ST0(sec) + ST2(first)
	call print1
		
	fldz
	fadd ST3
	fsub ST2
	call print2

	fld ST2
	fmul ST4
	call print3

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
	
WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret

	
print1:

	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format2
	 call printf
	 
	 mov esp, ebp
	 pop ebp
	 ret

print2:

	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format3
	 call printf
	 
	 mov esp, ebp
	 pop ebp
	 ret

print3:

	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format4
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

