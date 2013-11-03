'' engine.bas
''
'' Rutinas del juego

'' Constantes

Const TILESIZE As uByte = 2
Const PLAYERSIZE as uByte = 2
Const MAPWIDTH As uByte = 4
Const MAPHEIGHT As uByte = 4

'' Variables

Dim mapscreenwidth As uByte = 16
Dim mapscreenheight As uByte = 12
Dim mapoffsetx as uByte = 0
Dim mapoffsety as uByte = 0

' Pantalla
Dim nPant as uByte

' Coordenadas

Dim pX, pY, pFrame, pAction as Byte


'' Subs

' Control

sub proccessKeys (up as uByte, down as uByte, left as uByte, right as uByte, action as uByte)

	if up  or down or left or right
		if not ((not up and not down and left and right) or (up and down and not left and not right))
		
			if up
				pY = pY - 1
			end if
			
			if down
				pY = pY + 1
			end if
			
			if left
				pX = pX - 1
			end if
			
			if right
				pX = pX + 1
			end if
			
			doFrame()
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
end sub

' Frame de la animacion

sub animacion ()
	if pFrame = 0  or pFrame = 2  
		fsp21SetGfxSprite (0, 0, 1, 2, 3)  
	elseif pFrame = 1  
		fsp21SetGfxSprite (0, 8, 9, 10, 11)
	elseif pFrame = 3  
		fsp21SetGfxSprite (0, 16, 17, 18, 19)
	elseif pFrame = 5
		fsp21SetGfxSprite (0, 24, 25, 26, 27)
		pFrame = 0
	end if
end sub

' Impide que el personaje salga de la pantalla

sub ajustarPos ()
	if pX < mapoffsetx
		pX = mapoffsetx
	elseif pX > mapoffsetx + mapscreenwidth * TILESIZE - PLAYERSIZE
		pX = mapoffsetx + mapscreenwidth * TILESIZE - PLAYERSIZE
	end if
	
	if pY < mapoffsety
		pY = mapoffsety
	elseif pY > mapoffsety + mapscreenheight * TILESIZE - PLAYERSIZE
		pY = mapoffsety + mapscreenheight * TILESIZE - PLAYERSIZE
	end if
end sub

' Pintado

Sub pintaTile (x as uByte, y as uInteger, n as uByte)
	Dim addr as uInteger
	addr = 22528 + x + (y << 5)
	Print paper 8; ink 8; _
	At y, x; Chr (tileset (n, 1)); Chr (tileset (n, 3)); _
	At y + 1, x; Chr (tileset (n, 5)); Chr (tileset (n, 7));
	Poke addr, tileset (n, 0): Poke addr + 1, tileset (n, 2)
	Poke addr + 32, tileset (n, 4): Poke addr + 33, tileset (n, 6)
End Sub

Sub pintaMapa (x as uByte, y as uByte, n as uInteger)
	Dim idx as uInteger
	Dim i as uByte
	Dim screenSize as uByte
	Dim mapscreenwidthInChars as uByte
	Dim xx, yy as uByte
	' Size in bytes:
	screenSize = mapscreenwidth * mapscreenheight
	mapScreenWidthInChars = TILESIZE * mapscreenwidth
	' Read from here:
	idx = n * screenSize

	' Loop
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

end sub
