;******************************************************************************
;    Author: FABIO MACHADO                                                    
;    GitHub: https://github.com/MrFMach                                       
;******************************************************************************

;******************************************************************************
;List directives
	
    list p=18F4520		;directive to define processor
    
;******************************************************************************
;Includes
    
    #INCLUDE <P18F4520.INC>	;processor specific variable definitions

;******************************************************************************
;Configuration bits

    CONFIG  OSC = HS		;pic-board cristal cscillator = 20 MHz     

;******************************************************************************
;Reset Vector

RES_VECT    CODE    0x0000	;processor reset vector
    GOTO    START		;go to beginning of program

;******************************************************************************
;Add interrupts here if used
    
;******************************************************************************
;Main program

MAIN_PROG CODE			;let linker place main program
 
    DCounter1 EQU 0x0C
    DCounter2 EQU 0x0D
    DCounter3 EQU 0x0E

DELAY_1s:
    MOVLW 0x6D
    MOVWF DCounter1
    MOVLW 0x5E
    MOVWF DCounter2
    MOVLW 0x1A
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
    MOVLW 0xAC
    MOVWF DCounter1
    MOVLW 0x13
    MOVWF DCounter2
    MOVLW 0x06
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
    MOVLW B'00000000'
    MOVWF TRISB		;PORTB as output
    CLRF PORTB
    GOTO MAIN

MAIN:
    BSF PORTB,5		;set bit 5
    BSF PORTB,6		;set bit 6
    BSF PORTB,7		;set bit 7
    
    CALL DELAY_200ms
    
    BCF PORTB,5		;clear bit 5
    BCF PORTB,6		;clear bit 6
    BCF PORTB,7		;clear bit 7
    
    CALL DELAY_1s
    
    GOTO MAIN

;******************************************************************************
;End
    END