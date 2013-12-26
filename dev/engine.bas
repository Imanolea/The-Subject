'' engine.bas
''
'' Rutinas del juego

'' Constantes

Const TILESIZE As uByte = 2
Const PLAYERSIZE as uByte = 2
Const MAPWIDTH As uByte = 4
Const MAPHEIGHT As uByte = 4

const ice as uByte = 6
const maze as uByte = 4
const chess as uByte = 5
const piano as uByte = 7
const inicio as uByte = 8
const clue as uByte = 3
const secret as uByte = 1
const inception as uByte = 0

'' Variables

Dim mapscreenwidth As uByte = 16
Dim mapscreenheight As uByte = 12
Dim mapoffsetx as uByte = 0
Dim mapoffsety as uByte = 0

' Pantalla
Dim nPant as uByte

' Coordenadas

Dim pX, pY, pFrame, pAction as Byte

' Dirección

dim dir as Byte


'' Subs

' Control

sub proccessKeys (up as uByte, down as uByte, left as uByte, right as uByte, action as uByte)

	if up  or down or left or right
		if not ((left and right) or (up and down))
			if (not(nPant = ice and (dir or getCDir())) or (mapabehaviour(ice, 4) > 2 and dir = 0))
				if up
					if (nPant <> ice)
						pY = pY - 1
						checkPosition(0, -1, nPant)
					end if
					dir = 1
					setCDir(3)
				end if
				
				if down
					if (nPant <> ice)
						pY = pY + 1
						checkPosition(0, 1, nPant)
					end if
					dir = 3
					setCDir(1)
				end if
			
				if left
					if (nPant <> ice)
						pX = pX - 1
						checkPosition(-1, 0, nPant)
					end if	
					dir = 4
					setCDir(2)
				end if
				
				if right
					if (nPant <> ice)
						pX = pX + 1
						checkPosition(1, 0, nPant)
					end if
					dir = 2
					setCDir(4)
				end if
				
				doFrame()
			end if	
		else
			pFrame = 0
		end if
	elseif action = 1
		playerAction()
		pFrame = 5
		pAction = 1
	else
		pFrame = 0
	end if
	
	ajustarPos()
	
end sub

' Avanzar frame del jugador

Sub doFrame () 
	pFrame = pFrame + 1: if pFrame > 3 pFrame = 0: end if
End Sub

' Acción del jugador

sub playerAction ()

	' Pulsar botón
	
	if (pY = 2 and (pX = 14 or pX = 15))
		if (nPant = inicio and mapabehaviour(nPant, 4) = 0)
			makeSound(SOUNDBUTTON)
			Dim addr as uInteger
			addr = 22528 + 19 + 0
			poke addr, 96
			mapabehaviour(nPant, 4) = 1
		elseif (nPant = piano and mapabehaviour(nPant, 4) <> 24)
			pianoButton()
		end if
	end if

	if (nPant = chess and mapabehaviour(nPant, 4) = 0)
		colocaPieza(nPant)
	end if
end sub

' Frame de la animacion

sub animacion ()
	if pFrame = 0  or pFrame = 2  
		fsp21SetGfxSprite (0, 0, 1, 2, 3)  
	elseif pFrame = 1  
		fsp21SetGfxSprite (0, 8, 9, 10, 11)
	elseif pFrame = 3  
		fsp21SetGfxSprite (0, 16, 17, 18, 19)
	end if
	
	if pFrame = 5
		fsp21SetGfxSprite (0, 24, 25, 26, 27)
		if (nPant = ice)
			cAnimacion(pFrame)
		end if
		pFrame = 0
	elseif (nPant = ice)
		cAnimacion(pFrame)
	end if	
end sub

' Impide que el personaje salga de la pantalla

