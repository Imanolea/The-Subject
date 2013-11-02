' Map converter ZX Basic edition
' Cutrecode by na_th_an

' Estos programas son tela de optimizables, pero me da igual porque tengo un dual core.
' �OLE!

Sub WarningMessage ()
	Print "** WARNING **"
	Print "   MapCnv convierte un archivo raw de mappy (mapa.map, por ejemplo)"
	Print "   a un array directamente usable en ZX Basic."
	Print "   Si metes mal los par�metros ocurrir�n cosas divertidas."
	Print
End Sub

sub usage () 
	Print "** USO **"
	Print "   MapCnvZXB archivo.map ancho_mapa alto_mapa ancho_pantalla alto_pantalla packed"
	Print
	Print "   - archivo.map : Archivo de entrada exportado con mappy en formato raw."
	Print "   - ancho_mapa : Ancho del mapa en pantallas."
	Print "   - alto_mapa : Alto del mapa en pantallas."
	Print "   - ancho_pantalla : Ancho de la pantalla en tiles."
	Print "   - alto_pantalla : Alto de la pantalla en tiles."
	Print "   - tile_cerrojo : N� del tile que representa el cerrojo."
	Print "   - packed : Escribe esta opci�n para mapas de la churrera de 16 tiles."
	Print
	Print "Por ejemplo, para un mapa de 6x5 pantallas empaquetado:"
	Print
	Print "   MapCnvZXB mapa.map 6 5 15 10 packed"
end sub

Dim As Integer map_w, map_h, scr_w, scr_h, bolt
Dim As Integer x, y, xx, yy, i, j, f, packed, ac, ct
Dim As Byte d
Dim As String o
Dim As Integer pckrdvdr

Type MyBolt
	np As Integer
	x As Integer
	y As Integer
End Type

Dim As MyBolt Bolts (100)

WarningMessage ()

if 	Command (1) = "" Or _
	Val (Command (2)) <= 0 Or _
	Val (Command (3)) <= 0 Or _
	Val (Command (4)) <= 0 Or _
	Val (Command (5)) <= 0 Then
	
	usage ()
	end
End If

map_w = Val (Command (2))
map_h = Val (Command (3))
scr_w = Val (Command (4))
scr_h = Val (Command (5))


if lcase(Command (7)) = "packed" then
	print lcase(command(7))
	packed = 1
else
	packed = 0
end if

Dim As Integer BigOrigMap (map_h * scr_h - 1, map_w * scr_w - 1)


' Leemos el mapa original

f = FreeFile
Open Command (1) for binary as #f

For y = 0 To (map_h * scr_h - 1)
	For x = 0 To (map_w * scr_w - 1)
		get #f , , d
		BigOrigMap (y, x) = d
	Next x
Next y

close f

' Construimos el nuevo mapa mientras rellenamos el array de cerrojos

open "mapa.bas" for output as #f

print #f, "' Mapa.bas "
print #f, "' Generado por MapCnvZXB"
print #f, "' Copyleft 2010 The Mojon Twins"
print #f, " "

If packed = 1 Then pckrdvdr = 2 else pckrdvdr = 1

print #f, "Dim mapa (" + Trim (Str((map_w * map_h * scr_w * scr_h) / pckrdvdr - 1)) + ") As uByte => { _"

i = 0

for yy = 0 To map_h - 1
	for xx = 0 To map_w - 1
		o = "    "
		ac = 0
		ct = 0
		for y = 0 to scr_h - 1
			for x = 0 to scr_w - 1
				
						
				if packed = 0 then
					o = o + str (BigOrigMap (yy * scr_h + y, xx * scr_w + x))
					if yy < map_h - 1 Or xx < map_w - 1 Or y < scr_h -1 Or x < scr_w -1 then
						o = o + ", "
					end if
				else
					if ct = 0 then
						ac = BigOrigMap (yy * scr_h + y, xx * scr_w + x) * 16
					else
						ac = ac + BigOrigMap (yy * scr_h + y, xx * scr_w + x) 
						o = o + str (ac)
						
						if yy < map_h - 1 Or xx < map_w - 1 Or y < scr_h - 1 Or x < scr_w - 1 then
							o = o + ", "
						end if
					end if
					ct = 1 - ct
				end if
				
			next x
		next y		
		print #f, o + " _"
	next xx
	if yy < map_h - 1 then print #f, "    _"
next yy
print #f, "}"

print #f, " "

