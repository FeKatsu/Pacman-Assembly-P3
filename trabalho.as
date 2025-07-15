;------------------------------------------------------------------------------
; ZONA I: Definicao de constantes
;         Pseudo-instrucao : EQU
;------------------------------------------------------------------------------
CR              EQU     0Ah
FIM_TEXTO       EQU     '@'
IO_READ         EQU     FFFFh
IO_WRITE        EQU     FFFEh
IO_STATUS       EQU     FFFDh
INITIAL_SP      EQU     FDFFh
CURSOR		    EQU     FFFCh
CURSOR_INIT		EQU		FFFFh
ROW_POSITION	EQU		0d
COL_POSITION	EQU		0d
ROW_SHIFT		EQU		8d
COLUMN_SHIFT	EQU		8d
ROW_LIMIT		EQU 	24d
PacmanColInit	EQU		40d
PacmanRowInit	EQU		14d

Ghost1_x_Init	EQU     3d
Ghost1_y_Init	EQU 	3d

Ghost2_x_Init	EQU     78d
Ghost2_y_Init	EQU 	3d

Ghost3_x_Init	EQU     3d
Ghost3_y_Init	EQU 	21d

Ghost4_x_Init	EQU     78d
Ghost4_y_Init	EQU 	21d

TIMER_UNITS		EQU		FFF6h
ACTIVATE_TIMER  EQU		FFF7h
OFF				EQU		0d
ON				EQU     1d
NO_DIRECTION	EQU     0d
UP				EQU     1d
DOWN			EQU     2d
LEFT			EQU     3d
RIGHT			EQU     4d


;------------------------------------------------------------------------------
; ZONA II: definicao de variaveis
;          Pseudo-instrucoes : WORD - palavra (16 bits)
;                              STR  - sequencia de caracteres (cada ocupa 1 palavra: 16 bits).
;          Cada caracter ocupa 1 palavra
;------------------------------------------------------------------------------

                ORIG    8000h
;						   	  1 	    2         3         4         5        6          7         8

L0    			STR		'#####Vidas: 3 #######################Pacman#####################Score:00000#####', FIM_TEXTO
L1    			STR		'################################################################################', FIM_TEXTO
L2    			STR		'#     ....................................................................     #', FIM_TEXTO
L3    			STR		'#     .#.#######.#######.#####.##################.#####.#######.#######.#.     #', FIM_TEXTO
L4    			STR		'#     .#.#######.#...........#....................#...........#.#######.#.     #', FIM_TEXTO
L5    			STR		'######.#.........#.#########.#.##################.#.#########.#.........#.######', FIM_TEXTO
L6    			STR		'######.#.#######...#.........#.........##.........#.........#...#######.#.######', FIM_TEXTO
L7    			STR		'#........#######.#.#.#######.#########....#########.#######.#.#.#######........#', FIM_TEXTO
L8    			STR		'#.######.........#............................................#.........######.#', FIM_TEXTO
L9    			STR		'#.################...###.########.#####..#####.########.###...################.#', FIM_TEXTO
L10   			STR		'#..................#.###..........#..........#..........###.#..................#', FIM_TEXTO
L11   			STR		'##########..######.#.....####.#.#.#..........#.#.#.####.....#.######..##########', FIM_TEXTO
L12   			STR		'..............####.#####.####.#.#.#..........#.#.#.####.#####.####..............', FIM_TEXTO
L13   			STR		'###########.#...............#.#.#.#..........#.#.#...............#...###########', FIM_TEXTO
L14   			STR		'#...........#.#######.#######......................#######.#######.#...........#', FIM_TEXTO
L15   			STR		'#.#.#######.#.#.............#######.########.#######.............#.#.#######.#.#', FIM_TEXTO
L16   			STR		'#.#.........#.#.#####.#####..........................#####.#####.#.#.........#.#', FIM_TEXTO
L17   			STR		'#.#.#.#####.#.#.#####.#####.#.#######.#..#.#######.#.#####.#####.#.#.#####.#.#.#', FIM_TEXTO
L18   			STR		'#.#.#.......#.#.#####.#####.#....#....#..#....#....#.#####.#####.#.#.......#.#.#', FIM_TEXTO
L19   			STR		'#.#.#.###.###.#.#####.#####.####.#.####..####.#.####.#####.#####.#.###.###.#.#.#', FIM_TEXTO
L20   			STR		'#     ........#.......................#..#.......................#........     #', FIM_TEXTO
L21   			STR		'#     ###############.##.###.#.########..########.#.###.##.###############     #', FIM_TEXTO
L22   			STR		'#     ................##................................##................     #', FIM_TEXTO
L23   			STR		'################################################################################', FIM_TEXTO

