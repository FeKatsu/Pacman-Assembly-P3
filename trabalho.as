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

L0    			STR		'#####################################Pacman#####################Score:00000#####', FIM_TEXTO
L1    			STR		'################################################################################', FIM_TEXTO
L2    			STR		'#..............................................................................#', FIM_TEXTO
L3    			STR		'#..0...#.#######.#######.#####.##################.#####.#######.#######.#..0...#', FIM_TEXTO
L4    			STR		'#......#.#######.#...........#....................#...........#.#######.#......#', FIM_TEXTO
L5    			STR		'######.#.........#.#########.#.##################.#.#########.#.........#.######', FIM_TEXTO
L6    			STR		'######.#.#######...#.........#.........##.........#.........#...#######.#.######', FIM_TEXTO
L7    			STR		'#......#.#######.#.#.#######.#########....#########.#######.#.#.#######.#......#', FIM_TEXTO
L8    			STR		'#.######.........#............................................#.........######.#', FIM_TEXTO
L9    			STR		'#.################...###.########.#####..#####.########.###...################.#', FIM_TEXTO
L10   			STR		'#..................#.###..........#..........#..........###.#..................#', FIM_TEXTO
L11   			STR		'##########..######.#.....####.#.#.#..........#.#.#.####.....#.######..##########', FIM_TEXTO
L12   			STR		'..............####.#####.####.#.#.#..........#.#.#.####.#####.####..............', FIM_TEXTO
L13   			STR		'###########.#...............#.#.#.############.#.#...............#...###########', FIM_TEXTO
L14   			STR		'#...........#.#######.#######......................#######.#######.#...........#', FIM_TEXTO
L15   			STR		'#.#########.#.#.............#######.########.#######.............#.#.#########.#', FIM_TEXTO
L16   			STR		'#.#.........#.#.#####.#####..........................#####.#####.#.#.........#.#', FIM_TEXTO
L17   			STR		'#.#.#######.#.#.#####.#####.#.#######.#..#.#######.#.#####.#####.#.#.#######.#.#', FIM_TEXTO
L18   			STR		'#.#.#.......#.#.#####.#####.#....#....#..#....#....#.#####.#####.#.#.......#.#.#', FIM_TEXTO
L19   			STR		'#.#.#.#######.#.#####.#####.####.#.####..####.#.####.#####.#####.#.#######.#.#.#', FIM_TEXTO
L20   			STR		'#.............#.......................#..#.......................#.............#', FIM_TEXTO
L21   			STR		'#..0..###############.##.###.#.########..########.#.###.##.###############..0..#', FIM_TEXTO
L22   			STR		'#.....................##................................##.....................#', FIM_TEXTO
L23   			STR		'################################################################################', FIM_TEXTO




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
	   

EndTimer: CALL ConfigTimer
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
; Movimento do Pacman
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

			 MOV R1, M[NADA]
			 MOV M[IO_WRITE], R1

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
    		ADD R6, R4             ; R5 = posição linear
    		ADD R6, 8000h          ; endereço da posição na memória de vídeo

    		MOV R6, M[R6]          ; caractere na posição
    		MOV R5, '#'            ; obstáculo
    		CMP R6, R5
    		JMP.Z EndMove          ; colisão, não move

			;Move pacman
    		CALL PacmanErase
    		ADD M[PacmanRowIndex], R1
    		ADD M[PacmanColIndex], R2
			CALL Portal
    		CALL PacmanPrint

EndMove: POP R6
		 POP R5
		 POP R4
		 POP R3
		 RET

Portal: PUSH R1
		PUSH R2
		MOV R1, M[PacmanColIndex]
		CMP R1, FFFFh
		JMP.Z PortalLeft
		MOV R2, 80d
		DIV R1, R2 ;r2 = x%80, r1 = x/80
		MOV M[PacmanColIndex], R2

EndPortal: POP R2
		   POP R1
		   RET

PortalLeft: MOV R1, 79d
			MOV M[PacmanColIndex], R1
			JMP EndPortal

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
GetPositionMem: PUSH R1
    		    PUSH R2
    		    PUSH R3
    
    		    ; posição na tela
    		    MOV R1, M[PacmanRowIndex]
    		    MOV R2, M[PacmanColIndex]
    
    		    ; pega posição na memória
    		    MOV R3, 81d
    		    MUL R3, R2             ; R5 = nova_linha * 81
    		    ADD R2, R1             ; R5 = posição linear
    		    ADD R2, 8000h          ; endereço da posição na memória de vídeo

				MOV R2, M[R2] 
				MOV M[PosAtual], R2          ; caracter na memória
				POP R3
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

				MOV R1, L0
				MOV R2, L23
				CALL PrintMap

				CALL PacmanPrint

				CALL ConfigTimer
				
				;--------------------------------------------------------------
				; Agora o codigo fica em ciclo infinito esperando que uma 
				; interrupcao seja accionada
				;--------------------------------------------------------------
Cycle: 			BR		Cycle	
Halt:           BR		Halt