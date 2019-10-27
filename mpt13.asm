data segment
msg1 db 10,13,"1.Read String1	2.Read String2	3.Display Strings	4.Concatenate	5.Exit $"
msg2 db 10,13,"Enter String $"
msg3 db 10,13,"String 1 : $"
msg4 db 10,13,"String 2 : $"
msg5 db 10,13,"Concatenated String is : $"
msg6 db 10,13," $"
choice db ?
len1 db ?
len2 db ?
data ends

code segment
assume ds:data,cs:code
start:
mov ax,data
mov ds,ax

menu:
mov dx,offset msg1
call displaymsg
mov dx,offset msg6
call displaymsg

mov ah,01
int 21h
sub al,30h
mov choice,al

cmp choice,01h
jnz lab1
call entprc1
jmp menu

lab1:
cmp choice,02h
jnz labdisp
call entprc2
jmp menu

labdisp:
cmp choice,03h
jnz labconc
call disprc
jmp menu

labconc:
cmp choice,04h
jnz labexit
call concprc
jmp menu

labexit:
mov ah,4ch
int 21h

displaymsg proc
mov ah,09
int 21h
ret
endp

entprc1 proc
	mov si,1000h
	mov cx,0000h
	
	mov dx,offset msg2
	call displaymsg
	
	insert1:
	mov ah,01h
	int 21h
	
	cmp al,0Dh
	je comp1
	
	mov [si],al
	inc si
	inc cx
	jmp insert1
	
	comp1:
	mov len1,cl
	
	ret
endp

entprc2 proc
	mov dx,offset msg6
	call displaymsg
	mov dx,offset msg2
	call displaymsg
	
	mov di,2000h
	mov bx,0000h
	insert2:
	mov ah,01h
	int 21h
	
	cmp al,0Dh
	je comp2
	
	mov [di],al
	inc di
	inc bx
	jmp insert2
	
	comp2:
	mov len2,bl
	ret
	
endp

disprc proc
	mov dx,offset msg3
	call displaymsg
	
	mov si,1000h
	mov ch,00h
	mov cl,len1
	
	disp1:
	mov dx,[si]
	mov ah,02
	int 21h
	inc si
	loop disp1
		
	mov dx,offset msg4
	call displaymsg
	
	mov di,2000h
	mov ch,00h
	mov cl,len2
	
	disp2:
	mov dx,[di]
	mov ah,02
	int 21h
	inc di
	loop disp2
	ret
endp

concprc proc
	mov si,1000h
	mov ch,00h
	mov cl,len1
	
	add [si],cx
	dec si
	
	mov di,2000h
	mov h,00h
	mov cl,len2
	
	conc:
	mov bx,[di]
	mov [si],bx
	inc si
	inc di
	
	mov ah,02
	int 21h
	
	loop conc
	
	ret
endp




code ends
end start
