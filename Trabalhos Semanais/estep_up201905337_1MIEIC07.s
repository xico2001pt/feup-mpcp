.text
.global eStep
.type eStep,"function"

eStep:	mov W9, W2
		mov X10, X3
LOOP1:	cbz W0, FIM
		ldp S0, S1, [X1], #8 // x1, y1
		fcvt D0, S0
		fcvt D1, S1
		sub W0, W0 ,#1
		mov X5, #0x7ff0000000000000
		fmov D4, X5
LOOP2:	cbz W2, RESET
		ldp D2, D3, [X3], #16 // x2, y2
		sub W2, W2 ,#1
		// Distance
		fsub D5, D2, D0
		fmul D5, D5, D5
		fsub D6, D3, D1
		fmul D6, D6, D6
		fadd D5, D5, D6
		fsqrt D5, D5
		fcmp D5, D4
		b.GE LOOP2
STORE:	fmov D4, D5
		sub W6, W9, W2
		sub W6, W6, #1
		str W6, [X4]
		b LOOP2
RESET:	mov W2, W9
		mov X3, X10
		add X4, X4, #4
		b LOOP1
FIM:	ret
