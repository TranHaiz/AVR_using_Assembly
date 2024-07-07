;
; ExternalInterupt.asm
;
; Created: 26/04/2024 7:13:24 CH
; Author : PROBOOK
;


; Replace with your application code
	.Include "M328Pdef.inc"
			.Cseg
			.Org 0x0000 		;Location for reset  
			Jmp Main  

			.ORG 0x0002 		;Location for external interrupt 0  
			Jmp externalISR0  

Main:		Ldi R20,HIGH(RAMEND)  
			Out SPH,R20  
			Ldi R20,LOW(RAMEND)  
			Out SPL,R20 		;Set up the stack  

			Ldi R20,0x02 		;Make INT0 falling edge triggered  
			Sts EICRA,R20		;External Interrupt Control Register A

			Ldi R20,0x01		;Enable INT0 - 0b00000001
			Out EIMSK,R20		;External Interrupt MaSK
			Sei 				;Enable global interrupt  

			Sbi PORTD,2 		;Activated pull-up  

			Ldi R17,0xFF
			Out DDRB,R17 		;Set PortB DDR to output mode
			out DDRC, R17
			ldi R19,0x01
Repeat:		out PortB, r19
			call delay1
			lsl r19
			sbic PortB, 5
			jmp Reset
			Jmp Repeat 
Reset:		ldi r19, 0x01
			rjmp Repeat
/* ---------- Interrupt Service Routine ------------ */
externalISR0:	
			In R16, PORTC		;Read PORTB
			Ldi R17,0x04		;00000100 - PORTB.2
			Eor R16,R17			;Toggle PORTB.2 using EOR
			Out PORTC,R16		;Display PORTB.2
			call delay1
			Eor R16,R17			;Toggle PORTB.2 using EOR
			Out PORTC,R16		;Display PORTB.2
			call delay1
			Eor R16,R17			;Toggle PORTB.2 using EOR
			Out PORTC,R16		;Display PORTB.2
			Reti
delay1: 
	ldi  r21, 21
    ldi  r22, 75
    ldi  r23, 191
L1: dec  r23
    brne L1
    dec  r22
    brne L1
    dec  r21
    brne L1
    nop
	ret
