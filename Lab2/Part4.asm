.data
	sourceReg: .word 196852667
	pattern:   .word 187       # 1010
	mask:      .word 255       # 1111
	
	
.text
	lw $s0, sourceReg
	lw $s1, pattern
	lw $s2, mask
	
	jal count
	
	li $v0, 10
	syscall
	
	count:
		li $t2, 32
		cnt_while:
			bgt $t0, $t2, exit_cnt
			
			move $t1, $s0
			srlv $t1, $t1, $t0
			
			and $t1, $t1, $s2
			
			beq $t1, $s1, cnt
			
			cont:
			
			add $t0, $t0, 1
			j cnt_while
			
			cnt:
				add $s4, $s4, 1
				j cont
		
	exit_cnt:
		add $t0, $zero, $zero
		add $t1, $zero, $zero
		add $t2, $zero, $zero
		jr $ra