;------------------------------------------------------------------------------
; Tela de game over
;------------------------------------------------------------------------------

L24    			STR		'################################################################################', FIM_TEXTO
L25    			STR		'################################################################################', FIM_TEXTO
L26    			STR		'################################################################################', FIM_TEXTO
L27    			STR		'################################################################################', FIM_TEXTO
L28    			STR		'#                                                                              #', FIM_TEXTO
L29    			STR		'#                ::::::::      :::     ::::    ::::  ::::::::::                #', FIM_TEXTO
L30    			STR		'#               :+:    :+:   :+: :+:   +:+:+: :+:+:+ :+:                       #', FIM_TEXTO
L31    			STR		'#               +:+         +:+   +:+  +:+ +:+:+ +:+ +:+                       #', FIM_TEXTO
L32    			STR		'#               :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#                  #', FIM_TEXTO
L33    			STR		'#               +#+   +#+# +#+     +#+ +#+       +#+ +#+                       #', FIM_TEXTO
L34   			STR		'#               #+#    #+# #+#     #+# #+#       #+# #+#                       #', FIM_TEXTO
L35   			STR		'#                ########  ###     ### ###       ### ##########                #', FIM_TEXTO
L36   			STR		'#                 ::::::::  :::     ::: :::::::::: :::::::::                   #', FIM_TEXTO
L37   			STR		'#                :+:    :+: :+:     :+: :+:        :+:    :+:                  #', FIM_TEXTO
L38   			STR		'#                +:+    +:+ +:+     +:+ +:+        +:+    +:+                  #', FIM_TEXTO
L39   			STR		'#                +#+    +:+ +#+     +:+ +#++:++#   +#++:++#:                   #', FIM_TEXTO
L40   			STR		'#                +#+    +#+  +#+   +#+  +#+        +#+    +#+                  #', FIM_TEXTO
L41   			STR		'#                #+#    #+#   #+#+#+#   #+#        #+#    #+#                  #', FIM_TEXTO
L42   			STR		'#                 ########      ###     ########## ###    ###                  #', FIM_TEXTO
L43   			STR		'#                                                                              #', FIM_TEXTO
L44   			STR		'################################################################################', FIM_TEXTO
L45   			STR		'################################################################################', FIM_TEXTO
L46   			STR		'################################################################################', FIM_TEXTO
L47   			STR		'################################################################################', FIM_TEXTO

;------------------------------------------------------------------------------
; Tela de vitória
;------------------------------------------------------------------------------

L48    			STR		'################################################################################', FIM_TEXTO
L49    			STR		'################################################################################', FIM_TEXTO
L50    			STR		'################################################################################', FIM_TEXTO
L51    			STR		'################################################################################', FIM_TEXTO
L52    			STR		'#                                                                              #', FIM_TEXTO
L53    			STR		'#                                                                              #', FIM_TEXTO
L54    			STR		'#                                                                              #', FIM_TEXTO
L55    			STR		'#                                                                              #', FIM_TEXTO
L56    			STR		'#  :::     ::: ::::::::::: :::::::: ::::::::::: ::::::::  :::::::::  :::   ::: #', FIM_TEXTO
L57    			STR		'#  :+:     :+:     :+:    :+:    :+:    :+:    :+:    :+: :+:    :+: :+:   :+: #', FIM_TEXTO
L58   			STR		'#  +:+     +:+     +:+    +:+           +:+    +:+    +:+ +:+    +:+  +:+ +:+  #', FIM_TEXTO
L59   			STR		'#  +#+     +:+     +#+    +#+           +#+    +#+    +:+ +#++:++#:    +#++:   #', FIM_TEXTO
L60   			STR		'#   +#+   +#+      +#+    +#+           +#+    +#+    +#+ +#+    +#+    +#+    #', FIM_TEXTO
L61   			STR		'#    #+#+#+#       #+#    #+#    #+#    #+#    #+#    #+# #+#    #+#    #+#    #', FIM_TEXTO
L62   			STR		'#      ###     ########### ########     ###     ########  ###    ###    ###    #', FIM_TEXTO
L63   			STR		'#                                                                              #', FIM_TEXTO
L64   			STR		'#                                                                              #', FIM_TEXTO
L65   			STR		'#                                                                              #', FIM_TEXTO
L66   			STR		'#                                                                              #', FIM_TEXTO
L67   			STR		'#                                                                              #', FIM_TEXTO
L68   			STR		'################################################################################', FIM_TEXTO
L69  			STR		'################################################################################', FIM_TEXTO
L70   			STR		'################################################################################', FIM_TEXTO
L71   			STR		'################################################################################', FIM_TEXTO

