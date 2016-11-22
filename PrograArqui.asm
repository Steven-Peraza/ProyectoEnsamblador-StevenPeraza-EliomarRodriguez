include "emu8086.inc"    ;libreria para la impresion de numeros

stacksg segment para stack 'stack'      
stacksg ends
;---------------------------------segmento de variables----------------------------------------
datasg segment 'data'
    textoNom   DB "Digite su nombre o apodo.",10,13, "$" 
    textoVid   DB 10,13,"Digite la cantidad de vidas que desea tener (Un numero del 1 al 9, 3 por Defecto).",10,13, "$"
    textoCar   DB 10,13,"Digite el caracter que desea observar.",10,13, "$"
    textoJug   DB 10,13,"Jugador: ","$"
    textoVidas DB 9,9,"Vidas: ","$"
    textoScore DB 9,9,"Score: ","$"                                   
    textoGO    DB "Game Over! Su puntuacion fue de: ","$"
    textoDif   DB 10,13, "Digite la dificultad en la que desea jugar (Facil por Defecto).","$"
    textEasy   DB 10,13, "1. Facil","$"
    textMed    DB 10,13, "2. Medio","$"
    textHard   DB 10,13, "3. Dificil",10,13,"$"
    
    msgTime     DB "Su tiempo fue de: $"
    msgTime1    DB ":$"
    
    minI    DB 0   ; almacenara el minuto de inicio del juego
    minF    DB 0   ; almacenara el minuto de final del juego
    segI    DB 0   ; almacenara el segundo de inicio del juego
    segF    DB 0   ; almacenara el segundo de final del juego
    
    difi       DB 0     ;var que almacena la dificultad
    lifes      DB ?,"$" ;var que almacena la cantidad de vidas
    score      DW 0,"$"  ;var que almacena la puntuacion
    nombre DB 10,?,10 dup (?),"$" ;var que almacena el nombre del jugador
    caracter DB 0        ;var que almacena el caracter de juego
    barrita DB 219       ;var que almacena el caracter de la plataforma
    tambar  DB ?         ;var que almacena el tamano de la plataforma
    finbar  DB ?         
    posbarx DB ?         ;vars que almacenan la posicion de la plataforma
    posbary DB 22
    posbarx2 DB ?
    posbary2 DB 22
    posbloqx DB 22       ;vars que almacenan la posicion de los bloques
    posbloqy DB 7
    posbloqx2 DB 22
    posbloqy2 DB 7
    bloque    DB 178     ;var que almacena el caracter de los bloques
    cantBlox  DB ?
    bounce    DB 0,"$"   ;var que almacena el tipo de rebote de la bola
    x  DB ?              ;vars que almacenan la posicion de la bola
    y  DB 20 
    posbolax DB ?        
    posbolay DB 21
    limiteUP    DB 0
    limiteDOWN  DB 0     ;vars que almacenan los limites permitidos de movimiento (barra y bola)
    limiteLEFT  DB 0
    limiteRIGHT DB 0
    left    equ     4bh  ;constantes que almacenan las flechas direccionales
    right   equ     4dh
    up      equ     80
    down    equ     72         
    nombreArchivo db 'c:\ArchivoProyectoArquiArkanoid.txt',0 ; nombre de archivo y debe terminar en 0
    datasg ends
;---------------------------------
codesg segment 'code'  
    assume ds:datasg, cs:codesg, ss:stacksg
    
START:      
    
    mov ax,datasg
    mov ds,ax
    
   mov ah, 9      			
   lea dx, textoNom ;se imprime en pantalla        				
   int 21h
   
   
   mov ah,0ah
   lea dx,nombre   ;se pide el nombre del usuario
   int 21h 
   
 
   mov ah, 9      				
   lea dx, textoCar  ;se imprime en pantalla       				
   int 21h
   
   mov ah,1
   int 21h            ;se pide el caracter de juego
   mov caracter,al
   
   mov ah, 9      				
   lea dx, textoVid   ;se imprime en pantalla      				
   int 21h
   
   mov ah,1          ;se pide la cantidad de vidas
   int 21h
   
   cmp al,31h        ;se compara el numero ingresado y se salta a la etiqueta correspondiente
   je LIFE1
   
   cmp al,32h
   je LIFE2
   
   cmp al,34h
   je LIFE4
   
   cmp al,35h
   je LIFE5
   
   cmp al,36h
   je LIFE6
   
   cmp al,37h
   je LIFE7
   
   cmp al,38h
   je LIFE8
   
   cmp al,39h 
   je LIFE9 
      
   mov lifes,3       ;opcion de vidas por defecto (3 vidas)
   jmp CONTINUE 
   
