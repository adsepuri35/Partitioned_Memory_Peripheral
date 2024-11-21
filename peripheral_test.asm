; Test(ASM)
; Test Partitioned Memory Peripheral

ORG 0

	LOAD PASSWORD
    CALL SET_PERM
    OUT FourHex
	
	LOADI 1
    OUT TwoHex   ;2 digit Hex displays status of permisson bit
    CALL Delay
	
   
    ;Adds grades to Gradebook
    
    LOAD Grade1
	OUT P_Address
    OUT FourHex  ;displays adress trying to be accesed
    CALL Delay
    LOAD Student1Grade
    OUT P_R_W    ;writes grade to mem location
	OUT FourHex  ; display grade in gradebook
	
	CALL Delay
	
	LOAD Grade2
	OUT P_Address
    OUT FourHex  ;displays adress trying to be accesed
    CALL Delay
    LOAD Student2Grade
    OUT P_R_W    ;writes grade to mem location
	OUT FourHex  ; display grade in gradebook
	
	CALL Delay
	
	LOAD Grade3
	OUT P_Address
    OUT FourHex  ;displays adress trying to be accesed
    CALL Delay
    LOAD Student3Grade
    OUT P_R_W    ;writes grade to mem location
	OUT FourHex ; display grade in gradebook
	
	CALL Delay
	
	
	; trying to access gradebook without permissions
	
	LOADI 0
	CALL SET_PERM
	
	LOAD Grade1
	OUT P_Address
	OUT FourHex  ;displays address trying to be accesed
	CALL Delay
	IN P_R_W
	OUT FourHex	
	
	CALL Delay
	
	LOAD Grade2
	OUT P_Address
	OUT FourHex  ;displays address trying to be accesed
	CALL Delay
	IN P_R_W
	OUT FourHex	
	
	CALL Delay
	
	LOAD Grade3
	OUT P_Address
	OUT FourHex  ;displays address trying to be accesed
	CALL Delay
	IN P_R_W
	OUT FourHex	
	
	CALL Delay
	
	; Revert permissions to elevated permissions
	LOAD PASSWORD
	CALL SET_PERM
	LOADI 1
	OUT TwoHex
	
	CALL Delay
    
    ;Read grades and post it to post board
    
    LOAD Grade1
    OUT P_Address
    OUT FourHex  ;displays address trying to be accesed
	CALL Delay
    IN P_R_W	 ;read mem loation
    OUT  FourHex ;displays data accessed from mem phepripheral
    STORE TEMP
	LOAD StudentPost1
	OUT P_Address
    LOAD TEMP
    OUT P_R_W    ;writes grade to post board mem location
	
	CALL Delay
	
	LOAD Grade2
    OUT P_Address
    OUT FourHex  ;displays address trying to be accesed
	CALL Delay
    IN P_R_W	 ;read mem loation
    OUT  FourHex ;displays data accessed from mem phepripheral
    STORE TEMP
	LOAD StudentPost2
	OUT P_Address
    LOAD TEMP
    OUT P_R_W    ;writes grade to post board mem location
	
	CALL DELAY
	
	LOAD Grade3
    OUT P_Address
    OUT FourHex  ;displays address trying to be accesed
	CALL Delay
    IN P_R_W	 ;read mem loation
    OUT  FourHex ;displays data accessed from mem phepripheral
    STORE TEMP
    LOAD StudentPost3
	OUT P_Address
    LOAD TEMP
    OUT P_R_W    ;writes grade to post board mem location
	
	CALL DELAY
	
	
    ; Set to normal permissions and read from postboard
	LOAD ZERO
	CALL SET_PERM
	
	LOAD CLEAR
	OUT FourHex
	
	CALL Delay
	
	LOAD StudentPost1
	CALL TEST_READ
	
	LOAD StudentPost2
	CALL TEST_READ
	
	LOAD StudentPost3
	CALL TEST_READ
    
   	
    
   	END: JUMP END
    

TEST_READ:		 ;Starts by setting the mem pheripheral address to AC
	OUT P_Address
    OUT FourHex  ;displays address trying to be accesed
	CALL Delay
    IN P_R_W	 ;read mem loation
    OUT  FourHex ;displays data accessed from mem phepripheral
	CALL Delay
    RETURN
    
SET_PERM:
    OUT P_PERM   ;sets permission bit
    OUT TwoHex   ;2 digit Hex displays status of permisson bit
    RETURN
	
  
; To make things happen on a human timescale, the timer is
; used to delay for half a second.
Delay:
	OUT    Timer
WaitingLoop:
	IN     Timer
	ADDI   -30
	JNEG   WaitingLoop
	RETURN




;Numbers
Zero: DW 0
High: DW 1

LowerHalf: DW &H1111
UpperHalf: DW  &HEEEE

YOLO: DW &HABCD

TEMP: DW &HFFF

PASSWORD: DW &H1120

CLEAR: DW &HFFFF


Grade1: DW &HEEE0
Grade2: DW &HEEE1
Grade3: DW &HEEE2

StudentPost1: DW &H0000
StudentPost2: DW &H0001
StudentPost3: DW &H0002

Student1Grade: DW &H97
Student2Grade: DW &H86
Student3Grade: DW &H100

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
FourHex:   EQU 004
TwoHex:	   EQU 005
P_Address: EQU &H070
P_R_W:     EQU &H071  ;Read Write
P_PERM:    EQU &H072
