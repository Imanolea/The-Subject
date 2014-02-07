'' piano.bas
''
'' Piano

'' Variables

' Número de teclas pulsadas

Dim nPlayed as uByte = 0

' Turno

Dim tPiano as uByte = 0

' Dirección de memoria

Dim addr as uInteger

' Color

Dim color as Byte

Dim key (7) as uByte => { _
    0, 0, 0, 0, 0, 0, 0, 0 _
}

Dim keySharp (4) as uByte => { _
    0, 0, 0, 0, 0 _
}

Dim notasKuroi (23) as uByte => { _
    8, 2, 12, 2, 10, 12, 14, 5, 6, 12, 10, 8, 2, 12, 2, 10, 12, 14, 5, 6, 0, 10, 14, 8 _   
}

'' Funciones

' Se pulsa el botón que acciona la canción

sub pianoButton()
	if (tPiano = 0 or tPiano = 3)
		playKuroi (0)
		addr = 22528 + 19 + 0 
		if (not tPiano)
			tPiano = 1
			poke addr, 96
		elseif(tPiano=3)
			tPiano = 2
			poke addr, 104
		end if
		makeSound(7)
	end if                        
end sub

' Reacciona en función de la tecla pulsada

sub pianoPos()
	if (pY=9 or pY=8)
		if (pX=2)
			keyReleased(0)
		elseif (pX=3 or pX=4) 
			if (key(0) = 0)
				play(0)
			end if
			sharpKeyReleased(0, 1)                                
			keyPushed(0)
			keyReleased(2)
		elseif (pX=5)  
			if (not key(0) and not key(1))
				play(26)
			elseif (not key(0))
				play(0)
			elseif (not key(1))
				play(2)
			end if        
			sharpKeyReleased(0, 1)
			keyPushed(0)
			keyPushed(2)                               
		elseif (pX=6) 
			if (key(1) = 0)
				play(2)
			end if
			sharpKeyReleased(0, 1)
			keyReleased(0)
			keyPushed(2)
			keyReleased(4)
		elseif (pX=7) 
			if (not key(1) and not key(2))
				play(28)
			elseif (not key(1))
				play(2)
			elseif (not key(2))
				play(4)
			end if        
			keyPushed(2)
			keyPushed(4)        
		elseif (pX=8)
			if (key(2) = 0)
				play(4)
			end if
			sharpKeyReleased(1, 5)
			keyReleased(2)
			keyPushed(4)
			keyReleased(6)
		elseif (pX=9) 
			if (not key(2) and not key(3))
				play(30)
			elseif (not key(2))
				play(4)
			elseif (not key(3))
				play(6)
			end if
			sharpKeyReleased(1, 5)
			keyPushed(4)
			keyPushed(6)        
		elseif (pX=10)
			if (key(3) = 0)
				play(6)
			end if
			sharpKeyReleased(1, 5)
			sharpKeyReleased(2, 7)
			keyReleased(4)
			keyPushed(6)
			keyReleased(8)
		elseif (pX=11) 
			if (not key(3) and not key(4))
				play(32)
			elseif (not key(3))
				play(6)
			elseif (not key(4))
				play(8)
			end if
			sharpKeyReleased(2, 7)
			keyPushed(6)
			keyPushed(8)                                        
		elseif (pX=12)
			if (key(4) = 0)
				play(8)
			end if
			sharpKeyReleased(2, 7)
			sharpKeyReleased(3, 9)
			keyReleased(6)
			keyPushed(8)
			keyReleased(10)
		elseif (pX=13) 
			if (not key(4) and not key(5))
				play(34)
			elseif (not key(4))
				play(8)
			elseif (not key(5))
				play(10)
			end if        
			sharpKeyReleased(3, 9)
			keyPushed(8)
			keyPushed(10)                                          
		elseif (pX=14)
			if (key(5) = 0)
				play(10)
			end if
			sharpKeyReleased(3, 9)
			keyReleased(8)
			keyPushed(10)
			keyReleased(12)
		elseif (pX=15)
			if (not key(5) and not key(6))
				play(36)
			elseif (not key(5))
				play(10)
			elseif (not key(6))
				play(12)
			end if                                
			keyPushed(10)
			keyPushed(12)
		elseif (pX=16)
			if (key(6) = 0)
				play(12)
			end if
			sharpKeyReleased(4, 13)
			keyReleased(10)
			keyPushed(12)
			keyReleased(14)
		elseif (pX=17) 
			if (not key(6) and not key(7))
				play(38)
			elseif (not key(6))
				play(12)
			elseif (not key(7))
				play(14)
			end if
			sharpKeyReleased(4, 13)
			keyPushed(12)
			keyPushed(14)                                        
		elseif (pX=18 or pX=19)
			if (key(7) = 0)
				play(14)
			end if
			sharpKeyReleased(4, 13)
			keyReleased(12)
			keyPushed(14)
		elseif (pX=20)
			keyReleased(14)
		end if
	else
		keyReleased(0)
		keyReleased(2)
		keyReleased(4)
		keyReleased(6)
		keyReleased(8)
		keyReleased(10)
		keyReleased(12)
		keyReleased(14)
	end if
	if (pY=7 or pY=6)
		if (pX=5)
			if (not keySharp(0))
				play(1)
			end if
			sharpKeyPushed(0, 1)
		elseif (pX=9)
			if (not keySharp(1))
				play(5)
			end if
			sharpKeyPushed(1, 5)
		elseif (pX=11)
			if (not keySharp(2))
				play(7)
			end if
			sharpKeyPushed(2, 7)
		elseif (pX=13)
			if (not keySharp(3))
				play(9)
			end if
			sharpKeyPushed(3, 9)
		elseif (pX=17)
			if (not keySharp(4))
				play(13)
			end if
			sharpKeyPushed(4, 13)
		else
			sharpKeyReleased(0, 1)
			sharpKeyReleased(1, 5)
			sharpKeyReleased(2, 7)
			sharpKeyReleased(3, 9)
			sharpKeyReleased(4, 13)
		end if
	elseif (pY<>8 and pY<>9)
		sharpKeyReleased(0, 1)
		sharpKeyReleased(1, 5)
		sharpKeyReleased(2, 7)
		sharpKeyReleased(3, 9)
		sharpKeyReleased(4, 13)
	end if                                
