DATA SEGMENT
	len1 db ?
	len2 db ?
	msg1 db,0dh,0ah,"Enter a string: $"
	msg2 db,0dh,0ah,"Enter the string to be appended: $"
	res db,0dh,0ah,"Concatenated string is: $"

DATA ENDS

CODE SEGMENT
	assume CS:code,DS:data 

start:  mov ax,data
		mov DS,ax
		
		;1st string
		mov si,5000h
		mov dx,offset msg1
		mov ah,09h
		int 21h
		
accept1:mov ah,01h
		int 21h
		mov [si],al
		cmp al,0dh
		jz lblb 
		inc si
		inc len1
		jmp accept1
		
   lblb:;2nd string
		mov di,7000h
		mov dx,offset msg2
		mov ah,09h
		int 21h
		
accept2:mov ah,01h
		int 21h
		mov [di],al
		cmp al,0dh
		jz lblc
		inc di
		inc len2 
		jmp accept2
		
   lblc:mov di,7000h
		mov cl,len2
		mov ch,00h
		
   conc:mov bl,[di]
		mov [si],bl
		inc di
		inc si
		loop conc
		
		mov cl,len1
		add cl,len2
		mov ch,00h
		mov si,5000h
		
		mov dx,offset res
		mov ah,09h
		int 21h
     l1:mov dl,[si]
		mov ah,02h
		int 21h
		inc si
		loop l1
		
		mov ah,4ch
		int 21h
		
code ends
end start
