' Mapa.bas 
' Generado por MapCnvZXB
' Copyleft 2010 The Mojon Twins
 
Dim mapa (1295) As uByte => { _
    6, 2, 18, 19, 2, 2, 2, 2, 18, 19, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 7, 4, 4, 4, 4, 14, 15, 4, 4, 4, 4, 8,  _
    6, 2, 2, 2, 2, 2, 59, 2, 2, 2, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 55, 56, 56, 56, 56, 56, 56, 44, 5, 3, 1, 1, 57, 22, 58, 22, 58, 22, 58, 44, 5, 3, 1, 1, 57, 58, 58, 58, 58, 58, 58, 44, 5, 3, 1, 1, 57, 22, 58, 22, 58, 22, 58, 44, 5, 3, 1, 1, 57, 58, 58, 58, 58, 58, 58, 44, 5, 3, 1, 1, 57, 22, 58, 22, 58, 22, 58, 44, 5, 3, 1, 1, 57, 58, 58, 58, 58, 58, 58, 44, 5, 3, 1, 1, 42, 42, 42, 42, 42, 42, 42, 43, 5, 7, 4, 4, 4, 4, 23, 45, 4, 4, 4, 4, 8,  _
    6, 2, 2, 2, 2, 10, 11, 2, 2, 2, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 7, 4, 23, 45, 4, 4, 4, 4, 23, 45, 4, 8,  _
    _
    6, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 22, 56, 56, 56, 56, 56, 56, 56, 44, 5, 3, 1, 22, 58, 58, 58, 58, 58, 58, 58, 44, 5, 3, 1, 22, 58, 58, 58, 58, 58, 58, 58, 44, 5, 3, 1, 22, 58, 58, 58, 58, 58, 58, 58, 44, 46, 3, 1, 22, 58, 58, 58, 58, 58, 58, 58, 44, 47, 3, 1, 22, 58, 58, 58, 58, 58, 58, 58, 44, 5, 3, 1, 22, 58, 58, 58, 58, 58, 58, 58, 44, 5, 3, 1, 22, 22, 22, 22, 22, 22, 22, 22, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8,  _
    6, 2, 2, 2, 2, 18, 19, 2, 2, 2, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 46, 21, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 47, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 7, 4, 4, 4, 4, 23, 45, 4, 4, 4, 4, 8,  _
    6, 2, 2, 2, 2, 2, 37, 2, 2, 2, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 39, 38, 39, 38, 39, 38, 39, 38, 44, 5, 3, 1, 38, 39, 38, 39, 38, 39, 38, 39, 44, 5, 3, 1, 39, 38, 39, 38, 39, 38, 39, 38, 44, 5, 20, 1, 38, 39, 38, 39, 38, 39, 38, 39, 44, 5, 21, 1, 39, 38, 39, 38, 39, 38, 39, 38, 44, 5, 3, 1, 38, 39, 38, 39, 38, 39, 38, 39, 44, 5, 3, 1, 39, 38, 39, 38, 39, 38, 39, 38, 44, 5, 3, 1, 38, 39, 38, 39, 38, 39, 38, 39, 44, 5, 3, 1, 42, 42, 42, 42, 42, 42, 42, 42, 43, 5, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8,  _
    _
    6, 2, 2, 2, 2, 10, 11, 24, 2, 2, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 22, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8,  _
    6, 2, 2, 2, 2, 18, 19, 24, 2, 2, 2, 9, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 25, 28, 31, 33, 33, 28, 31, 28, 1, 5, 3, 1, 26, 29, 32, 34, 34, 29, 32, 29, 1, 5, 3, 1, 27, 30, 30, 30, 30, 30, 30, 30, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8,  _
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 _
}
 
