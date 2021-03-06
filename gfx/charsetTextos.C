/* C source file created by SevenuP v1.20                                */
/* SevenuP (C) Copyright 2002-2006 by Jaime Tejedor Gomez, aka Metalbrain*/

/*
GRAPHIC DATA:
Pixel Size:      (256,  24)
Char Size:       ( 32,   3)
Sort Priorities: Char line, X char, Y char
Data Outputted:  Gfx
Interleave:      Sprite
Mask:            No
*/

unsigned char charsetTextos[768] = {
  0,  0,  0,  0,  0,  0,  0,  0,
  0,126, 24, 24, 24, 24, 24, 24,
  0, 99, 99, 99,127, 99, 99, 99,
  0,127, 96, 96,126, 96, 96,127,
  0, 62, 99, 96, 62,  3, 99, 62,
  0, 99, 99, 99, 99, 99, 99, 62,
  0,126, 99, 99,126, 99, 99,126,
  0,  6,  6,  6,  6,102,102, 60,
  0, 62, 99, 96, 96, 96, 99, 62,
  0,  0,  0,  0, 62,  0, 62,  0,
  0, 99,115,123,111,103, 99, 99,
  8, 16, 68, 68, 68, 68, 56,  0,
  0,  0,  0,  4, 62,  8, 62, 16,
  0,126, 99, 99, 99,126, 96, 96,
  0, 28, 34, 99, 99, 99, 50, 28,
  0, 24, 56, 24, 24, 24, 24,126,
  0, 62, 67,  7, 30, 60,112,127,
  0, 63,  6, 12, 30,  3, 99, 62,
  0, 14, 30, 54,102,127,  6,  6,
  0,126, 96,126,  3,  3, 99, 62,
  0, 30, 48, 96,126, 99, 99, 62,
  0,127, 99,  6, 12, 24, 24, 24,
  0, 62, 99, 99, 62, 99, 99, 62,
  0, 62, 99, 99, 63,  3,  6, 60,
 28, 62, 65, 65, 67, 62, 28,  0,
  0,  1,  1,127,127, 33,  1,  0,
 49,121, 93, 77, 79, 71, 35,  0,
 70,111,121, 89, 73, 67,  2,  0,
  4,127,127,100, 52, 28, 12,  0,
 14, 95, 81, 81, 81,115,114,  0,
  6, 79, 73, 73,105, 63, 30,  0,
 96,112, 88, 79, 71, 96, 96,  0,
 54,127, 73, 73, 73,127, 54,  0,
 60,126, 75, 73, 73,121, 48,  0,
 56, 76,198,198,198, 68, 56,  0,
126, 24, 24, 24, 24, 28, 24,  0,
254, 14, 60,120,224,194,124,  0,
124,198,192,120, 48, 96,252,  0,
 96, 96,254,102,108,120,112,  0,
124,198,192,192,126,  6,126,  0,
124,198,198,126,  6, 12,120,  0,
 24, 24, 24, 48, 96,198,254,  0,
124,198,198,124,198,198,124,  0,
 60, 96,192,252,198,198,124,  0,
  0, 56,124,194,130,130,124, 56,
  0,128,132,254,254,128,128,  0,
  0,196,226,242,178,186,158,140,
  0, 64,194,146,154,158,246, 98,
  0, 48, 56, 44, 38,254,254, 32,
  0, 78,206,138,138,138,250,112,
  0,120,252,150,146,146,242, 96,
  0,  6,  6,226,242, 26, 14,  6,
  0,108,254,146,146,146,254,108,
  0, 12,158,146,146,210,126, 60,
248,240,240,240,240,240,224,192,
 31, 15, 15, 15, 15, 15,  7,  3,
  7, 15, 15, 15, 15, 15, 31, 63,
224,240,240,240,240,240,248,252,
 63, 63, 63, 63, 63, 15, 15,  0,
252,252,252,252,252,240,240,  0,
192,192,192,192,192,240,240,255,
  3,  3,  3,  3,  3, 15, 15,255,
  0, 28, 48,102,102, 12, 56,  0,
  0, 28, 48,102,102, 12, 56,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0};