LIFE1:              ;etiquetas que establecen la cantidad de vidas en el juego
   mov lifes,1
   jmp CONTINUE
   
LIFE2:
   mov lifes,2
   jmp CONTINUE
   
LIFE4:
   mov lifes,4
   jmp CONTINUE
   
LIFE5:
   mov lifes,5
   jmp CONTINUE
   
LIFE6:
   mov lifes,6
   jmp CONTINUE
   
LIFE7:
   mov lifes,7
   jmp CONTINUE
   
LIFE8:
   mov lifes,8
   jmp CONTINUE
   
LIFE9:
   mov lifes,9
    

CONTINUE:
   
   mov ah, 9      		;se imprime en pantalla		
   lea dx, textoDif         				
   int 21h
   
   mov ah, 9            ;se despliegan las opciones de dificultad
   lea dx, textEasy         				
   int 21h
   
   mov ah, 9      				
   lea dx, textMed         				
   int 21h
   
   mov ah, 9      				
   lea dx, textHard         				
   int 21h
   
   mov ah,1             ;se pide un numero al usuario
   int 21h
   mov difi,al
   
   pusha                ;se hace push para evitar ensuciar registros
   
   mov ax,0600h         ;se limpia la pantalla mediante la int 10h, servicio 6h
   mov bh,0fh           ;cx almacena el lugar de comienzo de limpieza
   mov cx,0000h         ;dx el lugar donde termina de limpiar la pantalla
   mov dx,184fh   
   int 10h 
                        ;se hace pop para recuperar registros limpios
   popa
   
   mov dl,0
   mov dh,0              ;dl guarda la posicion en x y dh la posicion en y
   mov ah,02h            ;se coloca el puntero el la posicion (0,0) gracias a la int 10, servicio 2
   int 10h
   
   mov ah, 9            
   lea dx, textoJug     ;se despliegan los datos del jugador (nombre, puntuacion y vidas)     				
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
   
   cmp difi,32h      ;se compara la dificultad ingresada por el usuario anteriormente
   je MED
   
   cmp difi,33h
   je HARD
    

EZ:    ;etiqueta de dificultad facil
    
    mov posbarx,28         ;se inicializan algunas variables
    mov posbarx2,28        ;se asignan los limites del tablero de juego,
    mov x,32               ;tamano de la barra, posicion de la barra, la bola
    mov posbolax,32        ;y los bloques, la cantidad de columnas de bloques 
    mov tambar, 8          ;y se salta al ciclo de juego (todo esto dependiendo de la
    mov limiteUP, 6        ;dificultad ingresada por el usuario)
    mov limiteDOWN, 23 
    mov limiteLEFT, 19
    mov limiteRIGHT, 43
    mov cantBlox, 7  
    jmp GAMEON 
    
MED:     ;etiqueta de dificultad media
    
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
    
HARD:     ;etiqueta de dificultad dificil
    
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
                 
BLOX proc       ;procedimiento que imprime los bloques en pantalla
   pusha        ;push para registros limpios
   mov dl,posbloqx
   mov dh,posbloqy    ;se coloca el puntero de acuerdo a las variables 
   mov ah,02h         ;que llevan la posicion de los bloques
   int 10h 
   
   mov     al, bloque ;se toma el caracter de bloque
   mov     ah, 09h    ;se llama al servicio 9 de la int 10h que sirve para imprimir caracteres
   mov     bl, 0ah ; se le asigna un color (en este caso, verde).
   mov     cx, 2   ; se da tamano a lo que se debe imprimir.
   int     10h     ;se imprime un bloque verde de 2 caracter de largo
   
   add posbloqx,3  ;se suma 3 a la posicion de los bloques para imprimir el siguiente bloque
   popa         ;pop para registros limpios
   ret          ;se retorna al lugar donde se ha llamado el procedimiento
    
endp BLOX      ;se finaliza el procedimiento


GAMEON:
   mov cx, cantBlox   
   mov bl,posbloqx2  ;se le asigna un valor a la cantidad de veces que debe imprimirse un bloque
   mov posbloqx,bl   ;al igual que su posicion en pantalla
    
IMPRIMIRBLOQUES:
   call BLOX         ;se llama al procedimiento de impresion de bloques
   dec cx            ;se decrementa el contador de bloques
   jnz IMPRIMIRBLOQUES   ;se continua el ciclo hasta que cx sea cero
   jmp FILAS  

