'' engine.bas
''
'' Rutinas del juego

'' Constantes

Const TILESIZE As uByte = 2
Const MAPWIDTH As uByte = 4
Const MAPHEIGHT As uByte = 4

'' Variables

Dim mapscreenwidth As uByte = 16
Dim mapscreenheight As uByte = 12
Dim mapoffsetx as uByte = 0
Dim mapoffsety as uByte = 0

' Pantalla
Dim nPant as uByte


'' Subs

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
      If xx = x + mapScreenWidthInChars Then
         xx = x
         yy = yy + TILESIZE
      End If
      idx = idx + 1
    Next i

End Sub
