
#define _SFR_ASM_COMPAT 1
#define __SFR_OFFSET 0 

#include <avr/io.h>
.data
.text

.global keyDecode

keyDecode:

	movw r30, r24 ; cargo la clave en z
	movw r28, r22 ; cargo en y el arreglo para el sentido de roleos
	ldi r20, 0		; inicializo registro auxiliar

		lsl r24			;shifteo 5 veces para acomodar la cantidad de roleos
		lsl r24  	
		lsl r24   	
		lsl r24
		lsl r24			;carry tiene el bit mas significativo

		rol r20			;con el carry cargo el registro auxiliar
		st Y, r20		;retorno en y la direccion de los roleos

		lsr r24  		;shifteo 5 veces para retornar la cantidad de roleos
		lsr r24   	
		lsr r24
		lsr r24
		lsr r24			

ret



