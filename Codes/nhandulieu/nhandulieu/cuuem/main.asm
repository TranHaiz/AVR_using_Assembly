;
; cuuem.asm
;
; Created: 4/22/2024 8:17:56 PM
; Author : me
;


; Replace with your application code
.CSEG
.ORG 0x00
RJMP start
.ORG 0x24
RJMP RX
start:
LDI R16, 0xFF
OUT DDRB, R16  // Thiet lap Port B lam ngo ra
LDI R17, 0x00
OUT PORTB, R17  // Thiet lap muc thap cho Port B
LDI R18, 0x08
OUT SPL, R16
OUT SPH, R18    // Khoi tao con tro ngan xep
LDI R19, 0x33
STS UBRR0L, R19   // chon toc do baud 9600
STS UBRR0H, R17   
LDI R20, 0x20
STS UCSR0A, R20   
LDI R21, 0x06
STS UCSR0C, R21   // Chon khung truyen 8 bit
LDI R22, 0x90
STS UCSR0B, R22  // Thiet lap bo nhan du lieu
SEI
wait:
RJMP wait
RX:
LDS R23, UDR0
OUT PORTB, R23  
RETI