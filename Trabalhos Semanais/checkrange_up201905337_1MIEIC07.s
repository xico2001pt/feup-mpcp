.text
.global CheckRange
.type CheckRange,"function"

CheckRange:	mov W3, W1
			neg W5, W0
CICLO:		cbz W1, FIM
			ldr W4, [X2]
			cmp W4, W5
			b.LT infLim
			cmp W4, W0
			b.GT supLim
			sub W3, W3, #1
nextElem:	add X2, X2, #4
			sub W1, W1, #1
			b CICLO
infLim:		str W5, [X2]
			b nextElem
supLim:		str W0, [X2]
			b nextElem
FIM:		mov W0, W3
			ret
