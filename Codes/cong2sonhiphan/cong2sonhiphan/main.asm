.include"m328Pdef.inc"
.Cseg
.Org 0x00
.def tBCD	= r21			;add this to main asm file
.def Temp= r17
ldi r16, 0xFF	
out ddrD, r16	
ldi r16, 0xE1
out ddrB , r16	
ldi r16, 0xF0
out ddrc,  r16
ldi r22, 0x01
ldi r23, 0xA
start:
	in r17, pinB
	in r18, pinC
	cbr r18, 0x40
	add r17, r18	
	rjmp BCD
BCD:
	clr	tBCD			;clear temp reg
bBCD8_1:
	subi	Temp,10		;input = input - 10
	brcs	bBCD8_2		;abort if carry set
	add		tBCD,r22 		;tBCD = tBCD + 1
	rjmp	bBCD8_1		;loop again
bBCD8_2:
	add 	Temp, r23		
	rjmp hienthi
hienthi:
	lsl tBCD
	lsl tBCD
	lsl tBCD
	lsl tBCD
	add Temp, tBCD
	out portD, Temp
	rjmp start