NADA			WORD 	' '
RowLimit 		WORD    24d
RowIndex		WORD	0d
ColumnIndex		WORD	0d
TextIndex		WORD	0d
Pacman			WORD	'C'
PacmanColIndex	WORD	PacmanColInit
PacmanRowIndex	WORD 	PacmanRowInit
Score			WORD 	0d
Imprimiu		WORD 	1d
PacmanDirection WORD	NO_DIRECTION
GhostDirection  WORD	NO_DIRECTION
Vidas			WORD    3d
Ghost			WORD 	'A'
GhostLastChar   WORD    '.'
Ghost1_x		WORD    Ghost1_x_Init
Ghost1_y		WORD 	Ghost1_y_Init
Ghost2_x		WORD    Ghost2_x_Init
Ghost2_y		WORD 	Ghost2_y_Init
Ghost3_x		WORD    Ghost3_x_Init
Ghost3_y		WORD 	Ghost3_y_Init
Ghost4_x		WORD    Ghost4_x_Init
Ghost4_y		WORD 	Ghost4_y_Init

;------------------------------------------------------------------------------
; ZONA III: definicao de tabela de interrupções
;------------------------------------------------------------------------------
                ORIG    FE00h
INT0            WORD    UpdatePacmanDirUp
INT1            WORD    UpdatePacmanDirLeft
INT2            WORD    UpdatePacmanDirDown
INT3            WORD    UpdatePacmanDirRight

				ORIG 	FE0Fh
INT15			WORD	Timer
				
;------------------------------------------------------------------------------
; ZONA IV: codigo
;        conjunto de instrucoes Assembly, ordenadas de forma a realizar
;        as funcoes pretendidas
;------------------------------------------------------------------------------
                ORIG    0000h
                JMP     Main

;------------------------------------------------------------------------------
; Relogio
;------------------------------------------------------------------------------

Timer: PUSH R1
	   PUSH R3
	   PUSH R4

	   MOV R3, M[Ghost1_x]
	   MOV R4, M[Ghost1_y]
	   CALL MoveGhost
	   MOV M[Ghost1_x], R3
	   MOV M[Ghost1_y], R4

	   MOV R3, M[Ghost2_x]
	   MOV R4, M[Ghost2_y]
	   CALL MoveGhost
	   MOV M[Ghost2_x], R3
	   MOV M[Ghost2_y], R4

	   MOV R3, M[Ghost3_x]
	   MOV R4, M[Ghost3_y]
	   CALL MoveGhost
	   MOV M[Ghost3_x], R3
	   MOV M[Ghost3_y], R4

	   MOV R3, M[Ghost4_x]
	   MOV R4, M[Ghost4_y]
	   CALL MoveGhost
	   MOV M[Ghost4_x], R3
	   MOV M[Ghost4_y], R4

	   MOV R1, M[PacmanDirection]
	   
	   CMP R1, NO_DIRECTION
	   JMP.Z EndTimer ;NÃO FAZ NADA

	   CMP R1, UP
	   CALL.Z PacmanMovUp

	   CMP R1, DOWN
	   CALL.Z PacmanMovDown
	   
	   CMP R1, LEFT
	   CALL.Z PacmanMovLeft
	   
	   CMP R1, RIGHT
	   CALL.Z PacmanMovRight
	   
	   CALL WinCheck


EndTimer: CALL ConfigTimer
		  POP R4
		  POP R3
	   	  POP R1
	   	  RTI

ConfigTimer: PUSH R1
			 MOV R1, 5d
			 MOV M[TIMER_UNITS], R1
			 MOV R1, ON
			 MOV M[ACTIVATE_TIMER], R1
			 POP R1
			 RET
			 
;------------------------------------------------------------------------------
; Funcao desenha mapa
;------------------------------------------------------------------------------
PrintString: PUSH R1
		  	 PUSH R2
		  	 PUSH R3
		  	 PUSH R4
		  	 MOV M[ColumnIndex], R0
		  	 MOV M[TextIndex], R0
	 