FILAS: 

   cmp posbloqy,11  ;si la cantidad de filas impresas de bloques es 3, se salta a la siguiente etiqueta
   je IMPRIMIRBARRA
   
   inc posbloqy    ;si no, se aumenta la posicion en y de los bloques y se imprime otra serie de bloques
   inc posbloqy
   
   jmp GAMEON 
   
     
   
IMPRIMIRBARRA: 

   pusha

   mov dl,posbarx
   mov dh,posbary     ;se coloca el puntero en el lugar correspondiente
   mov ah,02h
   int 10h 
   
   mov     al, barrita  ;se asigna el caracter de la barra de juego
   mov     ah, 09h
   mov     bl, 0ah      ;color verde.
   mov     cx, tambar   ;tamano de la barra (8,6 o 4 caracteres, dependiendo del nivel).
   int     10h          ;se imprime la barra
      
   inc posbarx
           
   popa
   
   dec posbarx ; pos actual del cursor barra
   
   mov  ah,00h    ;se espera a que el usuario ingrese una tecla para empezar a jugar
   int  16h 
   
   pusha
   mov  ah,2Ch  
   int  21h     ; obtengo tiempo en minutos y segundos
   mov  minI,cl  
   mov  segI,dh  
   popa
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
   cmp bl,limiteLEFT ;si la posicion de la barra llego al limite establecido para la izquierda
   je PEDIRTECLA     ;vuelve a esperar una tecla y no se mueve la barra
   
   mov dl,posbarx
   mov dh,posbary    ;se coloca el cursor 
   mov ah,02h
   int 10h 
   
   mov     al, ' '
   mov     ah, 09h
   mov     bl, 0eh ;se borra el ultimo caracter de la barra
   mov     cx, 1   
   int     10h 
           
   mov al,posbarx
   sub al, tambar   ;se calcula el otro extremo de la barra restando el tamano de la barra a la posicion
                    ;actual de la barra
   mov finbar,al
   
   mov dl,finbar    ;se coloca el cursor
   mov dh,posbary     
   mov ah,02h
   int 10h
    
   mov     al, barrita
   mov     ah, 09h
   mov     bl, 0eh ; se imprime el caracter faltante de la barra, simulando el movimiento de la misma
   mov     cx, 1   
   int     10h
   
   dec posbarx 
     
   popa
   jmp PEDIRTECLA
   

   
MOVERBARRADER:     ;mismo procedimiento, diferente limite

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
   mov     bl, 0eh 
   mov     cx, 1 
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

MOVERUP:    ;etiqueta encargada del movimiento hacia arriba-derecha
    
   mov dl,x
   mov dh,y    ;se coloca el cursor en la posicion actual de la bola 
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32  ;se imprime un vacio
   int 21h
   
   dec y       ;se decrementa la posicion en y de la bola, simulando el movimiento hacia arriba
   inc x       ;se aumenta la posicion en x para el movimiento hacia la derecha
   
   mov dl,x
   mov dh,y    ;se coloca el cursor en la nueva posicion de la bola 
   mov ah,02h
   int 10h
   
   mov ah,08h   ;se llama la int 10, servicio 8, para leer el caracter en la nueva posicion
   int 10h
   
   mov bounce,1   ;se coloca el tipo de rebote de la bola, en caso de golpear un bloque
   
   cmp al,bloque  ;se compara el resultado de la int 10,servicio 8, si es un bloque se llama
   je REBOTE      ;la etiqueta rebote
   
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh  ;sino, se imprime la bola en su posicion nueva
   mov     cx, 1  
   int     10h 
   
   mov bl,limiteRIGHT
   cmp x,bl              ;si la nueva posicion llego al limite establecido para la derecha
   je MOVERUP2           ;se rebota contra la pared y cambia su curso hacia la izquierda
   
   mov bl,limiteUP       ;si la nueva posicion llego al limite superior, se rebota hacia abajo
   cmp y,bl
   je MOVERDOWN2
   
                         ;si la nueva posicion no llego a un limite o bloque, sigue subiendo
   jmp MOVERUP

