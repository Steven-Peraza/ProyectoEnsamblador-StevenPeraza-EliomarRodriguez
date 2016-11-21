include "emu8086.inc"

stacksg segment para stack 'stack'      
stacksg ends
;---------------------------------
datasg segment 'data'
    textoNom   DB "Digite su nombre o apodo.",10,13, "$" 
    textoCar   DB 10,13,"Digite el caracter que desea observar.",10,13, "$"
    textoJug   DB 10,13,"Jugador: ","$"
    textoVidas DB 9,9,"Vidas: ","$"
    textoScore DB 9,9,"Score: ","$"                                   
    textoGO    DB "Game Over! Su puntuacion fue de: ","$"
    textoDif   DB 10,13, "Digite la dificultad en la que desea jugar (Facil por Default).","$"
    textEasy   DB 10,13, "1. Facil","$"
    textMed    DB 10,13, "2. Medio","$"
    textHard   DB 10,13, "3. Dificil",10,13,"$"
    difi       DB 0
    lifes      DB 3,"$"
    score      DW 0,"$"
    nombre DB 10,?,10 dup (?),"$"
    caracter DB 0 
    barrita DB 219
    tambar  DB ?
    finbar  DB ? 
    posbarx DB ?
    posbary DB 22
    posbarx2 DB ?
    posbary2 DB 22
    posbloqx DB 22
    posbloqy DB 7
    posbloqx2 DB 22
    posbloqy2 DB 7
    bloque    DB 178 
    cantBlox  DB ?
    bounce    DB 0,"$"
    x  DB ?
    y  DB 20 
    posbolax DB ?
    posbolay DB 21
    limiteUP    DB 0
    limiteDOWN  DB 0 
    limiteLEFT  DB 0
    limiteRIGHT DB 0
    left    equ     4bh
    right   equ     4dh
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
   
   mov ah, 9      				
   lea dx, textoDif         				
   int 21h
   
   mov ah, 9      				
   lea dx, textEasy         				
   int 21h
   
   mov ah, 9      				
   lea dx, textMed         				
   int 21h
   
   mov ah, 9      				
   lea dx, textHard         				
   int 21h
   
   mov ah,1
   int 21h
   mov difi,al
   
   pusha
   
   mov ax,0600h   
   mov bh,0fh     
   mov cx,0000h   
   mov dx,184fh   
   int 10h 
   
   popa
   ;xor ax,ax
   ;xor dx,dx
   
   mov dl,0
   mov dh,0     
   mov ah,02h
   int 10h
   
  ; popa
   
   mov ah, 9      				
   lea dx, textoJug         				
   int 21h
   
   mov ah, 9      				
   lea dx, nombre         				
   int 21h 
   
   mov dl,30
   mov dh,1     
   mov ah,02h
   int 10h
   
   mov ah, 9      				
   lea dx, textoScore         				
   int 21h
    
   xor dx,dx       
   mov dl,score
   add dl,48

   mov ah,02h
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
   
   cmp difi,31h
   je EZ
   
   cmp difi,32h
   je MED
   
   cmp difi,33h
   je HARD
   
    
   

EZ:
    
    mov posbarx,28
    mov posbarx2,28
    mov x,32
    mov posbolax,32
    mov tambar, 8
    mov limiteUP, 6
    mov limiteDOWN, 23 
    mov limiteLEFT, 19
    mov limiteRIGHT, 43
    mov cantBlox, 7  
    jmp GAMEON 
    
MED:
    
    mov posbarx,32
    mov posbarx2,32
    mov x,35
    mov posbolax,35
    mov tambar, 6
    mov limiteUP, 6
    mov limiteDOWN, 23 
    mov limiteLEFT, 19
    mov limiteRIGHT, 50
    mov cantBlox, 9 
    jmp GAMEON
    
HARD:
    
    mov posbarx,36
    mov posbarx2,36
    mov x,38
    mov posbolax,38
    mov tambar, 4
    mov limiteUP, 6
    mov limiteDOWN, 23 
    mov limiteLEFT, 19
    mov limiteRIGHT, 54
    mov cantBlox, 11 
    jmp GAMEON
                 
BLOX proc 
   pusha
   mov dl,posbloqx
   mov dh,posbloqy     
   mov ah,02h
   int 10h 
   
   mov     al, bloque
   mov     ah, 09h
   mov     bl, 0ah ; attribute.
   mov     cx, 2   ; single char.
   int     10h
   
   add posbloqx,3
   popa
   ret
    
endp BLOX  


GAMEON:
   mov cx, cantBlox   
   mov bl,posbloqx2
   mov posbloqx,bl
    
IMPRIMIRBLOQUES:
   call BLOX
   dec cx
   jnz IMPRIMIRBLOQUES
   jmp FILAS  

FILAS: 

   cmp posbloqy,11
   je IMPRIMIRBARRA
   
   inc posbloqy
   inc posbloqy
   
   jmp GAMEON 
   
     
   
IMPRIMIRBARRA: 

   pusha

   mov dl,posbarx
   mov dh,posbary     
   mov ah,02h
   int 10h 
   
   mov     al, barrita
   mov     ah, 09h
   mov     bl, 0ah ; attribute.
   mov     cx, tambar   ; single char.
   int     10h 
      
   inc posbarx
           
   popa
   
   dec posbarx ; pos actual del cursor barra
   
   mov  ah,00h
   int  16h
   
   jmp MOVERUP
   
   
   
PEDIRTECLA:  


   mov  ah,01h
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
   sub al, tambar
    
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
   sub al,tambar
    
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
   
   mov bounce,1
   
   cmp al,bloque
   je REBOTE
   
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
   
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
   
   mov bounce,2
   
   cmp al,bloque
   je REBOTE
   
   cmp al,barrita
   je RETURNUP2
   
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
    
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
   
   mov bounce,3
   
   cmp al,bloque
   je REBOTE
   
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
   
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
   
   mov bounce,4
   
   cmp al,bloque
   je REBOTE
          
   cmp al,barrita
   je RETURNUP
          
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
    
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
   

REBOTE:
   
   call BORRARBLOQUE
   
   cmp bounce,1
   je MOVERDOWN2
   
   cmp bounce,2
   je MOVERUP2
             
   cmp bounce,3
   je MOVERDOWN
   
   cmp bounce,4
   je MOVERUP
   
   
   
   
BORRARBLOQUE proc

   mov ah, 2         				
   mov dl, 32
   int 21h
   
   inc x

   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   dec x
   dec x
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   xor ax,ax
   mov al,score
   add al,5
   mov score,al
   
   mov dl,47
   mov dh,1     
   mov ah,02h
   int 10h
     
   pusha
   xor ax,ax       
   mov al,score
   call PRINT_NUM
   popa
   
   ret 
endp BORRARBLOQUE     
    

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
   
   mov dl,posbolax
   mov x,dl
   mov dh,posbolay
   mov y,dh     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, caracter
   int 21h
   
   mov bl,posbarx2
   mov posbarx,bl 
   
   
   
   jmp IMPRIMIRBARRA
   

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
   
   xor ax,ax       
   mov al,score
   call PRINT_NUM

   mov ax,02h
   int 21h
   
   mov ax,4c00h
   int 21h 

   

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
   
codesg ends
end start