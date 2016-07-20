#include "Arduino.h"

/* Ejemplo de invocación a rutina en Assembler AVR
 * La rutina printArray (escrita en assembler) imprime los elementos
 * de un arreglo pasado como parámetro.
 */
 
//Definiciones globales
#define size 8     //modificar de acuerdo ala longitud de numbers[]
char numbers[size]={50,49,52,183,54,176,53,30};
//char numbers[size]={100,98,104,111,108,97,106,60};
//char numbers[size]={'h','r','o','y','l','p','a','k','h','o'};
char b[size];    //almacena la cadena desncriptada
byte key;
byte cant;
byte dir[1];
byte r;
byte flag=0;       //Bandera para loop, para evitar el ciclo infinito ciclo infinino
byte flagkey=0;		 //bandera cambio de clave

//Funciones de inicialización
void setup();
void loop();

//se debe modificar el archivo de cabecera arduino.h
void printArduino(char val);

//Función en assembler definidas como externas.

extern "C" byte keyDecode(byte, byte *);
//recibe la clave y el arreglo vacio direccion, retorna la cantidad de roleos
//ademas, carga dir[0] con la direccion de los roleos

extern "C" void arrayDecode(char *,byte,char *,byte, byte);
//recibe el arreglo codificado, la longitud del mismo, la cantidad de roleos, 
//la direccion de estos y carga el segundo arreglo con el mensaje desencriptado

extern "C" byte holaSearch(char *,byte);
//recibe el arreglo decodificado y retorna 4 si encontro hola, y menor a 4 si no la encontro

extern "C" byte manejoPuertosEntrada();
//recibe los datos proveniente del dip-Switch y devuelve un elemento de tipo byte,
//el cual contiene la clave.

extern "C" void manejoPuertosSalida(byte); 
//recibe un byte, el cual indica la existencia o no de la sub-cadena “hola”, 
//luego enciende 2 leds amarillos en caso de que exista la sub-cadena, 
//o 2 leds rojos en caso contrario.  




//setup: inicializa la salida serial
void setup() {                
  Serial.begin(9600);
  key=manejoPuertosEntrada();		//inicializo clave
	flagkey=key;									//inicializo la bandera de cambio de clave
}

// cicla una vez y vuelve a cargar clave, en caso de ingresar otra clave
// actualiza los resultados (prende los leds correspondientes)

// nota: sostener firmemente el dip-Switch al probar varias claves 
// de lo contrario, suele hacer falso contacto y cicla varias veces el loop
void loop() {
	if (flag==0){
        Serial.println("Entro: ");	
        cant=(keyDecode(key,dir));
				Serial.println("cant");	
				Serial.println(cant);	
				Serial.println("dir");	
				Serial.println(dir[0]);	
        arrayDecode(numbers,size,b,dir[0],cant); 
				Serial.println("decode");   	//imprime arreglo decodificado
				for(int i=0;i<size;i++){
						Serial.println(b[i]);
				}
				r=(holaSearch(b,size));
        manejoPuertosSalida(r);    //prende los leds correspondientes
        Serial.println("Finalizo.");	
	}
		flag=1;
  	key=manejoPuertosEntrada();  //vuelve a cargar la clave
		if (key!=flagkey){   //si ingreso una clave nueva, vuelve a ciclar
			flagkey=key;
			flag=0;
		}
}

//printArduino: imprime un valor pasado como parámetro
void printArduino(char val){
  Serial.println(val);
}

