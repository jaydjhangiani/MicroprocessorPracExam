data segment

msg1 db 10,13,"Enter dividend : $"
msg2 db 10,13,"Enter divisor : $"
msg3 db 10,13,"Quotient : $"
msg4 db 10,13,"Remainder : $"
count db ?
temp db ?
data ends

code segment

assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov temp,00h
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
mov ah,01
int 21h
call ipconvert
rol al,04h
mov cl,al
mov ah,01
int 21h
call ipconvert
add cl,al

mov count,00h

comp:
cmp bl,cl
jc lab1
sub bl,cl
inc count
jmp comp




lab1:
mov dx,offset msg4
call displaymsg
mov temp,bl
and bl,0f0h
ror bl,04h
call opconvert
mov bl,temp
and bl,0fh
call opconvert


mov dx,offset msg3
call displaymsg
mov bl,count
mov temp,bl
and bl,0f0h
ror bl,04h
call opconvert
mov bl,temp
and bl,0fh
call opconvert


mov ah,4ch
int 21h

displaymsg proc
	mov ah,09
	int 21h
	ret
endp

opconvert proc
	cmp bl,0Ah
	jc labo
	add bl,07h
	labo:
	add bl,30h
	mov dl,bl
	mov ah,02
	int 21h
	ret
endp

ipconvert proc
	cmp al,41h
	jc labi
	sub al,07h
	labi:
	sub al,30h
	ret
endp

code ends
end start
