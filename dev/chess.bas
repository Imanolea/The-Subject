'' chess.bas
'' 
'' Ajedrez

'' Variables

' Posicion imaginaria de las piezas

dim cPosP (15) as uByte => { _
    22, 52, _
	26, 54, _
	30, 56, _
	34, 58, _
	24, 60, _
	20, 62, _
	32, 64, _
	28, 66}
	
' Posición real/imaginaria de las piezas

Dim posP (15) as uByte => { _
    22, 52, _
	26, 54, _
	30, 56, _
	34, 58, _
	24, 60, _
	20, 62, _
	32, 64, _
	28, 66}
	
' Número de reinas

Dim numR as uByte = 8

'' Funciones

' Realiza las acciones relativas a la interaccion con el tablero

sub colocaPieza(n as uByte)
	if (pY>=4 and pY<=18 and pX>=4 and pX<=18 and pY/2*2=pY and pX/2*2=pX)
		Dim hay as uByte = 0
		for i=0 to 8
			if (posP(i*2)=pX and posP(i*2+1)=pY)
			    hay=1
				posP(i*2) = cPosP(i*2)
				posP(i*2 + 1) = cPosP(i*2 +1)
				i = 9
			end if
		next i
			
		if (not hay and numR>0)
			for i=0 to 8
				if (posP(i*2)>=20)
			        posP(i*2) = pX
				    posP(i*2 + 1) = pY
				    i = 9
			    end if
		    next i		
		    makeSound (2)
	        fsp21MoveSprite(0, 0, 0)
	        fsp21MinUpdateSprites ()
	        pintaPieza(mapoffsetx + pX, mapoffsety + pY)
		    numR=numR-1
		    pintaNumR()
			comprobarPos(n)
		elseif (hay)
		    makeSound (3)
			fsp21MoveSprite(0, 0, 0)
	        fsp21MinUpdateSprites ()
			pintaTile(mapoffsetx + pX, mapoffsety + pY, getTileAt((mapoffsetx + pX) >> 1, (mapoffsety + pY) >> 1, n))
			numR=numR+1
			pintaNumR()
			comprobarPos(n)
		end if	    
	end if
end sub

' Pinta el número de reinas

sub pintaNumR ()
	Poke uInteger 23606, @charsetTextos (0) - 256
	print paper 0; ink 7; bright 1; at (mapoffsety), (mapoffsetx + 12); chr (CHRSTART + CHRNUMSTART + numR)
	Poke uInteger 23606, @charsetGraficos (0) - 256
end sub

' Pinta la pieza en el tablero

sub pintaPieza (x as uByte, y as uInteger)
	Dim addr as uInteger
	addr = 22528 + x + (y << 5)
	Print paper 8; ink 0; bright 1; _
	At y, x; Chr (tileset (40, 1)); Chr (tileset (40, 3)); _
	At y + 1, x; Chr (tileset (40, 5)); Chr (tileset (40, 7));
end sub