end sub

sub playKuroi (i as uByte)
	if (notasKuroi(i)/2*2 = notasKuroi (i))                
		pushNote (i, 0)
	else
		pushNote (i, 1)
	end if        
	pushKey (i)
	Asm        
		push ix
		LD   B, 1
		LD    HL, MUSICDATA
		call START        
		pop ix
	End asm
	Do
		i = i + 1
		if (notasKuroi(i)/2*2 = notasKuroi (i))                
			pushNote (i, 0)
		else
			pushNote (i, 1)
		end if        
		pushKey (i)
		Asm
			push ix
			call NEXTNOTE
			pop ix
		End Asm
	Loop While i < mapabehaviour(nPant, 4)
	if (notasKuroi (i)/2*2 = notasKuroi (i))                
		pushNote (24, 0)
	else
		pushNote (24, 1)
	end if        
	pushKey (24)
end sub

sub pushNote (nota as uByte, sharp as uByte)
	if (nota > 0)
		color = 120
		addr = 22528 + mapoffsetx + 4 + notasKuroi(nota-1) + ((mapoffsety + 6)<< 5)
	end if
	colorKey()
	if (nota < 24)
		if (sharp)
			color = 125
		else
			color = 104
		end if        
		addr = 22528 + mapoffsetx + 4 + notasKuroi(nota) + ((mapoffsety + 6)<< 5)
	else
		color = 120
		addr = 22528 + mapoffsetx + 4 + notasKuroi(nota-1) + ((mapoffsety + 6)<< 5)
	end if
	colorKey()
end sub

sub colorKey()
    colorSharpKey()
	poke addr + 96, color: poke addr + 97, color
end sub

sub colorSharpKey()
	colorea(addr, color)
	poke addr + 64, color: poke addr + 65, color
end sub

sub colorea(addrs as uInteger, colors as uByte)
	poke addrs, colors: poke addrs + 1, colors
	poke addrs + 32, colors: poke addrs + 33, colors
end sub