StringLoop: MOV R2, R1
			ADD R2, M[TextIndex]
			MOV R2, M[R2]
			CMP R2, FIM_TEXTO
			JMP.Z EndPrintString

			MOV R4, M[ColumnIndex]
			MOV R3, M[RowIndex]
			SHL R3, ROW_SHIFT
			OR R3, R4

			MOV M[CURSOR], R3
			MOV M[IO_WRITE], R2
			INC M[TextIndex]
			INC M[ColumnIndex]
			JMP StringLoop

EndPrintString: MOV M[ColumnIndex], R0
				POP R4
				POP R3
				POP R2
				POP R1
				RET

PrintMap: PUSH R1
		  PUSH R2

MapLoop: CALL PrintString
		 ADD R1, 81d
		 INC M[RowIndex]

		 CMP R1, R2
		 JMP.NP MapLoop

EndPrintMap: POP R2
			 POP R1
			 RET

;------------------------------------------------------------------------------
; Tela de game over
;------------------------------------------------------------------------------

PrintGameOver: PUSH R1
               PUSH R2
               PUSH R3
               
               MOV R3, 0d            ; Reseta o indice da linha para 0
               MOV M[RowIndex], R3
               
               MOV R1, L24           ; Endereço inicial do mapa de Game Over
               MOV R2, L47           ; Endereço final do mapa de Game Over

GameOverLoop:  CALL PrintString      ; Imprime uma linha do mapa
               ADD R1, 81d           ; Aponta para a proxima linha na memoria
               INC M[RowIndex]       ; Incrementa o indice da linha para a proxima impressao
               
               CMP R1, R2
               JMP.NP GameOverLoop   ; Continua se nao chegou ao fim do mapa

               POP R3
               POP R2
               POP R1
               JMP EndAll

;------------------------------------------------------------------------------
; Tela de vitória
;------------------------------------------------------------------------------

PrintVictory:  PUSH R1
               PUSH R2
               PUSH R3
               
               MOV R3, 0d            ; Reseta o indice da linha para 0
               MOV M[RowIndex], R3
               
               MOV R1, L48           ; Endereço inicial do mapa de Vitória
               MOV R2, L71           ; Endereço final do mapa de Vitória

VictoryLoop:   CALL PrintString   
               ADD R1, 81d         
               INC M[RowIndex]    
               
               CMP R1, R2
               JMP.NP VictoryLoop 

               POP R3
               POP R2
               POP R1
			   JMP EndAll

WinCheck: PUSH R1
		  MOV R1, M[Score]
		  CMP R1, 8630d
		  CALL.Z PrintVictory
		  POP R1
		  RET

;------------------------------------------------------------------------------
; Resets do game
;------------------------------------------------------------------------------

EndAll: MOV R1, OFF
        MOV M[ACTIVATE_TIMER], R1 ; Para o timer
        JMP Halt

Reset:  PUSH R1
        PUSH R2

        ;Apaga os fantasmas das suas posicoes atuais e reseta as posições dos fantasmas

		MOV R3, M[Ghost1_x]
        MOV R4, M[Ghost1_y]
        CALL GhostErase

		MOV R3, Ghost1_x_Init
        MOV R4, Ghost1_y_Init

        MOV M[Ghost1_x], R3
        MOV M[Ghost1_y], R4
        CALL GhostPrint


		MOV R3, M[Ghost2_x]
        MOV R4, M[Ghost2_y]
        CALL GhostErase
		MOV R3, Ghost2_x_Init
        MOV R4, Ghost2_y_Init

        MOV M[Ghost2_x], R3
        MOV M[Ghost2_y], R4
		CALL GhostPrint

		MOV R3, M[Ghost3_x]
        MOV R4, M[Ghost3_y]
        CALL GhostErase
		MOV R3, Ghost3_x_Init
        MOV R4, Ghost3_y_Init

        MOV M[Ghost3_x], R3
        MOV M[Ghost3_y], R4
		CALL GhostPrint

		MOV R3, M[Ghost4_x]
        MOV R4, M[Ghost4_y]
        CALL GhostErase

		MOV R3, Ghost4_x_Init
        MOV R4, Ghost4_y_Init

        MOV M[Ghost4_x], R3
        MOV M[Ghost4_y], R4
		CALL GhostPrint

        CALL PacmanErase
        ;Reseta as coordenadas do Pacman para as iniciais
        MOV R1, PacmanRowInit
        MOV R2, PacmanColInit   
        MOV M[PacmanRowIndex], R1
        MOV M[PacmanColIndex], R2
       
        ;Reseta a direcao do Pacman
        MOV R3, NO_DIRECTION
        MOV M[PacmanDirection], R3   


        CALL PacmanPrint

        POP R2
        POP R1
        RET
