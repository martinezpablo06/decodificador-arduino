#define _SFR_ASM_COMPAT 1
#define __SFR_OFFSET 0 

#include <avr/io.h>
.data
.text


.global manejoPuertosSalida

manejoPuertosSalida:

	ldi r20,0b11111111  ;configuro puerto D para salida (pin 0 a 7 arduino)
	out DDRD,r20

	cpi	r24,4						;holaSearh retorna 4 en r si encontro
	brne	no_encontro		;si no encontro el 'hola'

	;si encontro el hola
	ldi r22,3						;selecciona los leds de color amarillo
	jmp salida						

	no_encontro:
		ldi r22,12				;selecciona los leds de color rojo
		jmp salida

	salida:
		lsl r22           ;shiftea r16 dos veces para luego 
		lsl r22 					;poder sacarlos por el Puerto D
		out PORTD,r22			;enciende los leds

ret



