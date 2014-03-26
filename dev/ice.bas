'' ice.bas
''
'' Hielo

'' Variables

' Clon

Dim cPX as Byte = -2
Dim cPY as Byte = 0
Dim cDir as uByte


'' Métodos

sub cAnimacion (cPFrame as uByte)
	if cPFrame = 0  or cPFrame = 2  
		fsp21SetGfxSprite (1, 8, 9, 2, 3)  
	elseif cPFrame = 1  
		fsp21SetGfxSprite (1, 8, 9, 2, 4)
	elseif cPFrame = 3  
		fsp21SetGfxSprite (1, 8, 9, 5, 3)
	elseif cPFrame = 5
		fsp21SetGfxSprite (1, 10, 11, 12, 13)
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
	else
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
	
	' Colisión con algo sólido
	
	if (getCharBehaviourAt(cPX, cPY, n) >= 9 or _
		getCharBehaviourAt(cPX + 1, cPY, n) >= 9 or _
		getCharBehaviourAt(cPX, cPY + 1, n) >= 9 or _
		getCharBehaviourAt(cPX + 1, cPY + 1, n) >= 9)
		cPX = cPX - descPX
		cPY = cPY - descPY
		cDir = 0
	end if
	
	' Interruptor pulsado
	
	if (getCharBehaviourAt(cPX, cPY, n) = 1 and _
	getCharBehaviourAt(cPX + 1, cPY, n) = 1 and _
	getCharBehaviourAt(cPX, cPY + 1, n) = 1 and _
	getCharBehaviourAt(cPX + 1, cPY + 1, n) = 1)
		mapabehaviour(n, 4) = mapabehaviour(n, 4) + 1
		fsp21MoveSprite(1, 0, 0)
		fsp21MinUpdateSprites ()
		if (getTileAt((cPX) >> 1, (cPY) >> 1, n) = 22)
			cambiaMapa(cPX, cPY, n, 50)
			pintaTile(mapoffsetx + cPX, mapoffsety + cPY, 50)
		else
			cambiaMapa(cPX, cPY, n, 52)
			pintaTile(mapoffsetx + cPX, mapoffsety + cPY, 52)
		end if
		makeSound(5)
	end if
	
	' Interruptor soltado
	
	if ((getCharBehaviourAt(cPX, cPY, n) = 4 or _
	getCharBehaviourAt(cPX + 1, cPY, n) = 4 or _
	getCharBehaviourAt(cPX, cPY + 1, n) = 4 or _
	getCharBehaviourAt(cPX + 1, cPY + 1, n) = 4) _
	and not (getCharBehaviourAt(cPX, cPY, n) = 4 and _
	getCharBehaviourAt(cPX + 1, cPY, n) = 4 and _
	getCharBehaviourAt(cPX, cPY + 1, n) = 4 and _
	getCharBehaviourAt(cPX + 1, cPY + 1, n) = 4))
		mapabehaviour(n, 4) = mapabehaviour(n, 4) - 1
		fsp21MoveSprite(1, 0, 0)
		fsp21MinUpdateSprites ()
		if (getTileAt((cPX - descPX) >> 1, (cPY - descPY) >> 1, n) = 50)
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