;power
section .data
	msg1: db "Enter any two numbers : ",0Ah
	len_msg1: equ $-msg1
	blank: db 10

	format1 db "%lf",0
	format2 db 10,"%lf",10
	

section .bss	
	count: resb 1
	x: resd 1
	power: resd 1
	pr: resd 1
	cnt: resd 1
	one: resd 1
section .text
	global main
	extern scanf
	extern printf
	
main:
	mov DWORD[one],1

get_numbers:
	call read ;stores value to ST0....pushes other values down
	fstp DWORD[x]

	mov DWORD[power],0
	call CALCULATEPOWER
	fld DWORD[pr]
	call print

exit:
	mov eax, 1
	mov ebx, 0
	int 80h

	;power
	;x-number
	;pr-result
CALCULATEPOWER:
	cmp DWORD[power],0
	jne power_loop_set

	fild DWORD[one]
	jmp got_power

power_loop_set:
	mov eax,DWORD[power]
	mov DWORD[cnt],eax

	fld DWORD[x]
	fst ST1

	power_loop:
		cmp DWORD[cnt],1
		je got_power
		
		fmul ST1	
		dec DWORD[cnt]
		jmp power_loop
got_power:
	fstp DWORD[pr]
	ret


	
	
WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret

	
print:

	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format2
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

