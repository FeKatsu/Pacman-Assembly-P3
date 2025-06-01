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
L12   			STR		'<.............####.#####.####.#.#.#..........#.#.#.####.#####.####.............>', FIM_TEXTO
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
; Funcao desenha mapa
;------------------------------------------------------------------------------
WriteMap: PUSH R1
		  PUSH R2
		  PUSH R3
		  PUSH R4

		  MOV R4, M[TextIndex]

WriteCol: MOV R2, 0d

WriteChar:MOV R3, M[R4]
		  MOV R1, M[RowIndex]
		  SHL R1, ROW_SHIFT
		  OR  R1, R2
		  MOV M[CURSOR], R1
		  MOV M[IO_WRITE], R3
		  INC R2
		  INC R4
		  CMP R3, FIM_TEXTO
		  JMP.NZ WriteChar

		  INC M[RowIndex]
		  MOV R1, M[RowIndex]
		  CMP R1, M[RowLimit]
		  JMP.NZ WriteCol

EndWrite: POP R4
		  POP R3
		  POP R2
		  POP R1
		  RET

WriteMenu: PUSH R1
		   PUSH R2

		   MOV R1, L0
		   MOV M[TextIndex], R1
		   CALL WriteMap
 
		   POP R2
		   POP R1
 
		   RET

;------------------------------------------------------------------------------
; Relogio
;------------------------------------------------------------------------------

Timer: PUSH R1
	   PUSH R2
	   MOV R1, M[PacmanDirection]
	   
	   CMP R1, NO_DIRECTION
	   JMP.Z EndTimer ;NÃO FAZ NADA

	   CMP R1, UP
	   JMP.Z PacmanMovUp

	   CMP R1, DOWN
	   JMP.Z PacmanMovDown
	   
	   CMP R1, LEFT
	   JMP.Z PacmanMovLeft
	   
	   CMP R1, RIGHT
	   JMP.Z PacmanMovRight
	   

EndTimer: CALL ConfigTimer

	   	  POP R2
	   	  POP R1
	   	  RTI

ConfigTimer: PUSH R1
			 MOV R1, 10d
			 MOV M[TIMER_UNITS], R1
			 MOV R1, ON
			 MOV M[ACTIVATE_TIMER], R1
			 POP R1
			 RET

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
PacmanMovUp:   PUSH R1
               PUSH R2
               PUSH R3
			   JMP ColisaoUp 
  
ContinueUp:	   DEC M[PacmanRowIndex]
			   CALL PacmanErase			 
			   CALL PacmanPrint
			   JMP EndColisao
  
ColisaoUp:     MOV R1, M[PacmanColIndex]
               MOV R2, M[PacmanRowIndex]
			   DEC R2
               MOV R3, 81d
               MUL R3, R2
               ADD R2, R1
			   ADD R2, 8000h
               MOV R2, M[R2]
  
               MOV R3, '#'
			   CMP R2, R3 
               JMP.Z EndColisao
               JMP ContinueUp

PacmanMovDown: PUSH R1
			   PUSH R2
			   PUSH R3
			   JMP ColisaoD
			   
ContinueD:	   INC M[PacmanRowIndex]
			   CALL PacmanErase
			   CALL PacmanPrint
			   JMP EndColisao
  
ColisaoD:      MOV R1, M[PacmanColIndex]
               MOV R2, M[PacmanRowIndex]
			   INC R2
               MOV R3, 81d
               MUL R3, R2
               ADD R2, R1
			   ADD R2, 8000h
               MOV R2, M[R2]
  
               MOV R3, '#'
			   CMP R2, R3 
               JMP.Z EndColisao
               JMP ContinueD
  
PacmanMovLeft: PUSH R1
			   PUSH R2
			   PUSH R3
			   JMP ColisaoL
 
ContinueL:	   DEC M[PacmanColIndex]
			   CALL PacmanErase
			   CALL PacmanPrint
			   JMP EndColisao

ColisaoL: 	   MOV R1, M[PacmanColIndex]
               MOV R2, M[PacmanRowIndex]
			   DEC R1
               MOV R3, 81d
               MUL R3, R2
               ADD R2, R1
			   ADD R2, 8000h
               MOV R2, M[R2]
  
               MOV R3, '#'
			   CMP R2, R3 
               JMP.Z EndColisao
               JMP ContinueL

PacmanMovRight:PUSH R1
			   PUSH R2
			   PUSH R3
			   JMP ColisaoR

ContinueR:	   INC M[PacmanColIndex]
			   CALL PacmanErase
			   CALL PacmanPrint
			   JMP EndColisao

ColisaoR: 	   MOV R1, M[PacmanColIndex]
               MOV R2, M[PacmanRowIndex]
			   INC R1
               MOV R3, 81d
               MUL R3, R2
               ADD R2, R1
			   ADD R2, 8000h
               MOV R2, M[R2]
  
               MOV R3, '#'
			   CMP R2, R3 
               JMP.Z EndColisao
               JMP ContinueR

EndColisao:    POP R3
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

				CALL WriteMenu

				CALL PacmanPrint

				CALL ConfigTimer
				
				;--------------------------------------------------------------
				; Agora o codigo fica em ciclo infinito esperando que uma 
				; interrupcao seja accionada
				;--------------------------------------------------------------
Cycle: 			BR		Cycle	
Halt:           BR		Halt