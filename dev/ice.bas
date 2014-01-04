'' ice.bas
''
'' Hielo

' Sujeto

Dim deslizando as uByte

' Clon

Dim cPX, cPY as Byte
Dim cDir as uByte


'' Métodos

sub cAnimacion (cPFrame as uByte)
	if cPFrame = 0  or cPFrame = 2  
		fsp21SetGfxSprite (1, 16, 17, 18, 19)  
	elseif cPFrame = 1  
		fsp21SetGfxSprite (1, 20, 21, 22, 23)
	elseif cPFrame = 3  
		fsp21SetGfxSprite (1, 24, 25, 26, 27)
	elseif cPFrame = 5
		fsp21SetGfxSprite (1, 28, 29, 30, 31)
	end if
end sub

sub cAjustarPos()

	if (cDir = 1)
		cPY = cPY - 1
		cCheckPosition(0, -1, nPant)
	elseif (cDir = 2)
		cPX = cPX + 1
		cCheckPosition(1, 0, nPant)
	elseif(cDir = 3)
		cPY = cPY + 1
		cCheckPosition(0, 1, nPant)
	elseif (cDir = 4)
		cPX = cPX - 1
		cCheckPosition(-1, 0, nPant)
	end if
	
	if cPX < 0
		cPX = 0
		cDir = 0
	elseif cPX > mapscreenwidth * TILESIZE - PLAYERSIZE
		cPX = mapscreenwidth * TILESIZE - PLAYERSIZE
		cDir = 0
	end if
	
	if cPY < 0
		cPY = 0
		cDir = 0
	elseif cPY > mapscreenheight * TILESIZE - PLAYERSIZE
		cPY = mapscreenheight * TILESIZE - PLAYERSIZE
		cDir = 0
	end if
	
	if (mapabehaviour(ice, 4) = 2)
		mapabehaviour(ice, 4) = 5
		makeSound(SOUNDBOOM)
		cambiaMapa(12, 12, ice, 53)
		pintaTile(mapoffsetx + 12, mapoffsety + 12, 53)
		cPX = cPX - 1
		cCheckPosition(-1, 0, nPant)
		fsp21DeactivateSprite(1)
	end if
	
end sub	

sub cCheckPosition(descPX as uByte, descPY as uByte, n as uByte)
	
	' Colisión con algo sólido
	
	if (getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY, n) >= 9 or _
		getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY, n) >= 9 or _
		getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY + 1, n) >= 9 or _
		getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY + 1, n) >= 9)
		cPX = cPX - descPX
		cPY = cPY - descPY
		cDir = 0
	end if
	
	' Interruptor pulsado
	
	if (getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY, n) = 1 and _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY, n) = 1 and _
	getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY + 1, n) = 1 and _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY + 1, n) = 1)
		mapabehaviour(n, 4) = mapabehaviour(n, 4) + 1
		fsp21MoveSprite(1, 0, 0)
		fsp21MinUpdateSprites ()
		if (getTileAt((mapoffsetx + cPX) >> 1, (mapoffsety + cPY) >> 1, n) = 22)
			cambiaMapa(cPX, cPY, n, 50)
			pintaTile(mapoffsetx + cPX, mapoffsety + cPY, 50)
		else
			cambiaMapa(cPX, cPY, n, 52)
			pintaTile(mapoffsetx + cPX, mapoffsety + cPY, 52)
		end if
		makeSound(5)
	end if
	
	' Interruptor soltado
	
	if ((getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY, n) = 4 or _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY, n) = 4 or _
	getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY + 1, n) = 4 or _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY + 1, n) = 4) _
	and not (getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY, n) = 4 and _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY, n) = 4 and _
	getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY + 1, n) = 4 and _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY + 1, n) = 4))
		mapabehaviour(n, 4) = mapabehaviour(n, 4) - 1
		fsp21MoveSprite(1, 0, 0)
		fsp21MinUpdateSprites ()
		if (getTileAt((mapoffsetx + cPX - descPX) >> 1, (mapoffsety + cPY - descPY) >> 1, n) = 50)
			cambiaMapa(cPX - descPX, cPY - descPY, n, 22)
			pintaTile(mapoffsetx + cPX - descPX, cPY - descPY, 22)
		else
			cambiaMapa(cPX - descPX, cPY - descPY, n, 51)
			pintaTile(mapoffsetx + cPX - descPX, cPY - descPY, 51)
		end if
		makeSound(6)
	end if
	
end sub

sub setCDir (dir as uByte)
	cDir = dir
end sub

function getCDir()
	return cDir
end function

function getCPX()
	return cPX
end function

function getCPY()
	return cPY
end function