stacksg segment para stack 'stack'      
stacksg ends
;---------------------------------
datasg segment 'data'
    textoNom   DB "Digite su nombre o apodo.",10,13, "$" 
    textoCar   DB 10,13,"Digite el caracter que desea observar.",10,13, "$"
    textoJug   DB 10,13,"Jugador: ","$"
    textoVidas DB 9,9,"Vidas: ","$"                                   
    textoGO    DB "Game Over! Su puntuacion fue de: ","$"
    lifes      DB 3,"$"
    score      DB 0,"$"
    nombre DB 10,?,10 dup (?),"$"
    caracter DB 0 
    barrita DB 219
    finbar  DB ? 
    posbarx DB 40
    posbary DB 22
    posbloqx DB 22
    posbloqy DB 7
    posbloqx2 DB 22
    posbloqy2 DB 7
    bloque  DB 178
    x DB 40
    y DB 20 
    x2 DB 40
    y2 DB 21
    limiteUP DB 6
    limiteDOWN DB 23 
    limiteLEFT DB 20
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
   
   xor ax,ax
   xor dx,dx
   
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
          
   mov dl,50
   mov dh,1     
   mov ah,02h
   int 10h
          
   mov ah, 9      				
   lea dx, textoVidas         				
   int 21h
   
   xor dx,dx       
   mov dl,lifes
   add dl,48

   mov ah,02h
   int 21h
   
   popa 
   
   
;GAMELOOP:
 
   mov cx, 3

IMPRIMIRBLOQUES:
   pusha
   
   mov bl,posbloqx2
   mov posbloqx,bl
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h 
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0ah ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0ah ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0ch ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0ch ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0bh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0bh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0eh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0eh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0dh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0dh ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0ah ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqx
   
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0ah ; attribute.
   mov     cx, 1   ; single char.
   int     10h
   
   inc posbloqy
   inc posbloqy
   popa 
   
   loop IMPRIMIRBLOQUES
  
   
   mov cx,8 ; esto es para el loop de la barra...
   
   
IMPRIMIRBARRA: 

   pusha

   mov dl,posbarx
   mov dh,posbary     
   mov ah,02h
   int 10h 
   
   mov     al, barrita
   mov     ah, 09h
   mov     bl, 0ah ; attribute.
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
   
   cmp ah, right
   je MOVERBARRADER
   
   cmp ah, left
   je MOVERBARRAIZQ
   
   jmp PEDIRTECLA
  
   
MOVERBARRAIZQ: 

   pusha  
   
   mov bl,finbar
   cmp bl,limiteLEFT
   je PEDIRTECLA
   
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
   jmp PEDIRTECLA
   

   
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
   jmp PEDIRTECLA    

MOVERUP:
    
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   dec y
   inc x
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah,08h
   int 10h
   
   cmp al,bloque
   je BORRARBLOQUE
   
   mov ah, 2         				
   mov dl, caracter
   int 21h 
   
   mov bl,limiteRIGHT
   cmp x,bl
   je MOVERUP2
   
   mov bl,limiteUP
   cmp y,bl
   je MOVERDOWN2
   
       
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
   dec x
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h 
   
   mov ah,08h
   int 10h
   
   cmp al,bloque
   je BORRARBLOQUE
   
   cmp al,barrita
   je RETURNUP2
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
    
   mov bl,limiteDOWN
   cmp y,bl
   je PERDERVIDA
   
   mov bl,limiteLEFT
   cmp x,bl
   je MOVERDOWN2
        
   
   jmp MOVERDOWN 
   
RETURNUP:
   dec y 
   jmp MOVERUP
   
RETURNUP2:
   dec y 
   jmp MOVERUP2      
         
MOVERUP2:
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   dec y
   dec x
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah,08h
   int 10h
   
   cmp al,bloque
   je BORRARBLOQUE
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
   
   mov bl,limiteUP
   cmp y,bl
   je MOVERDOWN
   
   mov bl,limiteLEFT
   cmp x,bl
   je MOVERUP
   
       
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
   inc x 
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah,08h
   int 10h
   
   cmp al,bloque
   je BORRARBLOQUE
          
   cmp al,barrita
   je RETURNUP
          
   mov ah, 2         				
   mov dl, caracter
   int 21h
    
   mov bl,limiteDOWN
   cmp y,bl  
   je PERDERVIDA
   
   mov bl,limiteRIGHT
   cmp x,bl
   je MOVERDOWN
       
   jmp MOVERDOWN2
   
PERDERVIDA:
   mov al,lifes
   sub al,1
   
   mov lifes,al
   
   cmp al,0
   je GAMEOVER
   
   jmp RESET
   
   
BORRARBLOQUE:
   
   jmp GAMEOVER 
     
    

RESET:
   mov dl,50
   mov dh,1     
   mov ah,02h
   int 10h
   
   mov ah, 9      				
   lea dx, textoVidas         				
   int 21h
   
   xor dx,dx       
   mov dl,lifes
   add dl,48

   mov ah,02h
   int 21h
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   mov dl,x2
   mov x,dl
   mov dh,y2
   mov y,dh     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
   
   mov  ah,00h
   int  16h
   
   jmp MOVERUP2
   

GAMEOVER:
    
   mov ax,0600h   
   mov bh,0fh     
   mov cx,0000h   
   mov dx,184fh   
   int 10h 
   
   
   mov dl,10
   mov dh,10     
   mov ah,02h
   int 10h
   
   mov ah, 9      				
   lea dx, textoGO         				
   int 21h 
   
   xor dx,dx       
   mov dl,score
   add dl,48

   mov ah,02h
   int 21h
   
   mov ax,4c00h
   int 21h 

   
   
codesg ends
end start