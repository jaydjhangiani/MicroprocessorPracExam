;combination of q12,q14,q23,q27
;array size is 10
data segment
	msg db,10,13,"Enter Choice : $"
	msg1 db 10,13,"1.Asc Order	2.Desc Order	3.Search	4.occurrence	5.EXIT $"
	msg2 db 10,13,"Enter Elments : $"
	msg3 db,10,13,"Sorted Array is : $"
	msg4 db,10,13,"Enter Number to be searched : $"
	msg5 db,10,13,"Found at : $"
	msg6 db,10,13,"NOT FOUND $"
	msg7 db,10,13,"Enter Number to find its occurrence : $"
	msg8 db,10,13,"Occurrence : $"
	len db ?
	choice db ?

data ends

code segment
assume cs:code,ds:data
start:

mov ax,data
mov ds,ax


mov dx,offset msg1
call displaymsg
call entprc
menu:
mov dx,offset msg1
call displaymsg
mov dx,offset msg
call displaymsg
mov ah,01
int 21h
sub al,30h
mov choice,al



cmp choice,01h
jnz labdsc
call ascprc
jmp menu

labdsc:
cmp choice,02h
jnz labsrch
call descprc
jmp menu

labsrch:
cmp choice,03h
jnz labocc
call srchprc
jmp menu

labocc:
cmp choice,04h
jnz labexit
call occprc
jmp menu

labexit:
mov ah,4ch
int 21h



displaymsg proc
	mov ah,09
	int 21h
	ret
endp

entprc proc
	mov si,1000h
	mov ch,00h
	mov cl,0Ah
	
	enterelements:
	mov dx,offset msg2
	call displaymsg
	
	mov ah,01
	int 21h
	call ipconvert
	rol al,04h
	mov bl,al
	mov ah,01
	int 21h
	call ipconvert
	add bl,al
	
	mov [si],bl
	inc si
	loop enterelements
	
	ret
endp

ascprc proc
	mov bl,0Ah
	dec bl
	mov dh,00h
	
		loop1:
			mov si,1000h
			mov ch,00h
			mov cl,0Ah
			dec cl
			
			loop2:
			
				mov ah,[si]
				inc si
				mov al,[si]
				
				cmp ah,al
				jc lab0
				
				xchg ah,al
				dec si
				mov [si],ah
				inc si
				mov [si],al
				
			lab0:
				loop loop2
				
		inc dh
		cmp dh,bl
		jc loop1
	
	
	mov si,1000h
	mov ch,00h
	mov cl,0Ah	
	print:
	mov dx,offset msg3
	call displaymsg
	
	mov bx,[si]
	and bl,0f0h
	ror bl,04h
	call opconvert
	mov bx,[si]
	and bl,0fh
	call opconvert
	inc si
	loop print
	
	
	ret
endp

descprc proc
	mov bl,0Ah
	dec bl
	mov dh,00h
	
		loop1d:
			mov si,1000h
			mov ch,00h
			mov cl,0Ah
			dec cl
			
			loop2d:
			
				mov ah,[si]
				inc si
				mov al,[si]
				
				cmp ah,al
				jnc lab10
				
				xchg ah,al
				dec si
				mov [si],ah
				inc si
				mov [si],al
				
			lab10:
				loop loop2d
				
		inc dh
		cmp dh,bl
		jc loop1d
	
	
	mov si,1000h
	mov ch,00h
	mov cl,0Ah	
	printd:
	mov dx,offset msg3
	call displaymsg
	
	mov bx,[si]
	and bl,0f0h
	ror bl,04h
	call opconvert
	mov bx,[si]
	and bl,0fh
	call opconvert
	inc si
	loop printd
	
	
	ret
endp

srchprc proc
	
	mov dx,offset msg4
	call displaymsg
	mov ah,01
	int 21h
	call ipconvert
	rol al,04h
	mov bl,al
	mov ah,01
	int 21h
	call ipconvert
	add bl,al
	mov bh,00h
	mov si,1000h
	mov ch,00h
	mov cl,0Ah
	
	checkno:
	inc bh
	cmp bl,[si]
	jz lab3
	inc si
	loop checkno
	jmp error1
	
	lab3:
	mov dx,offset msg5
	call displaymsg
	mov bl,bh
	and bl,0f0h
	ror bl,04h
	call opconvert
	mov bl,bh
	and bl,0fh
	call opconvert
	jmp menu
	
	error1:
	mov dx,offset msg6
	call displaymsg
	
	ret
	
endp

occprc proc
	mov dx,offset msg7
	call displaymsg
	mov ah,01
	int 21h
	call ipconvert
	rol al,04h
	mov bl,al
	mov ah,01
	int 21h
	call ipconvert
	add bl,al
	
	mov bh,00h
	mov si,1000h
	mov ch,00h
	mov cl,0Ah
	
	occurrence:
	cmp bl,[si]
	jnz lab5
	inc bh
	lab5:
	inc si
	loop occurrence
		
	
	cmp bh,00h
	jnz fnd
	mov dx,offset msg6
	call displaymsg
	jmp menu
	
	fnd:
	mov dx,offset msg8
	call displaymsg
	mov bl,bh
	and bl,0f0h
	ror bl,04h
	call opconvert
	mov bl,bh
	and bl,0fh
	call opconvert
	jmp menu
	
	
	ret
endp



ipconvert proc
	cmp al,41h
	jc lab1
	sub al,07h
	lab1:
	sub al,30h
	ret
endp

opconvert proc
	cmp bl,0Ah
	jc lab2
	add bl,07h
	lab2:
	add bl,30h
	mov dl,bl
	mov ah,02
	int 21h
	ret
endp

code ends
end start