;------------------------------------------------------------------------------
; Pacman
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Funções de impressão
;------------------------------------------------------------------------------
PacmanPrint: PUSH R1
			 PUSH R2
			 PUSH R3
			 MOV R2, M[PacmanColIndex]
			 MOV R3, M[PacmanRowIndex]

			 SHL R3, ROW_SHIFT
			 OR  R3, R2
			 MOV M[CURSOR], R3

			 MOV R1, M[Pacman]
			 MOV M[IO_WRITE], R1

			 POP R3
			 POP R2
			 POP R1
			 RET

PacmanErase: PUSH R1
			 PUSH R2
			 PUSH R3
			 MOV R2, M[PacmanColIndex]
			 MOV R3, M[PacmanRowIndex]

			 SHL R3, ROW_SHIFT
			 OR  R3, R2
			 MOV M[CURSOR], R3

			 MOV R1, M[NADA]
			 MOV M[IO_WRITE], R1

			 POP R3
			 POP R2
			 POP R1
			 RET

;------------------------------------------------------------------------------
; Movimentação
;------------------------------------------------------------------------------
UpdatePacmanDirUp: PUSH R1
				   MOV R1, UP
				   MOV M[PacmanDirection], R1
				   POP R1
				   RTI

UpdatePacmanDirDown: PUSH R1
				   	 MOV R1, DOWN
				   	 MOV M[PacmanDirection], R1
				   	 POP R1
				   	 RTI

UpdatePacmanDirLeft: PUSH R1
				   	 MOV R1, LEFT
				   	 MOV M[PacmanDirection], R1
				   	 POP R1
				   	 RTI

UpdatePacmanDirRight: PUSH R1
				   	  MOV R1, RIGHT
				   	  MOV M[PacmanDirection], R1
				   	  POP R1
				   	  RTI

PacmanMove: PUSH R3
    		PUSH R4
    		PUSH R5
    		PUSH R6

    		; Calcula nova posição
    		MOV R3, M[PacmanRowIndex]
    		ADD R3, R1             ; nova linha

    		MOV R4, M[PacmanColIndex]
    		ADD R4, R2             ; nova coluna

    		; Testa colisão
    		MOV R5, R3
    		MOV R6, 81d
    		MUL R5, R6             ; R5 = nova_linha * 81
    		ADD R6, R4             ; R6 = posição linear
    		ADD R6, 8000h          ; endereço da posição na memória

    		MOV R6, M[R6]          ; caractere na posição
    		MOV R5, '#'
    		CMP R6, R5
    		JMP.Z EndMove          ; colisão, não move

			;Move pacman
    		CALL PacmanErase
    		ADD M[PacmanRowIndex], R1
    		ADD M[PacmanColIndex], R2
			CALL Portal
    		CALL PacmanPrint
			CALL Pontuacao

EndMove: POP R6
		 POP R5
		 POP R4
		 POP R3
		 RET

; Movimento para cima
PacmanMovUp: PUSH R1
    		 PUSH R2
    		 MOV R1, -1     ; linha -1 (cima)
    		 MOV R2, 0      ; coluna 0
    		 CALL PacmanMove
    		 POP R2
    		 POP R1
    		 RET

; Movimento para baixo
PacmanMovDown: PUSH R1
    		   PUSH R2
    		   MOV R1, 1
    		   MOV R2, 0
    		   CALL PacmanMove
    		   POP R2
    		   POP R1
    		   RET

; Movimento para esquerda
PacmanMovLeft: PUSH R1
    		   PUSH R2
    		   MOV R1, 0
    		   MOV R2, -1
    		   CALL PacmanMove
    		   POP R2
    		   POP R1
    		   RET

; Movimento para direita
PacmanMovRight: PUSH R1
    		   	PUSH R2
    		   	MOV R1, 0
    		   	MOV R2, 1
    		   	CALL PacmanMove
    		   	POP R2
    		   	POP R1
    		   	RET

;------------------------------------------------------------------------------
; Portal e pontuação
;------------------------------------------------------------------------------ 
Portal: PUSH R1
		PUSH R2
		MOV R1, M[PacmanColIndex]
		CMP R1, FFFFh
		JMP.Z PortalLeft
		MOV R2, 80d
		DIV R1, R2 ;R2 = x%80, R1= x/80
		MOV M[PacmanColIndex], R2