sub comprobarPos (n as uByte)
    Dim addr as uInteger
    if (posP(0)<>posP(2) and posP(0)<>posP(4) and posP(0)<>posP(6) and posP(0)<>posP(8) and posP(0)<>posP(10) and posP(0)<>posP(12) and posP(0)<>posP(14) and posP(2)<>posP(4) _
	and posP(2)<>posP(6) and posP(2)<>posP(8) and posP(2)<>posP(10) and posP(2)<>posP(12) and posP(2)<>posP(14) and posP(4)<>posP(6) and posP(4)<>posP(8) and posP(4)<>posP(10) _
	and posP(4)<>posP(12) and posP(4)<>posP(14) and posP(6)<>posP(8) and posP(6)<>posP(10) and posP(6)<>posP(12) and posP(6)<>posP(14) and posP(8)<>posP(10) and posP(8)<>posP(12) _ 
	and posP(8)<>posP(14) and posP(10)<>posP(12) and posP(10)<>posP(14) and posP(12)<>posP(14) _
	and posP(1)<>posP(3) and posP(1)<>posP(5) and posP(1)<>posP(7) and posP(1)<>posP(9) and posP(1)<>posP(11) and posP(1)<>posP(13) and posP(1)<>posP(15) and posP(3)<>posP(5) _
	and posP(3)<>posP(7) and posP(3)<>posP(9) and posP(3)<>posP(11) and posP(3)<>posP(13) and posP(3)<>posP(15) and posP(5)<>posP(7) and posP(5)<>posP(9) and posP(5)<>posP(11) _
	and posP(5)<>posP(13) and posP(5)<>posP(15) and posP(7)<>posP(9) and posP(7)<>posP(11) and posP(7)<>posP(13) and posP(7)<>posP(15) and posP(9)<>posP(11) and posP(9)<>posP(13) _ 
	and posP(9)<>posP(15) and posP(11)<>posP(13) and posP(11)<>posP(15) and posP(13)<>posP(15) _
	and (posP(0)-posP(1))<>(posP(2)-posP(3)) and (posP(0)-posP(1))<>(posP(4)-posP(5)) and (posP(0)-posP(1))<>(posP(6)-posP(7)) and (posP(0)-posP(1))<>(posP(8)-posP(9)) _
	and (posP(0)-posP(1))<>(posP(10)-posP(11)) and (posP(0)-posP(1))<>(posP(12)-posP(13)) and (posP(0)-posP(1))<>(posP(14)-posP(15)) and (posP(2)-posP(3))<>(posP(4)-posP(5)) _
	and (posP(2)-posP(3))<>(posP(6)-posP(7)) and (posP(2)-posP(3))<>(posP(8)-posP(9)) and (posP(2)-posP(3))<>(posP(10)-posP(11)) and (posP(2)-posP(3))<>(posP(12)-posP(13)) _
	and (posP(2)-posP(3))<>(posP(14)-posP(15)) and (posP(4)-posP(5))<>(posP(6)-posP(7)) and (posP(4)-posP(5))<>(posP(8)-posP(9)) and (posP(4)-posP(5))<>(posP(10)-posP(11)) _
	and (posP(4)-posP(5))<>(posP(12)-posP(13)) and (posP(4)-posP(5))<>(posP(14)-posP(15)) and (posP(6)-posP(7))<>(posP(8)-posP(9)) and (posP(6)-posP(7))<>(posP(10)-posP(11)) _
	and (posP(6)-posP(7))<>(posP(12)-posP(13)) and (posP(6)-posP(7))<>(posP(14)-posP(15)) and (posP(8)-posP(9))<>(posP(10)-posP(11))_
	and (posP(8)-posP(9))<>(posP(12)-posP(13)) and (posP(8)-posP(9))<>(posP(14)-posP(15)) and (posP(10)-posP(11))<>(posP(12)-posP(13)) and (posP(10)-posP(11))<>(posP(14)-posP(15)) _
	and (posP(12)-posP(13))<>(posP(14)-posP(15)) _
	and (posP(1)+posP(0))<>(posP(3)+posP(2)) and (posP(1)+posP(0))<>(posP(5)+posP(4)) and (posP(1)+posP(0))<>(posP(7)+posP(6)) and (posP(1)+posP(0))<>(posP(9)+posP(8)) _
	and (posP(1)+posP(0))<>(posP(11)+posP(10)) and (posP(1)+posP(0))<>(posP(13)+posP(12)) and (posP(1)+posP(0))<>(posP(15)+posP(14)) and (posP(3)+posP(2))<>(posP(5)+posP(4)) _
	and (posP(3)+posP(2))<>(posP(7)+posP(6)) and (posP(3)+posP(2))<>(posP(9)+posP(8)) and (posP(3)+posP(2))<>(posP(11)+posP(10)) and (posP(3)+posP(2))<>(posP(13)+posP(12)) _
	and (posP(3)+posP(2))<>(posP(15)+posP(14)) and (posP(5)+posP(4))<>(posP(7)+posP(6)) and (posP(5)+posP(4))<>(posP(9)+posP(8)) and (posP(5)+posP(4))<>(posP(11)+posP(10)) _
	and (posP(5)+posP(4))<>(posP(13)+posP(12)) and (posP(5)+posP(4))<>(posP(15)+posP(14)) and (posP(7)+posP(6))<>(posP(9)+posP(8)) and (posP(7)+posP(6))<>(posP(11)+posP(10)) _
	and (posP(9)+posP(8))<>(posP(13)+posP(12)) and (posP(9)+posP(8))<>(posP(15)+posP(14)) and (posP(11)+posP(10))<>(posP(13)+posP(12)) and (posP(11)+posP(10))<>(posP(15)+posP(14)) _
	and (posP(13)+posP(12))<>(posP(15)+posP(14))) _
		addr = 22528 + 16 + 1 
        Poke addr, 96
		if (numR = 0 and mapabehaviour(n, 4) = 0)
		    doorLeft(n, 0)
			mapabehaviour(n, 4) = 1
		end if	
	else
		addr = 22528 + 16 + 1 
        Poke addr, 80
	end if
end sub