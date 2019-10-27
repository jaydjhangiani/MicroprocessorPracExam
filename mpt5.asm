data segment

msg1 db 10,13,"Enter number of elements to add : $"
msg2 db 10,13,"Enter Element : $"
msg3 db 10,13,"Result : $"
msg4 db 10,13," $"
len db ? 
sum db ? 
data ends

code segment
assume ds:data,cs:code
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
mov len,bl

mov si,1000h
mov cx,0000h
mov cl,len

enterelement:
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
	mov [si],bl
	inc si
loop enterelement

mov si,1000h
mov cx,0000h
mov cl,len
mov sum,00h

calculate:
	mov bx,[si]
	add sum,bl
	inc si
loop calculate

mov dx,offset msg3
call displaymsg
mov bl,sum
call output


mov ah,4ch
int 21h

displaymsg proc
	mov ah,09
	int 21h
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

output proc
	mov al,bl
	and al,0f0h
	ror al,04h
	call opconvert
	mov dl,al
	mov ah,02h
	int 21h
	mov al,bl
	and al,0fh
	call opconvert
	mov dl,al
	mov ah,02h
	int 21h
	
endp

opconvert proc
	cmp al,0Ah
	jc lab2
	add al,07h
	lab2:
	add al,30h
	ret
endp

code ends
end start