sub ajustarPos ()

	' Se desliza en caso de encontrarse sobre hielo
	
	if (nPant = ice)
		if (dir = 1)
			pY = pY - 1
			checkPosition(0, -1, nPant)
		elseif (dir = 2)
			pX = pX + 1
			checkPosition(1, 0, nPant)
		elseif(dir = 3)
			pY = pY + 1
			checkPosition(0, 1, nPant)
		elseif (dir = 4)
			pX = pX - 1
			checkPosition(-1, 0, nPant)
		end if
		if (mapabehaviour(ice, 4) < 3)
			cAjustarPos()
		end if
	end if			

	if pX < 0
		pX = 0
		dir = 0
	elseif pX > mapscreenwidth * TILESIZE - PLAYERSIZE
		pX = mapscreenwidth * TILESIZE - PLAYERSIZE
		dir = 0
	end if
	
	if pY < 0
		pY = 0
		dir = 0
	elseif pY > mapscreenheight * TILESIZE - PLAYERSIZE
		pY = mapscreenheight * TILESIZE - PLAYERSIZE
		dir = 0
	end if
end sub

' Realiza la interacción correspondiente con la posición del jugador
' Toma como parámetro el desplazamiento

sub checkPosition(despX as uByte, despY as uByte, n as uInteger)

	' Colisión con algo sólido
	
	if (getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY, n) >= 9 or _
		getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY, n) >= 9 or _
		getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY + 1, n) >= 9 or _
		getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY + 1, n) >= 9)
		pX = pX - despX
		pY = pY - despY
		dir = 0
	end if
	
	' Colisión con una puerta
	
	if (getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY, n) = 2 and _
		getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY, n) = 2 and _
		getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY + 1, n) = 2 and _
		getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY + 1, n) = 2)
		if (pX > pY and pY <= (mapscreenheight - mapoffsety) * 2 / 3)
			if (n = maze)
				if (salida = 1)
					laberinto = laberinto + 1
					if (laberinto = 5)
						nPant = nPant - MAPWIDTH
					end if	
				else
					laberinto = 0
				end if	
			elseif (n = inicio)
				nPant = maze
			else
				nPant = nPant - MAPWIDTH
			end if
			pY = (mapscreenheight - mapoffsety) * 2 - PLAYERSIZE - 1
		elseif (pX > pY and pX >= (mapscreenwidth - mapoffsetx) * 2 / 3 * 2)
			if (n = maze)
				if (salida = 2)
					laberinto = laberinto + 1
					if (laberinto = 5)
						nPant = nPant + 1
					end if	
				else
					laberinto = 0
				end if
			else
				nPant = nPant + 1
			end if
			pX = 1
		elseif (pY > pX and pY >= (mapscreenheight - mapoffsety) * 2 / 3 * 2)
			if (n = maze)
				if (salida = 3)		
					laberinto = laberinto + 1
					if (laberinto = 5)
						nPant = nPant + MAPWIDTH
					end if	
				else
					laberinto = 0
				end if	
			else
				nPant = nPant + MAPWIDTH
			end if
			pY = 1
		elseif (pY > pX and pX <= (mapscreenwidth - mapoffsetx) * 2 / 3)
			if (n = maze)
				if (salida = 4)
					laberinto = laberinto + 1
					if (laberinto = 5)
						nPant = nPant - 1
					end if	
				else
					laberinto = 0
				end if
			else
				nPant = nPant - 1
			end if
			pX = (mapscreenwidth - mapoffsetx) * 2 - PLAYERSIZE - 1
		end if
		initScreen()
	end if
	
	' Cerrar las puertas
	
	if (mapabehaviour(n, 2) = 1)
		if (getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY, n) < 2 and _
		getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY, n) < 2 and _
		getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY + 1, n) < 2 and _
		getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY + 1, n) < 2)
			fsp21MoveSprite(0, 0, 0)
			fsp21MinUpdateSprites ()
			if (mapabehaviour(n, 3) = 1)
				doorUp(n, 1)
			elseif (mapabehaviour(n, 3) = 2)
				doorRight(n, 1)
			elseif (mapabehaviour(n, 3) = 3)
				doorDown(n, 1)
			elseif (mapabehaviour(n, 3) = 4)
				doorLeft(n, 1)
			elseif (mapabehaviour(n, 3) = 5)
				doorUp(n, 1)
				doorRight(n, 1)
				doorDown(n, 1)
				doorLeft(n, 1)
				makeSound(SOUNDBOOM)
				cambiaMapa(12, 12, maze, 54)
				pintaTile(mapoffsetx + 12, mapoffsety + 12, 54)
			end if	
			mapabehaviour(n, 2) = 0
		end if
	end if
	
	' Interruptor pulsado
	
	if (getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY, n) = 1 and _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY, n) = 1 and _
	getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY + 1, n) = 1 and _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY + 1, n) = 1)
		mapabehaviour(n, 4) = mapabehaviour(n, 4) + 1
		fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
		if (getTileAt((mapoffsetx + pX) >> 1, (mapoffsety + pY) >> 1, n) = 22)
			cambiaMapa(pX, pY, n, 50)
			pintaTile(mapoffsetx + pX, mapoffsety + pY, 50)
		else
			cambiaMapa(pX, pY, n, 52)
			pintaTile(mapoffsetx + pX, mapoffsety + pY, 52)
		end if
		makeSound(SOUNDSWITCHON)
		
		if (n = inicio and mapabehaviour(n, 4) = 2)
			mapabehaviour(n, 4) = 3
			doorUp(n, 0)
			makeSound(SOUNDSUCCESS)
			addr = 22528 + 19 + 0
			poke addr, 80
		end if
	end if
	
	' Interruptor soltado
	
	if ((getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY, n) = 4 or _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY, n) = 4 or _
	getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY + 1, n) = 4 or _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY + 1, n) = 4) _
	and not (getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY, n) = 4 and _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY, n) = 4 and _
	getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY + 1, n) = 4 and _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY + 1, n) = 4))
		mapabehaviour(n, 4) = mapabehaviour(n, 4) - 1
		fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
		if (getTileAt((mapoffsetx + pX - despX) >> 1, (mapoffsety + pY - despY) >> 1, n) = 50)
			cambiaMapa(pX - despX, pY - despY, n, 22)
			pintaTile(mapoffsetx + pX - despX, mapoffsety + pY - despY, 22)
		else
			cambiaMapa(pX - despX, pY - despY, n, 51)
			pintaTile(mapoffsetx + pX - despX, mapoffsety + pY - despY, 51)
		end if
		makeSound(SOUNDSWITCHOFF)
	end if
	
	if (n = piano)
		pianoPos()
	end if
	
	' Agujero
	
	if (getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY, n) = 5 or _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY, n) = 5 or _
	getCharBehaviourAt(mapoffsetx + pX, mapoffsety + pY + 1, n) = 5 or _
	getCharBehaviourAt(mapoffsetx + pX + 1, mapoffsety + pY + 1, n) = 5)
		if (n = maze)
			nPant = ice
		elseif (n = ice)
			nPant = inception
		end if
		makeSound(SOUNDFALL)
		initScreen()
	end if
	