MOVERDOWN:        ;mismo procedimiento, direccion abajo-izquierda
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   inc y            ;se aumenta la posicion en y para el movimiento hacia abajo
   dec x            ;se decrementa la posicion en x para el movimiento hacia la izquierda
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h 
   
   mov ah,08h
   int 10h 
   
   mov bounce,2     ;tipo de rebote, en caso de tocar bloque
   
   cmp al,bloque
   je REBOTE
                    ; si la nueva posicion toca la barra de juego se retorna a la posicion
   cmp al,barrita   ;en y mas cercana a la barra sin tocarla
   je RETURNUP2
   
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh 
   mov     cx, 1   
   int     10h 
    
   mov bl,limiteDOWN
   cmp y,bl          ;en caso de que la nueva posicion sea mas abajo que la barra, significa
   je PERDERVIDA     ;que la bola no se pudo salvar, es decir, se perdio una vida
   
   mov bl,limiteLEFT
   cmp x,bl            ;si se llega al limite izquierdo se rebota en la pared y sique bajando
   je MOVERDOWN2
        
                      ;sino, se sigue bajando tranquilamente
   jmp MOVERDOWN 
   
RETURNUP:             ;estas etiquetas se encargan de rebotar la bola en la barra de juego
   dec y              ;se incrementa y para que no se sobreescriba la bola sobre la barra
   jmp MOVERUP
   
RETURNUP2:
   dec y 
   jmp MOVERUP2      
         
MOVERUP2:         ; mismo procedimiento, direccion arriba-izquierda
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   dec y          ;se decrementan ambos valores para el movimiento hacia arriba-izquierda
   dec x
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah,08h
   int 10h 
   
   mov bounce,3   ;tipo de rebote si se impacto un bloque
   
   cmp al,bloque
   je REBOTE
   
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
   
   mov bl,limiteUP        ;si se llego al limite superior, se rebota y empieza a bajar
   cmp y,bl
   je MOVERDOWN
   
   mov bl,limiteLEFT      ;si se llego al limite izquierdo, se rebota y sube en la otra direccion
   cmp x,bl
   je MOVERUP
   
       
   jmp MOVERUP2  ;si nada paso, se sigue subiendo

crearArchivo proc      ; crear el archivo para guardar puntaje
    mov ax,@data
    mov ds,ax
    
    ;creacion
    mov ah,3ch
    mov cx,0
    mov dx,offset nombreArchivo
    int 21h
    
    mov bx,ax
    mov ah,3eh ;cierra el archivo
    int 21h
    ret
endp 

mostrarPuntajes proc
    mov ah,3dh
    mov al,1h
    mov dx,offset nombre
    int 21h
    
    
    
    mov ah,3eh ;Cierre de archivo
    int 21h
    endp
MOVERDOWN2:        ;mismo procedimiento, direccion abajo-derecha
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32
   int 21h
   
   inc y          ;se aumentan ambos ejes para el movimiento hacia abajo-izquierda
   inc x 
   
   mov dl,x
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah,08h
   int 10h 
   
   mov bounce,4   ;tipo de rebote (si se conecta con un bloque)
   
   cmp al,bloque
   je REBOTE
          
   cmp al,barrita    ;si golpea barra, se empieza a subir de nuevo
   je RETURNUP
          
   mov     al, caracter
   mov     ah, 09h
   mov     bl, 0fh ; attribute.
   mov     cx, 1   ; single char.
   int     10h 
    
   mov bl,limiteDOWN     ;si no se salva la bola, se pierde una vida
   cmp y,bl  
   je PERDERVIDA
   
   mov bl,limiteRIGHT
   cmp x,bl
   je MOVERDOWN
       
   jmp MOVERDOWN2
                      
                     
                     ;codigo para perder una vida
PERDERVIDA:
   mov al,lifes      ;se toma la variable de vidas y se le resta 1
   sub al,1
   
   mov lifes,al
   
   cmp al,0           ;si se llego a las cero vidas
   je GAMEOVER        ;se salta al fin de juego
   
   jmp RESET        ;si todavia quedan vidas extras, se resetea el juego donde quedo con una vida menos
   

REBOTE:      ;etiqueta que se encarga de administrar los tipos de rebote del juego a la hora de tocar un bloque
   
   call BORRARBLOQUE ; se llama al procedimiento para borrar bloques
   
   cmp bounce,1      ;se compara el tipo de rebote, dependiendo de la direccion en que venia la bola
   je MOVERDOWN2     ;y se retorna la funcion contraria, por ejemplo:
   
   cmp bounce,2      ;si se viene de arriba-izquierda, se retorna hacia abajo-izquierda.
   je MOVERUP2
                     ;rebote tipo 1: entra:arriba-der sale: abajo-der
   cmp bounce,3      ;rebote tipo 2: entra:abajo-izq  sale: arriba-izq
   je MOVERDOWN      ;rebote tipo 3: entra:arriba-izq sale: abajo-izq
                     ;rebote tipo 4: entra:abajo-der  sale: arriba-der
   cmp bounce,4
   je MOVERUP
   
   
   
   
