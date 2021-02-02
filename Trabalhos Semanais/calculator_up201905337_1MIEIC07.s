.text
.global Calculator
.type Calculator,"function"

Calculator: stp X29, X30, [sp, #-16]!
			stp X19, X20, [sp, #-16]!
			stp X21, X22, [sp, #-16]!
			str X23, [sp, #-16]!
saveReg:	mov W19, W0
			mov X20, X1
			mov X21, X2
			mov X22, X3
			mov W23, W0
CICLO:		cbz W19, NOV
			sub W19, W19, #1
			ldrb W4, [X20], #1
			ldr W5, [X21], #4 // B
			ldr W6, [X22], #4 // A
			cmp W4, #80
			b.EQ POWER
			cmp W4, #43
			b.EQ SUM
			cmp W4, #45
			b.EQ SUBT
MUL:		smull X12, W6, W5
			cls X13, X12
			cmp X13, #31
			b.LS OVERFLOW
			str W12, [X22, #-4]
			b CICLO
SUM:		adds W4, W6, W5
			b.VS OVERFLOW
			str W4, [X22, #-4]
			b CICLO
SUBT:		subs W4, W6, W5
			b.VS OVERFLOW
			str W4, [X22, #-4]
			b CICLO
POWER:		mov W0, W6
			mov W1, W5
			bl power
			cbz W0, OVERFLOW
			str W0, [X22, #-4]
			b CICLO
OVERFLOW:	sub W0, W23, W19
			b FIM
NOV:		mov W0, #0
FIM:		ldr X23, [sp], #16
			ldp X21, X22, [sp], #16
			ldp X19, X20, [sp], #16
			ldp X29, X30, [sp], #16
			ret
