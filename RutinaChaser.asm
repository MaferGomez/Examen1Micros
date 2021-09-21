#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)
RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33
;inicio del programa:
START
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0
MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
MOVWF TRISB
BCF STATUS, RP0 ;Regresar al banco 0
 
INICIO:
 BCF STATUS, 0 
 MOVLW b'10000000'
 MOVWF PORTB
 call Tiempo
 RRF PORTB, 1
BTFSC STATUS, 0
goto $+3
call Tiempo
goto $-4
RLF PORTB, 1
BTFSC STATUS, 0
goto $-7
call Tiempo
goto $-4
 
   Tiempo:
movlw d'209' ;establecer valor de la variable k
movwf m
mloop:
decfsz m,f
goto mloop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
movlw d'27' ;establecer valor de la variable i
movwf i
iloop:
 ;NOPs de relleno (ajuste de tiempo)
movlw d'39' ;establecer valor de la variable j
movwf j
jloop:
 ;NOPs de relleno (ajuste de tiempo)

movlw d'19' ;establecer valor de la variable k
movwf k
kloop:
    nop
    nop
    nop
decfsz k,f
goto kloop
decfsz j,f
goto jloop
decfsz i,f
goto iloop
return
    END