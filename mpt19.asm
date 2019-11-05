data segment
msg1 db 10,13,"Enter 1st Number : $"
msg2 db 10,13,"Enter 2nd Number : $"
msg3 db 10,13,"Addition is : $"
h1 dw ?
l1 dw ?
h2 dw ?
l2 dw ?
res1 dw ?
res2 dw ?
data ends
code segment
assume ds:data,cs:code
start:
mov ax,data
mov ds,ax

mov dx,offset msg1
call displaymsg
call input
mov h1,bx
call input
mov l1,bx

mov dx,offset msg2
call displaymsg
call input
mov h2,bx
call input
mov l2,bx

mov bx,l1
mov cx,l2
add bx,cx ;sub
mov res1,bx

mov bx,h1
mov cx,h2
adc bx,cx ;sbb
mov res2,bx

mov dx,offset msg3
call displaymsg
mov bx,res2
call output
mov bx,res1
call output

mov ah,4ch
int 21h

input proc
	mov ah,01h
	int 21h
	call ipconvert
	mov ah,00h
	rol ax,0ch
	mov bx,ax
	
	mov ah,01h
	int 21h
	call ipconvert
	mov ah,00h
	rol ax,08h
	mov bx,ax
	
	mov ah,01h
	int 21h
	call ipconvert
	mov ah,00h
	rol ax,04h
	mov bx,ax
	
	mov ah,01h
	int 21h
	call ipconvert
	mov ah,00h
	add bx,ax
	ret
endp

ipconvert proc
	cmp al,41h
	jmp lab1
	sub al,07h
	lab1:
	sub al,30h
	ret
endp

output proc
	mov cx,bx
	and bx,0f000h
	ror bx,0ch
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
	ret
endp

opconvert proc
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

displaymsg proc
	mov ah,09h
	int 21h
	ret
endp

code ends
end start
