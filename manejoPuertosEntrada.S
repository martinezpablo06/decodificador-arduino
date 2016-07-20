#define _SFR_ASM_COMPAT 1
#define __SFR_OFFSET 0 

#include <avr/io.h>
.data
.text


.global manejoPuertosEntrada

manejoPuertosEntrada:

	ldi r24,0b11111111   ;configuro puerto D para salida (pin 0 a 7 arduino)
	out DDRD,r24
	ldi r24,0b11100000   ;configuro puerto B entrada (pin 8 a 12 arduino) 
	in r24,	PINB				 ;leo la clave desde el dip switch

ret
