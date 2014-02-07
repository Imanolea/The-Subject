'' clue.bas
''
'' Números

'' Variables

dim cuadricula (6, 6) as uByte => { _
{1, 0, 1, 0, 1, 0, 0}, _
{1, 0, 1, 0, 1, 1, 1}, _
{0, 1, 0, 1, 1, 1, 0}, _
{0, 1, 0, 0, 0, 1, 0}, _
{1, 0, 0, 0, 1, 0, 1}, _
{1, 1, 1, 0, 1, 0, 1}, _
{1, 1, 0, 1, 0, 1, 0} _
}

'' Funciones

sub pintaColumna(x as uByte)
	dim i as Byte
	for i = 0 to 6
		comprobar(x/2 - 3, i)
	next i
end sub

sub pintaDiagonal()
	dim i as Byte
	while (i < 7)
		comprobar(i, 6 - i)
		i = i + 1
	wend	
end sub

sub pintaFila(y as uInteger)
	dim i as Byte
	for i = 0 to 6
		comprobar(i, y/2 - 2)
	next i
end sub

sub comprobar(x as uByte, y as uByte)
	if (cuadricula(y, x))
		cuadricula(y, x) = 0
	else
		cuadricula(y, x) = 1
	end if
end sub

function pintaCuadricula() as uByte
	dim completo as uByte
	dim i as uByte 
	dim j as uInteger
	dim addr as uInteger
	for j = 2 to 8
		for i = 5 to 11
			addr = 22528 + (i * 2) + ((j * 2) << 5)
			if cuadricula(j - 2, i - 5)
				colorea(addr, 88)
				completo = completo + 1
			else
				colorea(addr, 120)
			end if
		next i
	next j
	if (completo = 49)
		return 1
	else 
		return 0
	end if
end function