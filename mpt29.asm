data segment
msg1 db 10,13,"Enter Number : $"
msg2 db 10,13,"2's Complement is : $"
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

mov dx,offset msg1 
call displaymsg

mov ah,01h
int 21h
call input
rol al,04h
mov bl,al
mov ah,01h
int 21h
call input
add bl,al

mov cl,bl
not cl
add cl,01h
mov bl,cl

mov dx,offset msg2
call displaymsg

and bl,0f0h
ror bl,04h
call output
mov bl,cl
and bl,0fh
call output

mov ah,4ch
int 21h


input proc
	cmp al,41h
	jmp lab1
	sub al,07h
	lab1:
	sub al,30h
	ret
endp

displaymsg proc
	mov ah,09h
	int 21h
	ret
endp

output proc
	cmp bl,0ah
	jc lab2
	add bl,07h
	lab2:
	add bl,30h
	mov dl,bl
	mov ah,02h
	int 21h
	ret
endp

code ends
end start
