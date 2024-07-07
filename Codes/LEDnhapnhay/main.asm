;
; AssemblerApplication8.asm
;
; Created: 4/22/2024 11:17:18 AM
; Author : LENOVO
;


; Replace with your application code
.include "m328Pdef.inc" 
.Cseg
.Org 0x00 

start:
    ldi R16, 0xFF 
	out DDRB, R16 
	
	LDI R16, 0x00 
	OUT DDRD, R16 
	
	Ldi R17, 0x00
	 
HERE : IN R16, PIND        
 Sbrc R16, 4  
       Rjmp hienthi
	   Rjmp over 
hienthi: 
 Sbi Portb,0 
	call Delay
	Cbi PortB,0 
	call Delay
	Rjmp here 
Delay: ldi r24, 0xFF
loop1: ldi r23, 0xFF
loop2: dec r23 
       brne loop2 
	   dec r24 
	   brne loop1 
 RET
  
Over:  		
	out Portb, r17
	Rjmp here 