end sub

' Abrir/Cerrar puertas

sub doorUp(n as uInteger, close as uByte)
    makeSound (SOUNDDOOR)
	dim doorTile0, doorTile1 as uByte
	
	if (close)
		doorTile0 = 10
		doorTile1 = 11
	else
		doorTile0 = 18
		doorTile1 = 19
	end if
	cambiaMapa(10, 0, n, doorTile0)
	cambiaMapa(12, 0, n, doorTile1)
	pintaTile(mapoffsetx + 5 * 2, mapoffsety + 0 * 2, doorTile0)
	pintaTile(mapoffsetx + 6 * 2, mapoffsety + 0 * 2, doorTile1)
end sub

sub doorRight(n as uInteger, close as uByte)
    makeSound (SOUNDDOOR)
	dim doorTile0, doorTile1 as uByte
	
	if (close)
		doorTile0 = 16
		doorTile1 = 17
	else
		doorTile0 = 46
		doorTile1 = 47
	end if
	cambiaMapa(22, 10, n, doorTile0)
	cambiaMapa(22, 12, n, doorTile1)
	pintaTile(mapoffsetx + 11 * 2, mapoffsety + 5 * 2, doorTile0)
	pintaTile(mapoffsetx + 11 * 2, mapoffsety + 6 * 2, doorTile1)
end sub

