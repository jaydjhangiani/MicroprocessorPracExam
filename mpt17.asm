DATA SEGMENT
	msg1 db,0dh,0ah,"Enter 1st number: $"
	msg2 db,0dh,0ah,"Enter 2nd number: $"
	res db,0dh,0ah,"GCD is: $"
	gcd db ?
	N1 db 10 
	N2 db 05 
DATA ENDS

CODE SEGMENT
	assume CS:code, DS:data

start:  mov ax,data
		mov DS,ax
		
	mov bl,n1
	mov cl,n2
	
		
	l1: cmp bl,cl
	jnc l2
	sub cl,bl
	jmp l3
	l2: sub bl,cl
	l3:cmp bl,cl
	jnz l1
	
	mov gcd,bl
	
	 
	mov dx,offset res 
	mov ah,09h
	int 21h
		
	mov bl,gcd
	and bl,0f0h
	ror bl,04
	call HextoASCII
	mov dl,bl
	mov ah,02h
	int 21h
		
	mov bl,gcd
	and bl,0fh
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
		
	displaymsg proc
	mov ah,09
	int 21h
	ret
	endp
		
	HextoASCII proc
	cmp bl,0Ah
	jc lbl2
	add bl,07h
	lbl2:add bl,30h
	ret
	endp
		
code ends
end start
