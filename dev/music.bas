'' Música del juego

sub playMusic()
asm

; *****************************************************************************
; * The Music Box Player Engine
; *
; * Based on code written by Mark Alexander for the utility, The Music Box.
; * Modified by Chris Cowley
; *
; * Produced by Beepola v1.06.01
; ******************************************************************************
 
START:
                          LD   A,(HL)                         ; Get the loop start pointer
                          LD   (PATTERN_LOOP_BEGIN),A
                          INC  HL
                          LD   A,(HL)                         ; Get the song end pointer
                          LD   (PATTERN_LOOP_END),A
                          INC  HL
                          LD   (PATTERNDATA1),HL
                          LD   (PATTERNDATA2),HL
                          LD   A,254
                          LD   (PATTERN_PTR),A                ; Set the pattern pointer to zero
                          DI
                          CALL  NEXT_PATTERN
                          EI
                          RET
NEXTNOTE:
                          DI
                          CALL  PLAYNOTE

                          EI
                          RET                                 ; Return from playing tune 
						  
PATTERN_PTR:              DEFB 0

NOTE_PTR:                 DEFB 0


; ********************************************************************************************************
; * NEXT_PATTERN
; *
; * Select the next pattern in sequence (and handle looping if we've reached PATTERN_LOOP_END
; * Execution falls through to PLAYNOTE to play the first note from our next pattern
; ********************************************************************************************************
NEXT_PATTERN:
                          LD   A,(PATTERN_PTR)
                          INC  A
                          INC  A
                          DEFB $FE                           ; CP n
PATTERN_LOOP_END:         DEFB 0
                          JR   NZ,NO_PATTERN_LOOP
                          DEFB $3E                           ; LD A,n
PATTERN_LOOP_BEGIN:       DEFB 0
NO_PATTERN_LOOP:          LD   (PATTERN_PTR),A
			                    DEFB $21                            ; LD HL,nn
PATTERNDATA1:             DEFW $0000
                          LD   E,A                            ; (this is the first byte of the pattern)
                          LD   D,0                            ; and store it at TEMPO
                          ADD  HL,DE
                          LD   E,(HL)
                          INC  HL
                          LD   D,(HL)
                          LD   A,(DE)                         ; Pattern Tempo -> A
	                	      LD   (TEMPO),A                      ; Store it at TEMPO

						  LD   A,B
                          LD   (NOTE_PTR),A

PLAYNOTE: 
			                    DEFB $21                            ; LD HL,nn
PATTERNDATA2:             DEFW $0000
                          LD   A,(PATTERN_PTR)
                          LD   E,A
                          LD   D,0
                          ADD  HL,DE
                          LD   E,(HL)
                          INC  HL
                          LD   D,(HL)                         ; Now DE = Start of Pattern data
                          LD   A,(NOTE_PTR)                   ; CLAVE
                          LD   L,A
                          LD   H,0
                          ADD  HL,DE                          ; Now HL = address of note data
                          LD   D,(HL)
                          LD   E,1

; IF D = $0 then we are at the end of the pattern so increment PATTERN_PTR by 2 and set NOTE_PTR=0
                          LD   A,D
                          AND  A                              ; Optimised CP 0
                          JR   Z,NEXT_PATTERN

                          PUSH DE
                          INC  HL
                          LD   D,(HL)
                          LD   E,1

                          LD   A,(NOTE_PTR)
                          INC  A
                          INC  A
                          LD   (NOTE_PTR),A                   ; Increment the note pointer by 2 (one note per chan)

                          POP  HL                             ; Now CH1 freq is in HL, and CH2 freq is in DE

                          LD   A,H
                          DEC  A
                          JR   NZ,OUTPUT_NOTE

                          LD   A,D                            ; executed only if Channel 2 contains a rest
                          DEC  A                              ; if DE (CH1 note) is also a rest then..
                          JR   Z,PLAY_SILENCE                 ; Play silence

OUTPUT_NOTE:              LD   A,(TEMPO)
                          LD   C,A
                          LD   B,0
                          XOR A	;
                          EX   AF,AF'
                          ;LD   A,BORDER_COL                   ; So now BC = TEMPO, A and A' = BORDER_COL
                          XOR A ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                          LD   IXH,D
                          LD   D,$10
EAE5:                     NOP
                          NOP
EAE7:                     EX   AF,AF'
                          DEC  E
                          OUT  ($FE),A
                          JR   NZ,EB04

                          LD   E,IXH
                          XOR  D
                          EX   AF,AF'
                          DEC  L
                          JP   NZ,EB0B

EAF5:                     OUT  ($FE),A
                          LD   L,H
                          XOR  D
                          DJNZ EAE5

                          INC  C
                          JP   NZ,EAE7

                          RET

EB04:
                          JR   Z,EB04
                          EX   AF,AF'
                          DEC  L
                          JP   Z,EAF5
EB0B:
                          OUT  ($FE),A
                          NOP
                          NOP
                          DJNZ EAE5
                          INC  C
                          JP   NZ,EAE7
                          RET

PLAY_SILENCE:
                          LD   A,(TEMPO)
                          CPL
                          LD   C,A
                          PUSH BC
                          PUSH AF
                          LD   B,0
SILENCE_LOOP:             PUSH HL
                          LD   HL,0000
                          SRA  (HL)
                          SRA  (HL)
                          SRA  (HL)
                          NOP
                          POP  HL
                          DJNZ SILENCE_LOOP
                          DEC  C
                          JP   NZ,SILENCE_LOOP
                          POP  AF
                          POP  BC
                          RET


; *** DATA ***
;BORDER_COL:               EQU $0
TEMPO:                    DEFB 218

MUSICDATA:
                    DEFB 0   ; Loop start point * 2
                    DEFB 2   ; Song Length * 2
PATTERNDATA:        DEFW      PAT0

; *** Pattern data consists of pairs of frequency values CH1,CH2 with a single $0 to
; *** Mark the end of the pattern, and $01 for a rest
PAT0:
         DEFB 218  ; Pattern tempo
             DEFB 54,1
             DEFB 72,1
             DEFB 45,1
             DEFB 72,1
             DEFB 48,1
             DEFB 45,1
             DEFB 40,1
             DEFB 64,1
             DEFB 61,1
             DEFB 45,1
             DEFB 48,1
             DEFB 54,1
             DEFB 72,1
             DEFB 45,1
             DEFB 72,1
             DEFB 48,1
             DEFB 45,1
             DEFB 40,1
             DEFB 64,1
             DEFB 61,1
             DEFB 81,1
             DEFB 48,1
             DEFB 40,1
             DEFB 54,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
         DEFB $0	 

MUSICDATAB:
                    DEFB 0   ; Loop start point * 2
                    DEFB 2   ; Song Length * 2
PATBTERNDATAB:        DEFW      PATB0

; *** PATBtern DATAB consists of pairs of frequency values CH1,CH2 with a single $0 to
; *** Mark the end of the PATBtern, and $01 for a rest
PATB0:
         DEFB 238  ; PATBtern tempo
             DEFB 81,1
             DEFB 72,1
             DEFB 68,1
             DEFB 61,1
             DEFB 54,1
             DEFB 48,1
             DEFB 45,1
             DEFB 40,1
             DEFB 76,1
             DEFB 64,1
             DEFB 57,1
             DEFB 51,1
             DEFB 43,1
             DEFB 81,72
             DEFB 72,68
             DEFB 68,61
             DEFB 61,54
             DEFB 54,48
             DEFB 48,45
             DEFB 45,40
         DEFB $0

end asm
end sub