sub doorDown(n as uInteger, close as uByte)
    makeSound (SOUNDDOOR)
	dim doorTile0, doorTile1 as uByte
	
	if (close)
		doorTile0 = 14
		doorTile1 = 15
	else
		doorTile0 = 23
		doorTile1 = 45
	end if
	
	cambiaMapa(10, 22, n, doorTile0)
	cambiaMapa(12, 22, n, doorTile1)
	pintaTile(mapoffsetx + 5 * 2, mapoffsety + 11 * 2, doorTile0)
	pintaTile(mapoffsetx + 6 * 2, mapoffsety + 11 * 2, doorTile1)
end sub

sub doorLeft(n as uInteger, close as uByte)
    makeSound (SOUNDDOOR)
	dim doorTile0, doorTile1 as uByte
	
	if (close)
		doorTile0 = 12
		doorTile1 = 13
	else
		doorTile0 = 20
		doorTile1 = 21
	end if
	
	cambiaMapa(0, 10, n, doorTile0)
	cambiaMapa(0, 12, n, doorTile1)	
	pintaTile(mapoffsetx + 0 * 2, mapoffsety + 5 * 2, doorTile0)
	pintaTile(mapoffsetx + 0 * 2, mapoffsety + 6 * 2, doorTile1)
end sub

' Pintado

sub pintaTile (x as uByte, y as uInteger, n as uByte)
	Dim addr as uInteger
	addr = 22528 + x + (y << 5)
	Print paper 8; ink 8; _
	At y, x; Chr (tileset (n, 1)); Chr (tileset (n, 3)); _
	At y + 1, x; Chr (tileset (n, 5)); Chr (tileset (n, 7));
	Poke addr, tileset (n, 0): Poke addr + 1, tileset (n, 2)
	Poke addr + 32, tileset (n, 4): Poke addr + 33, tileset (n, 6)
end Sub

sub pintaMapa (x as uByte, y as uByte, n as uInteger)
	Dim idx as uInteger
	Dim i as uByte
	Dim screenSize as uByte
	Dim mapscreenwidthInChars as uByte
	Dim xx, yy as uByte
	' Tamaño en bytes
	screenSize = mapscreenwidth * mapscreenheight
	mapScreenWidthInChars = TILESIZE * mapscreenwidth
	' Índice desde el que lee
	idx = n * screenSize

	' Bucle
	xx = x
	yy = y
	
	For i = 1 To screenSize
		pintaTile (xx, yy, mapa (idx))
		xx = xx + TILESIZE
		if xx = x + mapScreenWidthInChars
			xx = x
			yy = yy + TILESIZE
		end If
		idx = idx + 1
	next i
	
	if (n = maze)
		salida = pintaNumeros(mapoffsetx, mapoffsety)
		if (mapabehaviour(secret, 4) = 1 and mapabehaviour(chess, 4) = 1 and mapabehaviour(piano, 4) = 24 and mapabehaviour(clue, 4) = 1 and mapabehaviour(maze, 4) = 0)
			mapabehaviour(maze, 4) = 1
			mapabehaviour(maze, 2) = 1
		end if
	elseif (n = chess)
		pintaNumR()
	elseif (n = ice)
		pX = 18
		pY = 22
		makeSound(SOUNDDROP)
	elseif (n = inception)
		makeSound(SOUNDDROP)
	end if

end sub

sub cambiaMapa (x as uInteger, y as uInteger, n as uInteger, t as uByte)
	mapa (n * mapscreenwidth * mapscreenheight + (mapoffsety / 2 + y / 2) * mapscreenwidth + mapoffsetx / 2 + x / 2) = t
end sub

' Devuelve el valor del tile en x, y de la pantalla n
' x, y = coordenadas de tile
Function getTileAt (x as uByte, y as uByte, n as uInteger) as uByte
	return mapa (n * mapscreenwidth * mapscreenheight + y * mapscreenwidth + x)	
End Function

' Devuelve el comportamiento del tile en x, y de la pantalla n
' x, y = coordenadas de tile
Function getTileBehaviourAt (x as uByte, y as uByte, n as uInteger) as uByte
	return tileBehaviour (getTileAt (x, y, n))
End Function

' Devuelve el comportamiento del caracter en x, y de la pantalla n
' x, y = coordenadas de caracter
Function getCharBehaviourAt (x as uByte, y as uByte, n as uInteger) as uByte
   return getTileBehaviourAt (x >> 1, y >> 1, n)
End Function