EndPortal: POP R2
		   POP R1
		   RET

PortalLeft: MOV R1, 79d
			MOV M[PacmanColIndex], R1
			JMP EndPortal

Pontuacao: PUSH R1
           PUSH R2
           PUSH R3 

           MOV R1, M[PacmanRowIndex]
           MOV R2, M[PacmanColIndex]   
           
           ; Pega posicao na memoria
           MOV R3, 81d
           MUL R1, R3
           ADD R3, R2
           ADD R3, 8000h          ; Endereco da posicao na memoria de video
           
           MOV R2, M[R3]
           MOV R1, '.'
           CMP R2, R1             ; Verifica se o caractere eh um ponto '.'
           JMP.NZ EndPont         ; Se nao for, finaliza a funcao
           
           ; Se for um ponto:
           MOV R1, 10d            ; Valor a ser adicionado ao score
           ADD M[Score], R1       ; Incrementa o score
           CALL PrintScore        ; <<< CHAMA A FUNCAO PARA ATUALIZAR A TELA
           MOV R1, ' '            ; Caractere de espaco para apagar o ponto na memória
           MOV M[R3], R1          ; Apaga o ponto do mapa

EndPont:   POP R3
           POP R2
           POP R1
           RET

;------------------------------------------------------------------------------
; Funcao para imprimir a pontuacao na tela
;------------------------------------------------------------------------------
PrintScore: PUSH R1
            PUSH R2
            PUSH R3
            PUSH R4
            PUSH R5
            PUSH R6

            MOV R1, M[Score]      
            MOV R2, 5d            ; R2 = contador de digitos (5)
            MOV R3, 10000d        ; R3 = divisor inicial para pegar digito a digito
            MOV R4, 70d           

ScoreLoop:  CMP R2, 0d            ; Se o contador de digitos for 0, termina
            JMP.Z EndPrintScore

			MOV R5, R3			  ; Salva o valor de R3 pois é alterado no DIV
            MOV R6, R1            ; Copia o valor atual do score para R6
            DIV R6, R3            
            ADD R6, '0'           ; Converte o digito para o caractere ASCII ('0'-'9')
			MOV R3, R5			  ; valor salvo de R3
            
            ; Posiciona o cursor para impressao
            PUSH R1               ; Fazendo uma "função aninhada"
            PUSH R3

            MOV R1, R0            
            SHL R1, ROW_SHIFT     
            OR  R1, R4            
            MOV M[CURSOR], R1     ; Define a posicao do cursor
            POP R3                
            POP R1                
            
            MOV M[IO_WRITE], R6   

            ; Prepara para a proxima iteracao
			MOV R5, R3
            DIV R1, R3
			MOV R1, R3           ; R1 agora guarda o resto da divisao (R1 = R1 % R3)
            MOV R6, 10d 
			MOV R3, R5          
            DIV R3, R6            ; Atualiza o divisor para o proximo digito (R3 = R3 / 10)
            
            INC R4                ; Vai para a proxima coluna
            DEC R2                ; Decrementa o contador de digitos
            JMP ScoreLoop         ; Repete o loop

EndPrintScore: POP R6	
               POP R5
               POP R4
               POP R3
               POP R2
               POP R1
               RET


;------------------------------------------------------------------------------
; Fantasma
;------------------------------------------------------------------------------
VerificaMorte: PUSH R1
               PUSH R2

               MOV R1, M[PacmanColIndex]
               MOV R2, M[PacmanRowIndex]

               CMP R1, R3      ; x de pacman e x de fantasma iguais
               JMP.NZ EndVerify 

               CMP R2, R4      ; y de pacman e y de fantasma iguais
               JMP.NZ EndVerify 
               
               ; Se chegar aqui x e y de fantasma e pacman são iguais
               CALL Die

EndVerify:     POP R2
               POP R1
               RET
			   
;Qual a última direção do fantasma? 
;Ajuda ele a não travar em paredes e a não voltar
;UpdateGhostDirUp: PUSH R1
;				   MOV R1, UP
;				   MOV M[GhostDirection], R1
;				   POP R1
;				   RET
;
;UpdateGhostDirDown: PUSH R1
;				   	 MOV R1, DOWN
;				   	 MOV M[GhostDirection], R1
;				   	 POP R1
;				   	 RET
;
;UpdateGhostDirLeft: PUSH R1
;				   	 MOV R1, LEFT
;				   	 MOV M[GhostDirection], R1
;				   	 POP R1
;				   	 RET
;
;UpdateGhostDirRight: PUSH R1
;				   	  MOV R1, RIGHT
;				   	  MOV M[GhostDirection], R1
;				   	  POP R1
;				   	  RET

