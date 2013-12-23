'' piano.bas
''
'' Piano

'' Variables

' Número de teclas pulsadas

Dim nPlayed as uByte = 0

' Ultima posicion pulsado

Dim uPX, uPY as uByte

' Ultima posicion pulsado clon

Dim pUPX, pUPY as uByte

' Turno

Dim tPiano as uByte = 0

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
		Dim addr as uInteger
		playKuroi (0)
		addr = 22528 + 19 + 0 
		if (tPiano=0)
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
		    if (key(0)=0 and key(1)=0)
			    play(26)
			elseif (key(0)=0)
			    play(0)
			elseif (key(1)=0)
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
			if (key(1)=0 and key(2)=0)
				play(28)
			elseif (key(1)=0)
				play(2)
			elseif (key(2)=0)
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
			if (key(2)=0 and key(3)=0)
				play(30)
			elseif (key(2)=0)
			    play(4)
			elseif (key(3)=0)
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
			if (key(3)=0 and key(4)=0)
				play(32)
			elseif (key(3)=0)
				play(6)
			elseif (key(4)=0)
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
			if (key(4)=0 and key(5)=0)
				play(34)
			elseif (key(4)=0)
				play(8)
			elseif (key(5)=0)
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
			if (key(5)=0 and key(6)=0)
				play(36)
			elseif (key(5)=0)
				play(10)
			elseif (key(6)=0)
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
			if (key(6)=0 and key(7)=0)
				play(38)
			elseif (key(6)=0)
			    play(12)
			elseif (key(7)=0)
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
			if (keySharp(0)=0)
				play(1)
			end if
			sharpKeyPushed(0, 1)
		elseif (pX=9)
			if (keySharp(1)=0)
				play(5)
			end if
			sharpKeyPushed(1, 5)
		elseif (pX=11)
			if (keySharp(2)=0)
				play(7)
			end if
			sharpKeyPushed(2, 7)
		elseif (pX=13)
			if (keySharp(3)=0)
				play(9)
			end if
			sharpKeyPushed(3, 9)
		elseif (pX=17)
			if (keySharp(4)=0)
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
		pushNote (i)
	else
		pushNoteSharp (i)
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
		    pushNote (i)
		else
		    pushNoteSharp (i)
		end if	
		pushKey (i)
		Asm
			push ix
			call NEXTNOTE
			pop ix
		End Asm
	Loop While i < mapabehaviour(nPant, 4)
	if (notasKuroi (i)/2*2 = notasKuroi (i))		
	    pushNote (24)
	else
	    pushNoteSharp (24)
	end if	
	pushKey (24)
end sub

sub pushNote (nota as uByte)
    Dim addr as uInteger
	Dim color as uByte
	if (nota > 0)
	    addr = 22528 + mapoffsetx + 4 + notasKuroi(nota-1) + ((mapoffsety + 6)<< 5)
		poke addr, 120: poke addr + 1, 120
		poke addr + 32, 120: poke addr + 33, 120
		poke addr + 64, 120: poke addr + 65, 120
		poke addr + 96, 120: poke addr + 97, 120
	end if
	if (nota < 24)
        addr = 22528 + mapoffsetx + 4 + notasKuroi(nota) + ((mapoffsety + 6)<< 5)
	    poke addr, 104: poke addr + 1, 104
		poke addr + 32, 104: poke addr + 33, 104
		poke addr + 64, 104: poke addr + 65, 104
		poke addr + 96, 104: poke addr + 97, 104
	else
	    addr = 22528 + mapoffsetx + 4 + notasKuroi(nota-1) + ((mapoffsety + 6)<< 5)
		poke addr, 120: poke addr + 1, 120
		poke addr + 32, 120: poke addr + 33, 120
		poke addr + 64, 120: poke addr + 65, 120
		poke addr + 96, 120: poke addr + 97, 120
	end if
end sub

sub pushNoteSharp (nota as uByte)
    Dim addr as uInteger
	Dim color as uByte
	if (nota > 0)
	    addr = 22528 + mapoffsetx + 4 + notasKuroi(nota-1) + ((mapoffsety + 6)<< 5)
		poke addr, 120: poke addr + 1, 120
		poke addr + 32, 120: poke addr + 33, 120
		poke addr + 64, 120: poke addr + 65, 120
		poke addr + 96, 120: poke addr + 97, 120
	end if
	if (nota < 24)
        addr = 22528 + mapoffsetx + 4 + notasKuroi(nota) + ((mapoffsety + 6)<< 5)
	    poke addr, 125: poke addr + 1, 125
		poke addr + 32, 125: poke addr + 33, 125
		poke addr + 64, 125: poke addr + 65, 125
		poke addr + 96, 125: poke addr + 97, 125
	else
	    addr = 22528 + mapoffsetx + 4 + notasKuroi(nota-1) + ((mapoffsety + 6)<< 5)
		poke addr, 120: poke addr + 1, 120
		poke addr + 32, 120: poke addr + 33, 120
		poke addr + 64, 120: poke addr + 65, 120
		poke addr + 96, 120: poke addr + 97, 120
	end if
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
    else
        if (posNota>0 and notaAnterior/2*2=notaAnterior)
	        if (notaAnterior = 0)
		        pintaTile((mapoffsetx + 4 + notaAnterior), (mapoffsety + 10), 27)
		    else	
	            pintaTile((mapoffsetx + 4 + notaAnterior), (mapoffsety + 10), 30)
		    end if	
	    end if
	end if	
