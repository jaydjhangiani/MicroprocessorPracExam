data segment
msg1 db 10,13,"Enter Year : $"
msg2 db 10,13,"Leap Year  $"
msg3 db 10,13,"Not a leap year $"
data ends

code segment
assume ds:data,cs:code
start:
mov ax,data
mov ds,ax

mov dx,offset msg1
call displaymsg
call input 
call input
call input
mov ah,00h
mov bl,0ah
mul bl
mov bx,ax
call input
add bx,ax
mov ax,bx
mov bl,04h
div bl
cmp ah,00h
je leap
mov dx,offset msg3
call displaymsg
mov ah,4ch
int 21h
leap:
mov dx,offset msg2
call displaymsg
mov ah,4ch
int 21h


input proc
	mov ah,01h
	int 21h
	cmp al,41h
	jc lab1
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

code ends
end start
