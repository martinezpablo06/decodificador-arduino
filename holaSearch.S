#define _SFR_ASM_COMPAT 1
#define __SFR_OFFSET 0 

#include <avr/io.h>
.data
.text

.global holaSearch

holaSearch:
;------------inicializo registros--------------------------

	movw r30, r24    ;muevo la direccion de la primera pos del arreglo a Z
	mov  r27, r22    ;muevo la cantidad de elementos del arreglo a r28
	ldi r18, 0       ;contador ciclo
	ldi r19, 1       ;bandera de posiciones contiguas
	ldi r16, 1       ;contador hola
	ldi r17, 0       ;variable de retorno

;-----------entro al loop, salvo los registros-----------
	loop:		
		push r19 
		push r18 
		push r27 
		push r30 
		push r31 

;----------------cargo elemento corriente y comparo---------------------

		ld r24, Z       ;leo lo que apunta Z 

		cpi r24, 104  	;comparo elemento corriente con h
		breq buscoH  
		cpi r24, 111   	;comparo elemento corriente con o
		breq buscoO
		cpi r24, 108   	;comparo elemento corriente con l
		breq buscoL
		cpi r24, 97     ;comparo elemento corriente con a
		breq buscoA 

		ldi r16, 1      ; si es otra letra reinicio elcontador hola
		jmp sigo

;----------------restaura los registros------------------------
	sigo:
		pop r31 
		pop r30 
		pop r27 
		pop r18 
		pop r19 
		adiw r30,1 		;incremento el indice del arreglo
		inc r18				;incremento el contador
		cp r18,r27 		;comparo indice - contador
		brne loop  		;salto por not equal
		mov r24, r17  ;retorno si encontro hola

ret

;---------------trato cada letra por separado-------------
		buscoH:
			cpi r16, 1 ;comparo indice - contador hola
			breq cpbandera
			jmp sigo

		buscoO:
			cpi r16, 2 ;comparo indice - contador hola
			breq cpbandera
			jmp sigo

		buscoL:
			cpi r16, 3 ;comparo indice - contador hola
			breq cpbandera
			jmp sigo

		buscoA:
			cpi r16, 4 ;comparo indice - contador hola
			breq cpbandera
			jmp sigo

;---------------verifico continuidad de las letras--------
		cpbandera:
			cpi r19, 1
			breq tratoOk  ;si las letras son contiguas
			brne tratoko  

		tratoOk:
			inc r16   ;incremento el contador hola
			inc r17		;incremento la variable de retorno
			jmp sigo

		tratoko:
			ldi r19, 0  ;si las letras no son contiguas
			ldi r16, 1  ;reinicio el contador hola
			jmp sigo




