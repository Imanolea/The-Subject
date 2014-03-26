'' theSubject.bas
''
'' Clase principal

'' includes

#include once "fsp2.1.bas"
#include once "spriteset.bas"
#include once "charsetGraficos.bas"
#include once "charsetTextos.bas"
#include once "tileset.bas"
#include once "mapa.bas"
#include once "soundEffects.bas"
#include once "maze.bas"
#include once "clue.bas"
#include once "engine.bas"
#include once "ice.bas"
#include once "secret.bas"
#include once "piano.bas"
#include once "chess.bas"
#include once "music.bas"

'' Variables

dim isOver as uByte

'' Main

' Inicializar

border 0: paper 0: ink 7: bright 0: cls
fsp21SetGfxAddress (@spriteset (0))

isOver = 0
nPant = 6
isend = 0

pX = 12
pY = 12

menu()

while(NOT isend)

	' Si pulsamos N, dibujamos la anterior pantalla del mapa
	' Si pulsamos M, dibujamos la siguiente pantalla del mapa

	if  (in (32766) bAnd 8) = 0 and nPant > 0
        nPant = nPant - 1
        initScreen()
    elseif (in (32766) bAnd 4) = 0 and nPant < 15
        nPant = nPant + 1
        initScreen()
    end if
        
    if  (in (32766) bAnd 2) = 0
        initScreen()
    end if

	
	controlProccess()
	
	actualizarJugador()
	
	animacion()

	' Esperar
	asm
		halt
		halt
	end asm

wend

while (not isOver)
wend

end

''Subs

' Detectar las teclas pulsadas

sub controlProccess ()

	Dim up, down, left, right, action as uByte
	up = down = left = right = action = 0
	
	' Q pulsada
	if (in (64510) bAnd 1) = 0
		up = 1
	end if
	
	' A pulsada
	if (in (65022) bAnd 1) = 0
		down = 1
	end if
	
	' O pulsada
	if (in (57342) bAnd 2) = 0 
		left = 1
	end if
	
	' P pulsada
	if (in (57342) bAnd 1) = 0
		right = 1
	end if
	
	' K pulsada
	if (in (49150) bAnd 4) = 0
		if pAction = 0
			action = 1
		end if
	else
		pAction = 0
	end if
	
	proccessKeys(up, down, left, right, action)
	
end sub

sub actualizarJugador ()

	' Mover el sprite
	fsp21MoveSprite (0, mapoffsetx + pX, mapoffsety + pY)
	
	' Mueve el clon
	if (nPant = ice or nPant = secret)
		fsp21MoveSprite (1, mapoffsetx + cPX, mapoffsety + cPY)
	end if
	
	if (nPant = 1 or nPant = 8)
		' Actualizar Sprites
		fsp21UpdateSpritesn ()
	else
		fsp21UpdateSprites ()
	end if

end sub

sub initScreen ()

	mapoffsetx = mapabehaviour(nPant, 0)
	mapoffsety = mapabehaviour(nPant, 1)
	
	' Quitar pista
	
	if (nPant = maze and mapabehaviour(maze, 4) = -1)
		cambiaMapa(10, 0, nPant, 18)
		cambiaMapa(12, 0, nPant, 19)
		cambiaMapa(10, 22, nPant, 23)
		cambiaMapa(12, 22, nPant, 45)
		cambiaMapa(0, 10, nPant, 20)
		cambiaMapa(0, 12, nPant, 21)
		mapabehaviour(nPant, 4) = 0
	end if
	
	' Pintar pantalla
	pintaMapa(mapoffsetx, mapoffsety, nPant)
	
	' Configurar sprite
	
	fsp21ColourSprite(0, 0, 0, 0, 0)
	fsp21MoveSprite(0, pX, pY)
	fsp21DuplicateCoordinatesSprite(0)
	fsp21ActivateSprite(0) 
	fsp21SetGfxSprite (0, 0, 1, 2, 3) 
	
	if (nPant = ice)
		fsp21ColourSprite(1, 0, 0, 0, 0)
		fsp21MoveSprite(1, cPX, cPY)
		fsp21DuplicateCoordinatesSprite(1)
		fsp21ActivateSprite(1)
		fsp21SetGfxSprite (0, 8, 9, 2, 3)
		cPX = 18
		cPY = 0
	elseif (nPant = secret)
		fsp21ColourSprite(1, 0, 0, 0, 0)
		fsp21MoveSprite(1, cPX, cPY)
		fsp21DuplicateCoordinatesSprite(1)
		fsp21ActivateSprite(1)
		fsp21SetGfxSprite (0, 8, 9, 2, 3)
		cPX = 8
		cPY = 16
	else
		fsp21DeactivateSprite(1)
	end if
	
	fsp21InitSprites()

end sub

sub menu()
	
	print at 10, 11; "A game by"; at 12, 8; "Imanol Barriuso"
	pause 150
	cls
	pause 50
	pokeTextos()
	print at 10, 10; "!"; CHR (34); "# $%&'#(!"
	pause 150
	pokeNormal()
	print at 15, 12; CHR (34); "Act a"; CHR (34)
	pokeTextos()
	print at 15, 16; CHR (43)
	pokeGraficos()

end sub

function getPX()
	return pX + mapoffsetx
end function

function getPY()
	return pY + mapoffsety
end function

function getNPant()
	return nPant
end function