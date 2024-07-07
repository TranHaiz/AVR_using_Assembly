;
; Internalinterupt.asm
;
; Created: 25/04/2024 10:38:03 SA
; Author : PROBOOK
;


; Replace with your application code
.Include "M328pdef.inc"
		.Org 0x0000			;Location for reset
		Jmp Main

		.Org 0x001A			;Location for Timer1 overflow
		Jmp Timer1ISR		;Jump to ISR for Timer1

		.Equ Duration = 0x18661 ;set up for timer/couter 3seconds overflow

/* Main program - initialization and infinite loop */
Main:	Ldi R20,HIGH(RAMEND)
		Out SPH,R20
		Ldi R20,LOW(RAMEND)
		Out SPL,R20			;Set up stack

		Ldi R20,0x01
		Sts TIMSK1,R20		;Enable Timer1 overflow interrupt

		Sei					;Set I-bit (enable Global Interrupt)
;--------------------Setting up Timer Counter--------------------
		Ldi R30, High(Duration)
		Sts TCNT1H, R30 
		Ldi R30, Low(Duration) 
		Sts TCNT1L, R30		
;---------------------------------------------------------------
		Ldi R31, 0x00		;0b00000000 - normal mode
		Sts TCCR1A, R31
		Ldi R31, 0x05		;0b00000101, prescaler = 1024 
		Sts TCCR1B, R31		;Timer will start counting after this 
							;instruction is executed.
;---------------------------------------------------------------

		Sbi DDRB,3			;DDRB.3 set to output mode 
		Sbi DDRD,6			;DDRD.6 set to output mode

		cbi PORTD,6			;Clear PortD.6 - initial state

/*--------------------- Infinite loop --------------------*/
Here:	Sbi PORTB,3
		call Delay2
		Cbi PORTB,3
		call Delay2
		Jmp Here			;Keeping CPU busy
		
/*------------------ISR for Timer1 -----------------------*/
Timer1ISR:
		
		Ldi R17,0x40		;0100 0000 for toggling PD6
		Eor R16,R17
		Out PORTD,R16		;Toggle PD6
		call delay1	
		Eor R16,R17
		Out PORTD,R16		;Toggle PD6	
    /*---------------------------------------------------*/
		Reti				;Return from interrupt

Delay2:
	ldi  r23, 41
    ldi  r24, 150
    ldi  r25, 127
L1: dec  r25
    brne L1
    dec  r24
    brne L1
    dec  r23
    brne L1
    nop
ret
delay1:
ldi  r25, 82
    ldi  r26, 43
    ldi  r27, 0
L2: dec  r27
    brne L2
    dec  r26
    brne L2
    dec  r25
    brne L2
    ret