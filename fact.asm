data segment

msg1 db 10,13,"Enter Number: $"
msg2 db 10,13,"Factorial : $"

data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
	mov dx,offset msg1
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
	
	mov dx,offset msg2
	call displaymsg
	
	
	
	mov al,bl
	cal:
	sub bl,01h
	cmp bl,00h
	jz print
	mul bl
	loop cal
	
	
	print:
	mov bx,ax
	mov cx,bx
	and bx,0f000h
	ror bx,0Ch
	call opconvert
	mov bx,cx
	and bx,0f00h
	ror bx,08h
	call opconvert
	mov bx,cx
	and bx,00f0h
	ror bx,04h
	call opconvert
	mov bx,cx
	and bx,000fh
	call opconvert
	
	
	exit:
	mov ah,4ch
	int 21h
	
	ipconvert proc
	cmp al,41h
	jc lab1
	sub al,07h
	lab1:
	sub al,30h
	ret
	endp
	
	opconvert proc
	cmp bx,0Ah
	jc lab2
	add bx,07h
	lab2:
	add bx,30h
	mov dx,bx
	mov ah,02
	int 21h
	ret
	
endp
	
	displaymsg proc
	mov ah,09
	int 21h
	ret
endp
code ends
end start
