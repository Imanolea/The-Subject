'' maze.bas
''
'' Laberinto

'' Constantes

Const CHRSTART as uByte = 32
Const CHRNUMSTART as uByte = 14

'' Variables

dim salida, laberinto as uByte

dim primos (20) as uByte => { _
    11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97 _
}

dim noPrimos (68) as uByte => { _
    10, 12, 14, 15, 16, 18, 20, 21, 22, 24, 25, 26, 27, 28, 30, 32, 33, 34, 35, 36, 38, 39, 40, 42, 44, 45, 46, 48, 49, 50, 51, 52, 54, 55, 56, 57, 58, 60, 62, 63, 64, 65, 66, 68, 69, 70, 72, 74, 75, 76, 77, 78, 80, 81, 82, 84, 85, 86, 87, 88, 90, 91, 92, 93, 94, 95, 96, 98, 99 _
}

'' Métodos

' Dibuja los números del laberinto

function pintaNumeros (mapoffsetx as uByte, mapoffsety as uByte)

    Poke uInteger 23606, @charsetTextos (0) - 256

    dim n1, n2, n3, n4, nAux, orden as uByte 
	
	n1 = noPrimos(int (rnd * 69))
	
    n2 = noPrimos(int (rnd * 69))
	while n2 = n1
	    n2 = noPrimos(int (rnd * 69))
	wend
	
	n3 = noPrimos(int (rnd * 69))
	while n3 = n1 or n3 = n2
	    n3 = noPrimos(int (rnd * 69))
	wend
	
	n4 = primos(int (rnd * 21))
	
	nAux = 0
	orden = int (rnd * 4)
	
	if (orden = 0)
	    nAux = n1
		n1 = n4
		n4 = nAux
	elseif (orden = 1)
	    nAux = n2
		n2 = n4
		n4 = nAux
	elseif (orden = 2)
	    nAux = n3
		n3 = n4
		n4 = nAux
	end if
	
	print paper 8; ink 8; bright 1; at (mapoffsety + 3), (mapoffsetx + 11); chr (CHRSTART + CHRNUMSTART + n1/10); chr (CHRSTART + CHRNUMSTART + (n1 - n1/10*10))
	
	print paper 8; ink 8; bright 1; at (mapoffsety + 11), (mapoffsetx + 20); chr (CHRSTART + CHRNUMSTART + 30 + n2/10); 
	print paper 8; ink 8; bright 1; at (mapoffsety + 12), (mapoffsetx + 20); chr (CHRSTART + CHRNUMSTART + 30 + (n2 - n2/10*10));
	
	print paper 8; ink 8; bright 1; at (mapoffsety + 20), (mapoffsetx + 11); chr (CHRSTART + CHRNUMSTART + 20 + (n3 - n3/10*10)); chr (CHRSTART + CHRNUMSTART + 20 + n3/10)
	
	print paper 8; ink 8; bright 1; at (mapoffsety + 12), (mapoffsetx + 3); chr (CHRSTART + CHRNUMSTART + 10 + n4/10); 
	print paper 8; ink 8; bright 1; at (mapoffsety + 11), (mapoffsetx + 3); chr (CHRSTART + CHRNUMSTART + 10 + (n4 - n4/10*10));
	
	pokeGraficos()
	
	return (orden + 1) 
	
end function