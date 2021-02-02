.text
.global freqchars
.type freqchars,"function"
// W0: Numero de carteres no texto
// X1: Apontador para texto
// W2: Numero de letras a verificar (tipo char)
// X3: Apontador para as letras a verificar
// X4: Apontador que guarda freq rel
freqchars:	mov W15, #0
			mov W9, #0 // Carater mais freq
			fmov S10, W15 // Maior freq absoluta
			mov W10, W0 // Copia nr de carateres no texto
			mov X11, X1 // Copia endereço inicial do texto
			ucvtf S20, W0 // Transforma N em float
			mov W21, #100
			ucvtf S21, W21 // Transforma 100 em float
CICLO1:		cbz W2, FIM
			sub W2, W2, #1
			ldrb W12, [X3], #1
			dup V1.16B, W12 // Minuscula
			sub W12, W12, #32
			dup V2.16B, W12 // Maiuscula
			fmov S11, W15
CICLO2:		cbz W0, PROXIMO
			sub W0, W0, #16
			ldr Q0, [X1], #16
			CMEQ V3.16B, V0.16B, V1.16B
			addv B9, V3.16B
			smov W14, V9.B[0]
			scvtf S9, W14
			fadd S11, S11, S9
			CMEQ V3.16B, V0.16B, V2.16B
			addv B9, V3.16B
			smov W14, V9.B[0]
			scvtf S9, W14
			fadd S11, S11, S9
			b CICLO2
PROXIMO:	fneg S11, S11
			fdiv S9, S11, S20
			fmul S9, S9, S21
			str S9, [X4], #4
			// Restaurar copia
			mov W0, W10
			mov X1, X11
			fcmp S11, S10
			b.GT ALTERA
			b CICLO1
ALTERA:		add W12, W12, #32
			mov W9, W12
			fmov S10, S11
			b CICLO1
FIM:		mov W0, W9
			ret
