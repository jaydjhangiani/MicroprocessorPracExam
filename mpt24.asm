;q17 q24
data segment

msg1 db 10,13,"Enter first number : $"
msg2 db 10,13,"Enter second number : $"
msg3 db 10,13,"LCM : $"
msg4 db 10,13,"GCD : $"

data ends
code segment
assume ds:data,cs:code
start:

	mov ax,data
	mov ds,ax

	mov dx,offset msg1
	call displaymsg
	mov ah,01h
	int 21h
	call ipconvert
	rol al,04h
	mov cl,al
	mov ah,01h
	int 21h
	call ipconvert
	add cl,al
	
	mov dx,offset msg2
	call displaymsg
	mov ah,01h
	int 21h
	call ipconvert
	rol al,04h
	mov bl,al
	mov ah,01h
	int 21h
	call ipconvert
	add bl,al
		
	mov bh,00h
	mov ch,00h
	
	mov ax,cx
	mul bl
	
	l3: cmp bl,cl
	jnc l1
	sub cl,bl
	jmp l2
	l1: sub bl,cl
	l2: cmp bl,cl
	jnz l3
	
	div bl
	mov bx,ax
	
	mov dx,offset msg3
	call displaymsg
	
			mov cx, bx
			and bx, 0f000h
			ror bx,12
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx, 00f00h
			ror bx,8
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx, 000f0h
			ror bx,4
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx, 000fh
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
	
	
	
	
	
	
	
	
mov ah,4ch
int 21h

ipconvert proc
	cmp al,41h
	jc lab0
	sub al,07h
	lab0:
	sub al,30h
	ret
endp

HextoASCII proc
	cmp bl,0Ah
	jc lab1
	add bl,07h
	lab1:
	add bl,30h
	
		
	ret
endp

displaymsg proc
	mov ah,09
	int 21h
	ret
endp	

code ends
end start
