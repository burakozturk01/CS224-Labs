.data
	array: .word 5,4,-2,9
	arrsize: .word 4
	
	newLine: .asciiz "\n"
	spaces: .asciiz "      "
	avgLabel: .asciiz "Average: "
	maxLabel: .asciiz "Max: "
	minLabel: .asciiz "Min: "
	
	tableHeader: .asciiz "MemoryAddress   ArrayElement\nPosition(hex)   Value(int)\n=============   ===========\n"
	
	 sym: .asciiz "Array is symmetric"
	asym: .asciiz "Array is not symmetric"
.text
	#Print header
	li $v0, 4
	la $a0, tableHeader
	syscall
	
	#t0: array, t1 = arrsize
	la $s0, array   # s0: array's address
	lw $s1, arrsize # s1: # of elements in array
	
	add $t1, $s0, $zero
	li $t0, 0
	while1:
		beq $t0, $s1, out1
		
		li $v0, 34
		add $a0, $t1, $zero
		syscall
		
		li $v0, 4
		la $a0, spaces
		syscall
		
		li $v0, 1
		lw $a0, 0($t1)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		addi $t1, $t1, 4
		
		add $t0, $t0, 1
		j while1
		
	out1:
	
	add $t1, $s0, $zero
	li $t0, 0
	while2:
		beq $t0, $s1, average
		
		lw $t2, 0($t1)
		add $t3, $t3, $t2
		addi $t1, $t1, 4
		
		add $t0, $t0, 1
		j while2
	
	average:
		div $s2, $t3, $s1 #s2: average of array
		
		li $v0, 4
		la $a0, avgLabel
		syscall
		
		li $v0, 1
		add $a0, $s2, $zero
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
	
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	
	li   $s2, 0             # Counter
	li   $s3, 0             # Max value
	li   $s4, -1            # Index
	
	maxloop:
		sll $t1, $s2, 2
		add $t1, $t1, $s0
		lw $t0, 0($t1)
		slt $t2, $t0, $s3
		bne $t2, $zero, Lmax
		ori $s3, $t0, 0
		ori $s4, $s2, 0
		
	Lmax:
		addi $s2, $s2, 1
		bne $s2, $s1, maxloop
		
	li $v0, 4
	la $a0, maxLabel
	syscall
	
	li $v0, 1
	add $a0, $s3, $zero
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	
	li   $s2, 0             # Counter
	li   $s3, 0             # Min value
	li   $s4, -1            # Index
	
	minloop:
		sll $t1, $s2, 2
		add $t1, $t1, $s0
		lw $t0, 0($t1)
		slt $t2, $s3, $t0
		bne $t2, $zero, Lmin
		ori $s3, $t0, 0
		ori $s4, $s2, 0
		
	Lmin:
		addi $s2, $s2, 1
		bne $s2, $s1, minloop
		
	li $v0, 4
	la $a0, minLabel
	syscall
	
	li $v0, 1
	add $a0, $s3, $zero
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall

    	exit:
    		li $v0,10
    		syscall