VerificaCol:   PUSH R3
			   PUSH R4
			   PUSH R5
			   PUSH R6

    		   MOV R5, R4
    		   MOV R6, 81d
    		   MUL R5, R6             
    		   ADD R6, R3             
    		   ADD R6, 8000h          
    		   MOV R6, M[R6]          
 
    		   MOV R5, '#'
    		   CMP R6, R5
			   
			   POP R6
			   POP R5
			   POP R4
			   POP R3
			   RET
			   
EndGhost: POP R7
		  POP R6
		  POP R5
		  POP R2
		  POP R1
		  RET

GetLastChar: PUSH R3
			 PUSH R4			 
			 PUSH R6
			 
			 MOV R6, 81d
			 MUL R4, R6 
			 ADD R6, R3 
			 ADD R6, 8000h 
			 MOV R6, M[R6] 
			 MOV M[GhostLastChar], R6
			 POP R6
			 POP R4
			 POP R3
			 
			 RET 

MoveGhostY: CALL GetLastChar
			CALL GhostErase

			CALL VerificaMorte
			ADD R4, R1
			CALL VerificaMorte
			;CMP R1, 1d
			;CALL.Z UpdateGhostDirDown
			;CALL.NZ UpdateGhostDirUp

			CALL GhostPrint
			JMP EndGhost 
			

MoveGhostX: CALL GetLastChar
			CALL GhostErase
			

			CALL VerificaMorte
			ADD R3, R6
			CALL VerificaMorte

			;CMP R6, 1d
			;CALL.Z UpdateGhostDirDown
			;CALL.NZ UpdateGhostDirUp

			CALL GhostPrint
			JMP EndGhost

CalcDist: PUSH R1
		  PUSH R2
		  PUSH R3
		  PUSH R4

		  MOV R1, M[PacmanColIndex] ; Pacman no eixo x
		  MOV R2, M[PacmanRowIndex] ; Pacman no eixo y
		  ;R3 = fantasma no eixo x
		  ;R4 = fantasma no eixo y
		  
		  SUB R3, R1
		  SUB R4, R2

		  CMP R3, R0
		  CALL.N InverteX

		  CMP R4, R0
		  CALL.N InverteY
		  
		  ADD R3, R4 ;R3 é a distância
		  MOV R5, R3
		  
		  POP R4
		  POP R3
		  POP R2
		  POP R1
		  RET

InverteX: NEG R3
		  RET

InverteY: NEG R4
		  RET

MoveGhost:    PUSH R1
		   	  PUSH R2
		   	  PUSH R5
		   	  PUSH R6
		   	  PUSH R7

			  ;R3 - fantasma eixo x
			  ;R4 - fantasma eixo y

;CALCULA TODAS AS DISTÂNCIAS SEPARADAMENTE
DistUp:	 	  PUSH R4
			  ;PUSH R6
			  DEC R4
			  CALL VerificaCol
			  JMP.Z NoDistUp

			  ;MOV R6, M[GhostDirection]
			  ;CMP R6, DOWN
			  ;JMP.Z NoDistUp
			  ;POP R6

			  CALL CalcDist
			  MOV R1, R5
		 	  POP  R4
			  JMP DistDown  

NoDistUp:	  MOV R1, 999d
			  ;POP R6
			  POP R4
			  
DistDown:	  PUSH R4
			  ;PUSH R6
			  INC R4
			  CALL VerificaCol
			  JMP.Z NoDistDown
			  
			  ;MOV R6, M[GhostDirection]
			  ;CMP R6, UP
			  ;JMP.Z NoDistDown
			  ;POP R6

			  CALL CalcDist
			  MOV R2, R5
			  POP R4
			  JMP DistRight
			  
NoDistDown: MOV R2, 999d
			;POP R6
			POP R4

			  ;Calcula a posição x

DistRight: 	  PUSH R3
			  ;PUSH R1
			  INC R3
			  CALL VerificaCol
			  JMP.Z NoDistRight

			  ;MOV R1, M[GhostDirection]
			  ;CMP R1, LEFT
			  ;JMP.Z NoDistRight
			  ;POP R1

			  CALL CalcDist
			  MOV R6, R5
			  POP R3
			  JMP DistLeft

NoDistRight:  MOV R6, 999d
			  ;POP R1
			  POP R3

