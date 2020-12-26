;******************************************************************************
;    Author: FABIO MACHADO                                                    
;    GitHub: https://github.com/MrFMach                                       
;******************************************************************************

;******************************************************************************
;Processor directive
	
    LIST P=18F4520		;directive to define processor
    
;******************************************************************************
;Includes
    
#INCLUDE <P18F4520.INC>	;processor specific variable definitions

;******************************************************************************
;Configuration bits

    CONFIG	OSC = HS	    ; Pic-board Cristal Oscillator = 20 MHz     

;******************************************************************************
;Reset Vector

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

;******************************************************************************
;Adicionar interrupções aqui, se for usado
    
    
;******************************************************************************
;Main

MAIN_PROG CODE                      ; let linker place main program
 
DCounter1 EQU 0X0C
DCounter2 EQU 0X0D
DCounter3 EQU 0X0E

DELAY_1s:
    MOVLW 0X6d
    MOVWF DCounter1
    MOVLW 0X5e
    MOVWF DCounter2
    MOVLW 0X1a
    MOVWF DCounter3
LOOPD1:
    DECFSZ DCounter1, 1
    GOTO LOOPD1
    DECFSZ DCounter2, 1
    GOTO LOOPD1
    DECFSZ DCounter3, 1
    GOTO LOOPD1
    RETURN
    
DELAY_200ms:
    MOVLW 0Xac
    MOVWF DCounter1
    MOVLW 0X13
    MOVWF DCounter2
    MOVLW 0X06
    MOVWF DCounter3
LOOPD2:
    DECFSZ DCounter1, 1
    GOTO LOOPD2
    DECFSZ DCounter2, 1
    GOTO LOOPD2
    DECFSZ DCounter3, 1
    GOTO LOOPD2
    NOP
    RETURN

START:
    MOVLW B'00000000'	;TODO O PORTB 
    MOVWF TRISB		;COMO SAIDA
    CLRF PORTB		;LIMPA PORTB
    GOTO MAIN

MAIN:
    BSF PORTB,5		;LIGA BIT 5
    BSF PORTB,6		;LIGA BIT 6
    BSF PORTB,7		;LIGA BIT 7
    
    CALL DELAY_200ms
    
    BCF PORTB,5		;LIGA BIT 5
    BCF PORTB,6		;LIGA BIT 6
    BCF PORTB,7		;LIGA BIT 7
    
    CALL DELAY_1s
    
    GOTO MAIN

;******************************************************************************
;End
    END