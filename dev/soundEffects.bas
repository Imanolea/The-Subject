'' Sound effects

' BeepFX player by Shiru

Const SOUNDWRONG as uByte = 0
Const SOUNDSUCCESS as uByte = 1
Const SOUNDDROP as uByte = 2
Const SOUNDGRAB as uByte = 3
Const SOUNDDOOR as uByte = 4
Const SOUNDSWITCHON as uByte = 5
Const SOUNDSWITCHOFF as uByte = 6
const SOUNDBUTTON as uByte = 7


Sub makeSound (nSound as uByte)
	Poke @makeSoundData, nSound
	Asm
		push ix
		push iy
		Call sound_play
		pop iy
		pop ix
	End Asm
End Sub

Sub makeSoundAsmContainer ()
makeSoundData:
Asm
sound_data:
	defb 0
; Efect in A
sound_play:
	ld a, (sound_data)
	ld hl, soundEffectsData	; address of sound effects data

	di
	push iy

	ld b,0
	ld c,a
	add hl,bc
	add hl,bc
	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	push hl
	pop ix			;put it into ix

	;ld a,(23624)	;get border color from BASIC vars to keep it unchanged
	;rra
	;rra
	;rra
	;and 7
	xor a
	ld (sfxRoutineTone_border + 1),a
	ld (sfxRoutineNoise_border + 1),a


readData:
	ld a,(ix+0)		;read block type
	or a
	jr nz,readData_sound
	pop iy
	ei
	ret
	
readData_sound:
	ld c,(ix+1)		;read duration 1
	ld b,(ix+2)
	ld e,(ix+3)		;read duration 2
	ld d,(ix+4)
	push de
	pop iy

	dec a
	jr nz,sfxRoutineNoise



;this routine generate tone with many parameters

sfxRoutineTone:
	ld e,(ix+5)		;freq
	ld d,(ix+6)
	ld a,(ix+9)		;duty
	ld (sfxRoutineTone_duty + 1),a
	ld hl,0

sfxRoutineTone_l0:
	push bc
	push iy
	pop bc
sfxRoutineTone_l1:
	add hl,de
	ld a,h
sfxRoutineTone_duty:
	cp 0
	sbc a,a
	and 16
sfxRoutineTone_border:
	or 0
	out ($fe),a

	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineTone_l1

	ld a,(sfxRoutineTone_duty + 1)
	add a,(ix+10)	;duty change
	ld (sfxRoutineTone_duty + 1),a

	ld c,(ix+7)		;slide
	ld b,(ix+8)
	ex de,hl
	add hl,bc
	ex de,hl

	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineTone_l0

	ld c,11
nextData:
	add ix,bc		;skip to the next block
	jr readData

;this routine generate noise with two parameters

sfxRoutineNoise:
	ld e,(ix+5)		;pitch

	ld d,1
	ld h,d
	ld l,d
sfxRoutineNoise_l0:
	push bc
	push iy
	pop bc
sfxRoutineNoise_l1:
	ld a,(hl)
	and 16
sfxRoutineNoise_border:
	or 0
	out ($fe),a
	dec d
	jr nz,sfxRoutineNoise_l2
	ld d,e
	inc hl
	ld a,h
	and $1f
	ld h,a
sfxRoutineNoise_l2:
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineNoise_l1

	ld a,e
	add a,(ix+6)	;slide
	ld e,a

	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineNoise_l0

	ld c,7
	jr nextData

soundEffectsData:
	defw soundEffectsData_sfx0
	defw soundEffectsData_sfx1
	defw soundEffectsData_sfx2
	defw soundEffectsData_sfx3
	defw soundEffectsData_sfx4
	defw soundEffectsData_sfx5
	defw soundEffectsData_sfx6
	defw soundEffectsData_sfx7

soundEffectsData_sfx0:
	defb 1 ;tone
	defw 1000,10,100,0,25728
	defb 0

soundEffectsData_sfx1:
	defb 1 ;tone
	defw 5,1800,1000,1000,65408
	defb 0
	
soundEffectsData_sfx2:
	defb 1 ;tone
	defw 50,100,200,65531,128
	defb 0
	
soundEffectsData_sfx3:
	defb 2 ;noise
	defw 1,1000,10
	defb 2 ;noise
	defw 1,1000,1
	defb 0
	
soundEffectsData_sfx4:
	defb 2 ;noise
	defw 1,1000,10
	defb 1 ;tone
	defw 20,100,400,65526,128
	defb 2 ;noise
	defw 1,2000,1
	defb 0

soundEffectsData_sfx5:
	defb 2 ;noise
	defw 1,1000,8
	defb 1 ;tone
	defw 1,1000,800,0,128
	defb 2 ;noise
	defw 1,1000,16
	defb 1 ;tone
	defw 1,1000,700,0,128
	defb 0

soundEffectsData_sfx6:
	defb 2 ;noise
	defw 2,2000,32776
	defb 0	
	
soundEffectsData_sfx7:
	defb 2 ;noise
	defw 1,1000,4
	defb 1 ;tone
	defw 1,1000,2000,0,128
	defb 0
	
End Asm
End Sub
