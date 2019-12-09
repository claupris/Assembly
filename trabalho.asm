Codigo SEGMENT
 Assume cs:codigo; ds:codigo; es:codigo; ss:codigo
org 100h
.386

Entrada: jmp programa       

msg0    db      '1-Soma',0dh,0ah,'2-subtracao',0dh,0ah,'3-multiplicacao',0Dh,0Ah, '$'
msg2:    db      0dh,0ah,'Entre com o primeiro numero : $'
msg3:    db      0dh,0ah,'Entre com o segundo numero : $'
msg4:    db      0dh,0ah,'Escolha errada!!',0dh,0ah,'$' 
msg5:    db      0dh,0ah,'Resultado : $' 
msg6:    db      0dh,0ah ,'acabou o fucking trabalho!!! DISGRAAAAAAAAAAAAAACA', 0Dh,0Ah, '$'

programa:  	mov ah,9
			mov dx, offset msg0 
			int 21h
			mov ah,0                       
			int 16h  
			cmp al,31h 
			je soma
			cmp al,32h
			je Subt
			cmp al,33h
			je Mult		
			mov ah,09h
			mov dx, offset msg4
			int 21h
			mov ah,0
			int 16h
			jmp programa
        
soma:   	mov ah,09h  
            mov dx, offset msg2  
            int 21h
            mov cx,0 
            call semEntrada  
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call semEntrada
            pop bx
            add dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 
            
semEntrada: mov ah,0
            int 16h     
            mov dx,0  
            mov bx,1 
            cmp al,0dh  
            je Form
            sub ax,30h 
            call ViewNo 
            mov ah,0 
            push ax  
            inc cx   
            jmp semEntrada 

Form:     pop ax  
            push dx      
            mul bx
            pop dx
            add dx,ax
            mov ax,bx       
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne Form
            ret   


       
       
View:  mov ax,dx
       mov dx,0
       div cx 
       call ViewNo
       mov bx,dx 
       mov dx,0
       mov ax,cx 
       mov cx,10
       div cx
       mov dx,bx 
       mov cx,ax
       cmp ax,0
       jne View
       ret


ViewNo:    push ax 
           push dx 
           mov dx,ax 
           add dl,30h 
           mov ah,2
           int 21h
           pop dx  
           pop ax
           ret
      
   
exit:   mov dx,offset msg6
        mov ah, 09h
        int 21h  


        mov ah, 0
        int 16h

        ret
            
                       
Mult:   mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call semEntrada
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call semEntrada
            pop bx
            mov ax,dx
            mul bx 
            mov dx,ax
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 


Subt:   mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call semEntrada
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call semEntrada
            pop bx
            sub bx,dx
            mov dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit  

Codigo ENDS
   END Entrada			