end sub

sub keyPushed (pos as uByte)
    if (key(pos/2)=0) 
	    addr = 22528 + mapoffsetx + 4 + pos + ((mapoffsety + 6)<< 5)
	    poke addr, 104: poke addr + 1, 104
        fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()	
	    if (pos=0)
	        pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 36)
	    else
	        pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 35)
	    end if
		poke addr + 32, 104: poke addr + 33, 104
		poke addr + 64, 104: poke addr + 65, 104
		poke addr + 96, 104: poke addr + 97, 104 
		key(pos/2)=1
	end if	
end sub

sub sharpKeyPushed (pos as uByte, paintPos as uByte)
    if (keySharp(pos)=0)
	    fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
        addr = 22528 + mapoffsetx + 4 + paintPos + ((mapoffsety + 6)<< 5)
	    poke addr, 125: poke addr + 1, 125
		poke addr + 32, 125: poke addr + 33, 125
		poke addr + 64, 125: poke addr + 65, 125
		keySharp(pos)=1
	end if	
end sub

sub keyReleased (pos as uByte)
    if (key(pos/2))
	    addr = 22528 + mapoffsetx + 4 + pos + ((mapoffsety + 6)<< 5)
	    poke addr, 120: poke addr + 1, 120
	    fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
	    if (pos=0)
	        pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 27)
	    else
	        pintaTile((mapoffsetx + 4 + pos), (mapoffsety + 10), 30)
	    end if
		poke addr + 32, 120: poke addr + 33, 120
		poke addr + 64, 120: poke addr + 65, 120
		poke addr + 96, 120: poke addr + 97, 120
		key(pos/2)=0
	end if	
end sub

sub sharpKeyReleased (pos as uByte, paintPos as uByte)
    if (keySharp(pos))
	    fsp21MoveSprite(0, 0, 0)
		fsp21MinUpdateSprites ()
        addr = 22528 + mapoffsetx + 4 + paintPos + ((mapoffsety + 6)<< 5)
	    poke addr, 120: poke addr + 1, 120
		poke addr + 32, 120: poke addr + 33, 120
		poke addr + 64, 120: poke addr + 65, 120
		keySharp(pos) = 0
	end if
end sub

sub play(pos as uByte)

    if (pos=0)
        Asm	 
		LD B, 1
        End asm
	elseif (pos=2)
	    Asm	 
		LD B, 3
        End asm
	elseif (pos=4)
	    Asm	
        LD B, 5		
        End asm
	elseif (pos=6)
	    Asm	
		LD B, 7
        End asm
	elseif (pos=8)
	    Asm	
		LD B, 9
        End asm
	elseif (pos=10)
	    Asm	
		LD B, 11
        End asm
	elseif (pos=12)
	    Asm	
		LD B, 13
        End asm
	elseif (pos=14)
	    Asm	
		LD B, 15
        End asm
    elseif (pos=1)
	    Asm	
		LD B, 17
        End asm
	elseif (pos=5)
	    Asm	
		LD B, 19
        End asm
	elseif (pos=7)
	    Asm	
		LD B, 21
        End asm
	elseif (pos=9)
	    Asm	
		LD B, 23
        End asm
	elseif (pos=13)
	    Asm	
		LD B, 25
        End asm
	elseif ((pos/2)=13)
	    Asm	
		LD B, 27
        End asm
	elseif ((pos/2)=14)
	    Asm	
		LD B, 29
        End asm
	elseif ((pos/2)=15)
	    Asm	
		LD B, 31
        End asm
	elseif ((pos/2)=16)
	    Asm	
		LD B, 33
        End asm
	elseif ((pos/2)=17)
	    Asm	
		LD B, 35
        End asm
	elseif ((pos/2)=18)
	    Asm	
		LD B, 37
        End asm
	elseif ((pos/2)=19)
	    Asm	
		LD B, 39
        End asm
	end if
	
	Asm	
	    push ix	
	    LD    HL, MUSICDATAB
        call START		
	    pop ix
    End asm

    if (tPiano=1)
        if (notasKuroi(nPlayed)=pos)
	        nPlayed = nPlayed + 1
			if (nPlayed=12 and mapabehaviour(nPant, 4) = 11)
				mapabehaviour(nPant, 4) = 23
			    makeSound (1)
                nPlayed = 0	
                tPiano = 0
                addr = 22528 + 19 + 0 
			    poke addr, 80				
			elseif (nPlayed=24 and mapabehaviour(nPant, 4) = 23)
			    makeSound (1)
				nPlayed = 0	
                tPiano = 3
				addr = 22528 + 19 + 0 
			    poke addr, 80
			end if
	    else
	        makeSound (0)
	        nPlayed = 0
			tPiano = 0
			addr = 22528 + 19 + 0 
			poke addr, 80
	    end if
	elseif (tPiano = 2)
        if (notasKuroi(23 - nPlayed)=pos)
            nPlayed = nPlayed + 1
			if (nPlayed=24)
			    makeSound (1)
                nPlayed = 0	
                tPiano = 4
                addr = 22528 + 19 + 0 
			    poke addr, 80 
                doorUp(nPant, 0)
				mapabehaviour(nPant, 4) = 24
			end if
        else
            makeSound (0)
	        nPlayed = 0
			tPiano = 3
			addr = 22528 + 19 + 0 
			poke addr, 80		
		end if		
	end if	
    
end sub

