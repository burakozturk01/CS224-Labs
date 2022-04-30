.data
	array: .word 1, 2, 1
	arrsize: .word 3

.text
	la $t0, array
	lw $t1, 8($t0)