DistLeft:     PUSH R3
			  ;PUSH R1
			  DEC R3
			  CALL VerificaCol
			  JMP.Z NoDistLeft

			  ;MOV R1, M[GhostDirection]
			  ;CMP R1, RIGHT
			  ;JMP.Z NoDistLeft
			  ;POP R1

			  CALL CalcDist
			  MOV R7, R5
			  POP R3
			  JMP TakeDecision

NoDistLeft:   MOV R7, 999d
			  ;POP R1
			  POP R3

			  ;ESCOLHE A MENOR DISTÂNCIA PARA TOMAR DECISÃO
TakeDecision: CMP R1, R2 
			  CALL.N UpCMP ;R1 MENOR, R3-=1
			  CALL.NN DownCMP ;R2 MENOR, R3+=1

			  CMP R6, R7 
			  CALL.N DirCMP ;R6 MENOR, R4+=1
			  CALL.NN LeftCMP ;R6 MENOR, R4-=1

			  CMP R2, R7
			  JMP.N MoveGhostY
			  JMP MoveGhostX

UpCMP: MOV R2, R1
	MOV R1, -1
	RET

DownCMP: MOV R1, 1
	  RET

DirCMP: MOV R7, R6
	 MOV R6, 1
	 RET

LeftCMP:MOV R6, -1
	 RET

GhostErase:  PUSH R1
			 PUSH R3
			 PUSH R4

			 SHL R4, ROW_SHIFT
			 OR  R4, R3
			 MOV M[CURSOR], R4

			 MOV R1, M[GhostLastChar]
			 MOV M[IO_WRITE], R1
			 
			 POP R4
			 POP R3
			 POP R1
			 RET
			 
GhostPrint:  PUSH R1
			 PUSH R3
			 PUSH R4
			 SHL R4, ROW_SHIFT
			 OR  R4, R3
			 MOV M[CURSOR], R4

			 MOV R1, M[Ghost]
			 MOV M[IO_WRITE], R1

			 POP R4
			 POP R3
			 POP R1
			 RET


;--------------------------------------------------------------------------------------
;Perda de vida
;--------------------------------------------------------------------------------------			

Die: 	PUSH R1
		PUSH R2
		PUSH R5

		MOV R4, 12d
		MOV R1, M[Vidas]
		DEC R1
		MOV M[Vidas], R1

		ADD R1, '0'

		PUSH R1               
        PUSH R3
        MOV R1, R0            
        SHL R1, ROW_SHIFT     
        OR  R1, R4            
        MOV M[CURSOR], R1
        POP R3                
        POP R1                
        
        MOV M[IO_WRITE], R1   

		MOV R2, M[Vidas]
		CMP R2, R0
		CALL.Z PrintGameOver
		
		CALL Reset

		POP R5
		POP R2
		POP R1
		RET

;------------------------------------------------------------------------------
; Função Main
;------------------------------------------------------------------------------
Main:			ENI


				;----------------------------------------------------------------
				; Inicializacao de registradores / enderecos importantes do P3
				; (este codigo tem que fazer parte de todos os arquivos assembly)
				;----------------------------------------------------------------
				MOV		R1, INITIAL_SP
				MOV		SP, R1		 		; We need to initialize the stack
				MOV		R1, CURSOR_INIT		; We need to initialize the cursor 
				MOV		M[ CURSOR ], R1		; with value CURSOR_INIT

				;Printa mapa
				MOV R1, L0
				MOV R2, L23
				CALL PrintMap
				
				;Printa todos os fantasmas nas suas posições iniciais
				MOV R3, M[Ghost1_x]
				MOV R4, M[Ghost1_y]
				CALL GhostPrint

				MOV R3, M[Ghost2_x]
				MOV R4, M[Ghost2_y]
				CALL GhostPrint

				MOV R3, M[Ghost3_x]
				MOV R4, M[Ghost3_y]
				CALL GhostPrint

				MOV R3, M[Ghost4_x]
				MOV R4, M[Ghost4_y]
				CALL GhostPrint
				
				;Ìnicia o Score
				CALL PrintScore

				;Printa pacman na posição inicial 
				CALL PacmanPrint
				
				;Inicia timer
				CALL ConfigTimer
				
				;--------------------------------------------------------------
				; Agora o codigo fica em ciclo infinito esperando que uma 
				; interrupcao seja accionada
				;--------------------------------------------------------------
Cycle: 			BR		Cycle	
Halt:           BR		Halt