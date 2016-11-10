stacksg segment para stack 'stack'      
stacksg ends
;---------------------------------
datasg segment 'data'
    textoNom   DB 10,13,"Digite su nombre o apodo.",10,13, "$" 
    textoCar   DB 10,13,"Digite el caracter que desea observar.",10,13, "$"
    textoJug   DB 10,13,"Jugador: ","$"
    nombre DB 10,?,10 dup (?),'$'
    caracter DB 0 
    barrita DB 219
    finbar  DB ?
    posbarx DB 40
    posbary DB 22
    x DB 40
    y DB 20 
    x2 DB 0
    y2 DB 0
    limiteUP DB 6
    limiteDOWN DB 23 
    limiteLEFT DB 10
    limiteRIGHT DB 60
    left    equ     75
    right   equ     77
    up      equ     80
    down    equ     72         
    datasg ends
;---------------------------------
codesg segment 'code'  
    assume ds:datasg, cs:codesg, ss:stacksg
    
START:      
    
    mov ax,datasg
    mov ds,ax
    
   mov ah, 9      			
   lea dx, textoNom         				
   int 21h
   
   
   mov ah,0ah
   lea dx,nombre
   int 21h 
   
 
   mov ah, 9      				
   lea dx, textoCar         				
   int 21h
   
   mov ah,1
   int 21h
   mov caracter,al
   
   pusha
   
   mov ax,0600h   
   mov bh,0fh     
   mov cx,0000h   
   mov dx,184fh   
   int 10h 
   
   
   mov dl,0
   mov dh,0     
   mov ah,02h
   int 10h
   
   mov ah, 9      				
   lea dx, textoJug         				
   int 21h
   
   mov ah, 9      				
   lea dx, nombre         				
   int 21h
   
   popa 
   
   
;GAMELOOP:
   
   
   mov cx,8 ; esto es para el loop de la barra...
   
IMPRIMIRBARRA: 

   pusha

   mov dl,posbarx
   mov dh,posbary     
   mov ah,02h
   int 10h 
   
   mov     al, barrita
   mov     ah, 09h
   mov     bl, 0eh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
      
   inc posbarx
           
   popa
   
   loop IMPRIMIRBARRA
   
   dec posbarx ; pos actual del cursor barra
   
   jmp MOVERUP
   
PEDIRTECLA: 
   
   mov  ah,00h
   int  16h 
   
   cmp ah, left
   jmp MOVERBARRAIZQ
   
   cmp ah, right
   jmp MOVERBARRADER
  
   
MOVERBARRAIZQ: 

   pusha  
   
   mov bl,finbar
   cmp bl,limiteLEFT
   jmp PEDIRTECLA
   
   mov dl,posbarx
   mov dh,posbary     
   mov ah,02h
   int 10h 
   
   mov     al, ' '
   mov     ah, 09h
   mov     bl, 0eh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
           
   mov al,posbarx
   sub al, 8
    
   mov finbar,al
   
   mov dl,finbar
   mov dh,posbary     
   mov ah,02h
   int 10h
    
   mov     al, barrita
   mov     ah, 09h
   mov     bl, 0eh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   dec posbarx 
     
   popa

   

   
MOVERBARRADER:

    pusha 
    
   mov bl,finbar
   cmp bl,limiteRIGHT
   je PEDIRTECLA 
   
   inc posbarx

   mov dl,posbarx
   mov dh,posbary     
   mov ah,02h
   int 10h 
   
   mov     al, barrita
   mov     ah, 09h
   mov     bl, 0eh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
           
   mov al,posbarx
   sub al,8
    
   mov finbar,al
   
   mov dl,finbar
   mov dh,posbary     
   mov ah,02h
   int 10h
    
   mov     al, ' '
   mov     ah, 09h
   mov     bl, 0eh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
     
   popa
       

MOVERUP:
    
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   dec y
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
   
   mov bl,limiteUP
   cmp y,bl
   je MOVERDOWN    
   jmp MOVERUP

MOVERDOWN:
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   inc y
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h 
   
   mov ah,08h
   int 10h
   
   cmp al,barrita
   je RETURNUP
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
    
   mov bl,limiteDOWN
   cmp y,bl
   je MOVERUP     
   
   jmp MOVERDOWN 
   
RETURNUP:
   dec y 
   jmp MOVERUP      
         
MOVERUP2:
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   dec y
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
   
   mov bl,limiteUP
   cmp y,bl
   je MOVERDOWN2    
   jmp MOVERUP2

MOVERDOWN2:
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   inc y 
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
    
   mov bl,limiteDOWN
   cmp y,bl  
   je MOVERUP2    
   jmp MOVERDOWN2
   


   
   
codesg ends
end start