sub pushKey (posNota as uByte)
    Dim nota, notaAnterior as uByte
    nota = notasKuroi(posNota)
    notaAnterior = notasKuroi(posNota - 1)
    if (posNota>0 and notaAnterior/2*2=notaAnterior)
        if (notaAnterior = 0)
            pintaTile((mapoffsetx + 4 + notaAnterior), (mapoffsety + 10), 27)
        else        
            pintaTile((mapoffsetx + 4 + notaAnterior), (mapoffsety + 10), 30)
        end if        
    end if
    if (posNota < 24)
        if (nota/2*2 = nota)
            if (nota = 0)
                pintaTile((mapoffsetx + 4 + nota), (mapoffsety + 10), 36)
            else
                pintaTile((mapoffsetx + 4 + nota), (mapoffsety + 10), 35)
            end if
        end if
    end if        
end sub

sub keyPushed (pos as uByte)
    if (not key(pos/2)) 
        addr = 22528 + mapoffsetx + 4 + pos + ((mapoffsety + 6)<< 5)
        fsp21MoveSprite(0, 0, 0)
        fsp21MinUpdateSprites ()        
        if (not pos)
            pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 36)
        else
            pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 35)
        end if
		color = 104
		colorKey()
        key(pos/2)=1
    end if        
end sub

sub sharpKeyPushed (pos as uByte, paintPos as uByte)
	if (not keySharp(pos))
		fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
		addr = 22528 + mapoffsetx + 4 + paintPos + ((mapoffsety + 6)<< 5)
		color = 125
		colorSharpKey()
		keySharp(pos)=1
	end if        
end sub

sub keyReleased (pos as uByte)
    if (key(pos/2))
		addr = 22528 + mapoffsetx + 4 + pos + ((mapoffsety + 6)<< 5)
		fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
		if (not pos)
			pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 27)
		else
			pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 30)
		end if
		color = 120
		colorKey()
		key(pos/2)=0
	end if        
end sub

sub sharpKeyReleased (pos as uByte, paintPos as uByte)
    if (keySharp(pos))
		fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
		addr = 22528 + mapoffsetx + 4 + paintPos + ((mapoffsety + 6)<< 5)
		color = 120
		colorSharpKey()
		keySharp(pos) = 0
	end if
end sub

sub play(pos as uByte)

	dim nota as Byte

	if (pos / 2 * 2 = pos)
		nota = pos +1
	elseif (pos=1)
		nota = 17
	elseif (pos=5)
		nota = 19
	elseif (pos=7)
		nota = 21
	elseif (pos=9)
		nota = 23
	elseif (pos=13)
		nota = 25
	end if
	
	Poke @datosRutina, nota
	
	asm
		call rutina
	end asm

	if (tPiano=1)
		if (notasKuroi(nPlayed)=pos)
			nPlayed = nPlayed + 1
			if (nPlayed=12 and mapabehaviour(nPant, 4) = 11)
				mapabehaviour(nPant, 4) = 23
				makeSound (1)
				nPlayed = 0        
				tPiano = 0
				luzRoja()                               
			elseif (nPlayed=24 and mapabehaviour(nPant, 4) = 23)
				makeSound (1)
				nPlayed = 0        
				tPiano = 3
				luzRoja()
			end if
		else
			makeSound (0)
			nPlayed = 0
			tPiano = 0
			luzRoja()
		end if
	elseif (tPiano = 2)
		if (notasKuroi(23 - nPlayed)=pos)
			nPlayed = nPlayed + 1
			if (nPlayed=24)
				makeSound (1)
				nPlayed = 0        
				tPiano = 4
				luzRoja()
				doorUp(nPant, 0)
				mapabehaviour(nPant, 4) = 24
			end if
		else
			makeSound (0)
			nPlayed = 0
			tPiano = 3
			luzRoja()
		end if
	end if 
end sub

sub luzRoja()
	poke 22528 + 19 + 0, 80
end sub

Sub myCodeContainer
    Asm
    rutina:
		ld    a, (dato)
        ld    b, a
		push ix        
		LD    HL, MUSICDATAB
		call START                
		pop ix
        ret
    End Asm
datosRutina:
    Asm
    dato:
        db 0
    End Asm
End Sub