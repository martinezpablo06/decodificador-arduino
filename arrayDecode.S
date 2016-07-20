#define _SFR_ASM_COMPAT 1
#define __SFR_OFFSET 0 

#include <avr/io.h>
.data
.text

.global arrayDecode

arrayDecode:

;------------inicializo registros--------------------------
	movw r30, r24 ;muevo la primera pos del arreglo a Z
	mov  r27, r22 ;muevo la cantidad de elementos del arreglo a r27
	movw r28, r20 ;muevo la primera pos del arreglo a Y
	mov  r26, r18 ;muevo la direccion de roleos
	mov  r23, r16 ;muevo la cantidad de roleos
	ldi r18, 0    ;control del loop    
	ldi r17, 0    ;aux para roleo  
	ldi r22, 0    ;control cantidad de roleos

;-----------entro al loop, salvo los registros-----------
	loop:		
		push r17
		push r18 
		push r22
		push r23 
		push r26 
		push r27 
		push r28 
		push r30 
		push r31 

;----------------cargo elemento corriente y comparo---------------------

		ld r24, Z 		;leo lo que apunta Z 
		mov r17, r24  ;asigno el elemento corriente a un auxiliar

		cpi r23,0			;si la cantidad de roleos es 0 no trato
		breq no_trato

    cpi r26, 1    ;identifico la direccion de roleos
		breq izq

;----------------trato elemento corriente----------------------------------
  der:
		cp r22, r23		;comparacion entre el contador de ciclo-cantidad de roleos
		breq sigo
		lsr r17				;shifteo para poder realizar los roleos correctamente
		ror r24
		inc r22				;incremento contador de ciclo
		jmp der

	izq:
		cp r22, r23		;comparo contador de ciclo con la cantidad de roleos
		breq sigo
		lsl r17				;shifteo para poder realizar los roleos correctamente
		rol r24
		inc r22				;incremento contador de ciclo
		jmp izq

	no_trato:
		inc r22

;----------------restaura los registros------------------------
	sigo: 
		st Y, r24   ; guardo en arreglo b
		pop r31 
		pop r30 
		pop r28 
		pop r27
		pop r26 
		pop r23 
		pop r22 
		pop r18 
		pop r17

;---------------condicion del loop----------------------------

		adiw r30,1 		;incremento el indice del arreglo
		adiw r28,1 		;incremento el indice del arreglo
		inc r18 			;incremento el contador
		cp r18,r27		;comparo indice - contador
		brne loop  		;salto por not equals



ret