BORRARBLOQUE proc ;procedimiento para borrar bloques

   mov ah, 2         				
   mov dl, 32    ;se imprime un vacio en la posicion establecida
   int 21h
   
   inc x         ;se incrementa la pos en x

   mov dl,x
   mov dh,y      ;se coloca el cursor
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32    ;se imprime otro vacio
   int 21h
   
   dec x         ;se devuelve la pos en x en 2
   dec x
   
   mov dl,x
   mov dh,y      ;se coloca el cursor (de nuevo...)
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, 32   ;se vuelve a imprimir otro vacio
   int 21h      ;este procedimiento se repite tanto a la derecha como a la izquierda del punto de impacto de la bola
                ;para borrar el bloque entero
   xor ax,ax
   mov al,score
   add al,5      ;se aumenta la puntuacion en 5 por bloque destruido
   mov score,al
   
   mov dl,47
   mov dh,1     
   mov ah,02h       ;se coloca el puntero en el lugar donde va el score
   int 10h
     
   pusha
   xor ax,ax       
   mov al,score      ;se imprime el nuevo score actualizado en pantalla
   call PRINT_NUM
   popa
                     ;se retorna hacia el lugar donde se llamo el procedimiento
   ret 
endp BORRARBLOQUE     
    
                   ; etiqueta que se encarga de resetear el juego despues de perder una vida
RESET:
   mov dl,50
   mov dh,1      ;se coloca el cursor en la esquina superior izquierda
   mov ah,02h
   int 10h
   
   mov ah, 9      				
   lea dx, textoVidas   ;se actualiza el texto y cantidad de vidas, luego de ser restada      				
   int 21h
   
   xor dx,dx       
   mov dl,lifes        ;se le suma 48 para traducir de ASCII a numero
   add dl,48

   mov ah,02h
   int 21h
   mov dl,x                ;se coloca el cursor donde estaba la bola al pasar el limite de perder una vida
   mov dh,y     
   mov ah,02h
   int 10h
   
   mov ah, 2        ;se borra la bola de la posicion donde estaba 				
   mov dl, 32
   int 21h
   
   mov dl,posbolax
   mov x,dl
   mov dh,posbolay  ;se coloca el cursor en la posicion de salida despues de perder una vida
   mov y,dh     
   mov ah,02h
   int 10h
   
   mov ah, 2         				
   mov dl, caracter   ;se imprime el caracter
   int 21h
   
   mov bl,posbarx2
   mov posbarx,bl        ;se asigna la posicion de salida de la barra
   
   
   
   jmp IMPRIMIRBARRA    ;se imprime la barra en ese lugar y se comienza el juego de nuevo
   

GAMEOVER: ;etiqueta de fin de juego  
   pusha
   
   mov  ah,2Ch  
   int  21h   
   mov  minF,cl  
   mov  segF,dh
   
   sub cl, minI
   mov minF,cl   ; calculo tiempo de juego
   
   sub dh, segI
   mov segF,dh
   
   popa


   pusha 
   mov ax,0600h   
   mov bh,0fh      ;se limpia la pantalla
   mov cx,0000h   
   mov dx,184fh   
   int 10h 
   popa
   
   mov dl,10
   mov dh,10    ;se coloca el cursor en la posicion (10,10) 
   mov ah,02h
   int 10h
   
   mov ah, 9      				
   lea dx, textoGO   ;se imprime el mensaje de "Game Over"      				
   int 21h 
   
   xor ax,ax       
   mov al,score
   call PRINT_NUM    ;se imprime la puntuacion

   ;;mov ax,02h
   ;int 21h 
   
   mov dl,22    ; columna
   mov dh,11    ;se coloca el cursor en la posicion (11,13) 
   mov ah,02h
   int 10h
   
   mov ah, 9      				
   lea dx, msgTime   ;se imprime el mensaje "su puntaje es de"      				
   int 21h 
   
   xor ax,ax       
   mov al,minF
   call PRINT_NUM    ;se imprimen los minutos de juego 
   
   mov ah, 9      				
   lea dx, msgTime1   ;se imprime el mensaje ":"      				
   int 21h 
   
   xor ax,ax       
   mov al,segF
   call PRINT_NUM    ;se imprimen los segundos de juego

   mov ax,02h
   int 21h
   
   mov ax,4c00h      ;se finaliza la ejecucion del programa
   int 21h 

   

DEFINE_PRINT_NUM         ;se definen los macros de imprimir numeros
DEFINE_PRINT_NUM_UNS
   
codesg ends
end start