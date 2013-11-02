'' theSubject.bas
''
'' Clase principal

'' includes

#include once "charsetGraficos.bas"
#include once "charsetTextos.bas"
#include once "tileset.bas"
#include once "mapa.bas"
#include once "engine.bas"

'' Constantes


'' Variables

Dim isOver as uByte

'' Main

' Inicializar

border 0: paper 0: ink 7: bright 0: cls
poke uInteger 23606, @charsetGraficos (0) - 256

isOver = 0
nPant = 0

initScreen()

while(NOT isOver)

	' Si pulsamos P, dibujamos la siguiente pantalla en el mapa
	' Si pulsamos O, dibujamos la pantalla anterior del mapa
	
	if  (in (57342) bAnd 1) = 0 and nPant < 15
		nPant = nPant + 1
		initScreen()
	elseif (in (57342) bAnd 2) = 0 and nPant > 0
		nPant = nPant - 1
		initScreen()
	end if	

wend

end

''Subs

sub initScreen ()

	' Pintar pantalla
	
	pintaMapa(mapoffsetx, mapoffsety, nPant)

end sub