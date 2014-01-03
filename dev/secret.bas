'' secret
''
'' nueve puntos

'' Variables

dim moves as Byte

dim oX, oY as Byte
dim movX, movY as Integer
dim mov as uByte
dim cFrame as uByte
dim disT, disX, disY as Integer
dim antX, antY as Integer

'' Métodos

sub mueveClon (pX as uByte, pY as uByte, cX as Integer, cY as Integer)
	
	if (cX > pX)
		disX = cX - pX
	else
		disX = pX - cX
	end if
	
	if (cY > pY)
		disY = cY - pY
	else
		disY = pY - cY
	end if
	
	if (disX > disY)
		disT = disX
	else
		disT = disY
	end if
	
	movX = disX * 100 / disT
	movY = disY * 100 / disT
	
	antX = cX * 100
	antY = cY * 100
	
	oX = pX
	oY = pY
	mov = 1
	
	moves = moves - 1
	
	if (moves < 0)
		despulsar()
		moves = 4
		oX = cPX
		oY = cPY
	end if	
	pintaMoves()
end sub

sub actualizaClon (cX as Integer, cY as Integer)

	Dim aCX, aCY as Byte

	aCX = cX
	if (oX > cX)
		cX = (antX + movX) / 100
		antX = antX + movX
	elseif (oX < cX)
		cX = (antX - movX) / 100
		antX = antX - movX
	end if
	
	aCY = cY
	if (oY > cY)
		cY = (antY + movY) / 100
		antY = antY + movY
	elseif (oY < cY)
		cY = (antY - movY) / 100
		antY = antY - movY
	end if
	
	cPX = cX
	cPY = cY
	
	if (oX = cPX and oY = cPY)
		mov = 0
		cFrame = 1
	end if
	
	doCFrame()
	cAnimacion(cFrame)
	check()
end sub

sub check()
	if (getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY, nPant) = 1 and _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY, nPant) = 1 and _
	getCharBehaviourAt(mapoffsetx + cPX, mapoffsety + cPY + 1, nPant) = 1 and _
	getCharBehaviourAt(mapoffsetx + cPX + 1, mapoffsety + cPY + 1, nPant) = 1)
		mapabehaviour(nPant, 4) = mapabehaviour(nPant, 4) + 1
		fsp21MoveSprite(0, 0, 0)
		fsp21MoveSprite(1, 0, 0)
		fsp21MinUpdateSprites ()
		cambiaMapa(cPX, cPY, nPant, 50)
		pintaTile(mapoffsetx + cPX, mapoffsety + cPY, 50)
		makeSound(SOUNDSWITCHON)
	end if
	
	if (mapabehaviour(nPant, 4) = 9)
		oX = cPX
		oY = cPY
		fsp21DeactivateSprite(1)
		doorDown(nPant, 0)
		makeSound(SOUNDSUCCESS)
	end if
	
end sub

sub pintaMoves()
	Poke uInteger 23606, @charsetTextos (0) - 256
	print paper 0; ink 7; bright 1; at (mapoffsety), (mapoffsetx + 12); chr (CHRSTART + CHRNUMSTART + moves)
	Poke uInteger 23606, @charsetGraficos (0) - 256
end sub

sub despulsar()
	mapabehaviour(nPant, 4) = 0
	fsp21MoveSprite(0, 0, 0)
	fsp21MoveSprite(1, 0, 0)
	fsp21MinUpdateSprites ()
	dim cont as Byte = 0
	dim i, j as Byte
	for i = 4 to 8
		for j = 4 to 8
			if (getTileBehaviourAt(mapoffsetx/2 + j, mapoffsety/2 + i, secret) = 4)
				cambiaMapa(j * 2, i * 2, nPant, 22)
				pintaTile(mapoffsetx + j * 2, mapoffsety + i * 2, 22)
				makeSound(SOUNDSWITCHOFF)
			end if
		next j
	next i
end sub

' Avanzar frame del clon

Sub doCFrame () 
	cFrame = cFrame + 1: if cFrame > 3 cFrame = 0: end if
End Sub

function getMov()
	return mov
end function

sub setMoves(m as uByte)
	moves = m
end sub

function getMoves()
	return moves
end function
