data segment

msg1 db 10,13,"1.Accept String $"
msg2 db 10,13,"2.Dislay String $"
msg3 db 10,13,"3.Count Length $"
msg4 db 10,13,"4.Reverse String $"
msg9 db 10,13,"5.EXIT $"
msg5 db 10,13,"Select choice : $"
msg6 db 10,13,"Enter A String : $"
msg7 db 10,13,"Entered String Is : $"
msg10 db 10,13,"Reverse Of Entered String Is : $"
msg11 db 10,13,"Length of String Is : $"
msg8 db 10,13," $"

len db ?
choice db ?

data ends
code segment
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax

menu:
mov dx,offset msg1
call displaymsg
mov dx,offset msg2
call displaymsg
mov dx,offset msg3
call displaymsg
mov dx,offset msg4
call displaymsg
mov dx,offset msg9
call displaymsg
mov dx,offset msg5
call displaymsg

mov ah,01
int 21h
sub al,30h
mov choice,al

cmp al,05
jnz labacc
mov ah,4ch
int 21h


labacc:
cmp al,01h
jnz labdisp
call acceptprc
jmp menu

labdisp:
cmp al,02h
jnz labcnt
call displayprc
jmp menu

labcnt:
cmp al,03h
jnz labrev
call cntprc
jmp menu

labrev:
call revprc
jmp menu

displaymsg proc
mov ah,09
int 21h
ret
endp

acceptprc proc
mov dx,offset msg6
call displaymsg

mov si,1000h
mov di,1000h
mov cx,0000h

back:
mov ah,01h
int 21h

cmp al,0Dh
je comp

inc cx
mov[SI],al
mov[di],al

inc si
inc di
jmp back

comp:
mov len,cl
ret
endp

inc si
inc di

displayprc proc
mov dx,offset msg7
call displaymsg

mov cl,len
mov ch,00h
mov si,1000h

disp:

mov dl,[si]
mov ah,02h
int 21h
inc si
loop disp
mov dx,offset msg8
call displaymsg

ret
endp

revprc proc
mov dx,offset msg10
call displaymsg

mov cl,len
mov ch,00h
mov si,1000h
add si,cx
dec si
rev:
mov dl,[si]
mov ah,02h
int 21h
dec si
loop rev

mov dx,offset msg8
call displaymsg
ret
endp

cntprc proc
mov dx,offset msg11
call displaymsg

mov bl,len
and bl,0F0h
ror bl,04h
call output
mov bl,len
and bl,0fh
call output

mov dx,offset msg8
call displaymsg

ret
endp

output proc
cmp bl,0ah
jc lab1
add bl,07h
lab1: 
add bl,30h
mov dl,bl
mov ah,02h
int 21h
ret
endp


code ends
end start
