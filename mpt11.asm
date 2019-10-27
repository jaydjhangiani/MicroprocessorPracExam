data segment
msg1 db 10,13,"Enter Choice : $"
msg2 db 10,13,"1.Read	2.Display	3.Check Pallindrome		4.EXIT $"
msg3 db 10,13,"Enter a string : $"
msg4 db 10,13,"Entered String Is : $"
msg5 db 10,13,"String is Pallindrome $"
msg6 db 10,13,"String is not Pallindrome $"
msg7 db 10,13," $"
choice db ?
len db ?
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

menu:
mov dx,offset msg2
call displaymsg
mov dx,offset msg7
call displaymsg
mov dx,offset msg1
call displaymsg
mov dx,offset msg7
call displaymsg
mov ah,01
int 21h
sub al,30h
mov choice,al

cmp choice,01h
jnz labdisp
call entprc
jmp menu

labdisp:
cmp choice,02h
jnz labpal
call disprc
jmp menu

labpal:
cmp choice,03h
jnz exitp
call palprc
jmp menu

exitp:
mov ah,4ch
int 21h

displaymsg proc
mov ah,09
int 21h
ret
endp

entprc proc
	mov dx,offset msg3
	call displaymsg
	mov si,1000h
	mov cx,0000h
	mov di,1000h
	
	enterelement:
	mov ah,01
	int 21h
	
	cmp al,0Dh
	je comp
	
	inc cx
	mov [si],al
	mov [di],al
	
	inc si
	inc di
	jmp enterelement
	
	comp:
	mov len,cl
	
	mov dx,offset msg7
	call displaymsg
	
	ret
endp

disprc proc
	mov dx,offset msg4
	call displaymsg
	mov si,1000h
	mov ch,00h
	mov cl,len
	
	disp:
	mov dx,[si]
	mov ah,02
	int 21h
	inc si
	loop disp
	
	mov dx,offset msg7
	call displaymsg
	ret
endp

palprc proc
	mov si,1000h
	mov di,1000h
	mov ch,00h
	mov cl,len
	add di,cx
	dec di
	
	
	compare:
	mov al,[si]
	cmp al,[di]
	jnz notpal
	inc si
	dec di
	loop compare
	mov dx,offset msg5
	call displaymsg
	mov dx,offset msg7
	call displaymsg
	ret
	notpal:
	mov dx,offset msg6
	call displaymsg
	mov dx,offset msg7
	call displaymsg
	ret
endp




code ends
end start
