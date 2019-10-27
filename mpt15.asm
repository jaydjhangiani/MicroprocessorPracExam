data segment
msg1 db 10,13,"1. Find Min		2.Find Max		Enter Choice:	$"
msg2 db 10,13,"Enter number of elements : $"
msg3 db 10,13,"Enter elements : $"
msg4 db 10,13,"Minimum is : $"
msg5 db 10,13,"Maximum is : $"
choice db ?
len db ?
min db ?
max db ?
dum db ?
data ends

code segment
assume ds:data,cs:code
start:
mov ax,data
mov ds,ax

mov dx,offset msg2
call displaymsg
call input
mov len,bl

mov si,1000h
mov cx,0000h
mov cl,len

enterelements:
	mov dx,offset msg3
	call displaymsg
	call input
	mov [si],bl
	inc si
loop enterelements
	
mov si,1000h
mov cx,0000h
mov cl,len
mov max,bl
mov min,bl

calmax:
	mov bx,[si]
	cmp max,bl
	jnc labinc
	mov max,bl
	
		
	labinc:
	inc si
loop calmax

mov si,1000h
mov cx,0000h
mov cl,len

calmin:
	mov bx,[si]
	cmp min,bl
	jc labin
	mov min,bl
	
		
	labin:
	inc si
loop calmin




mov dx,offset msg4
call displaymsg
mov bl,min
call output

mov dx,offset msg5
call displaymsg
mov bl,max
call output



mov ah,4ch
int 21h

displaymsg proc
mov ah,09
int 21h
ret
endp

input proc
mov ah,01
int 21h
call ipascii
rol al,04h
mov bl,al
mov ah,01
int 21h
call ipascii
add bl,al
ret
endp

output proc
mov dum,bl
and bl,0f0h
ror bl,04h
call opascii
mov bl,dum
and bl,0Fh
call opascii
ret
endp

ipascii proc
cmp al,41h
jc labip
sub al,07h
labip:
sub al,30h
ret
endp

opascii proc
cmp bl,0ah
jc labop
add bl,07h
labop:
add bl,30h
mov dl,bl
mov ah,02h
int 21h
ret
endp
code ends
end start
