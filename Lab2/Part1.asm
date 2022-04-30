.data
	array: .word 0, 7, 18, 18, -7, 0
	arrSize: .word 6
	
	newLine: .asciiz "\n"
	
	symTrue: .asciiz "The array is symmetric.\n"
	symFalse: .asciiz "The array is not symmetric.\n"
	
	maxLabel: .asciiz "Max: "
	minLabel: .asciiz "Min: "
	
.text
	main:
		# Initializing s-registers 0, 1 for array and size
		la $s0, array
		lw $s1, arrSize
		
		jal printArr
		
		# New line block
		li $v0, 4
		la $a0, newLine
		syscall
		
		jal isSymm
		
		# New line block
		li $v0, 4
		la $a0, newLine
		syscall
		
		jal findMaxMin
		
		# New line block
		li $v0, 4
		la $a0, newLine
		syscall
		
		# Terminate program at last
		li $v0, 10
		syscall
		
	printArr:
		move $t1, $s0 # Making t1 array address register
		while1:
			beq $t0, $s1, stop1 # Stopping loop when counter hits array size number
			
			# Loading current element of the array to t2 register
			# and moving to the next element
			lw $t2, 0($t1)
			add $t1, $t1, 4
			
			# Printing loaded element to console
			li $v0, 1
			move $a0, $t2
			syscall
			
			# New line block
			li $v0, 4
			la $a0, newLine
			syscall
			
			# Increase counter
			add $t0, $t0, 1
			j while1
			
		stop1:
			# Reset temp registers before moving on
			add $t0, $zero, $zero
			add $t1, $zero, $zero
			add $t2, $zero, $zero
			
		jr $ra
	
	isSymm:
		# In?tializing two temp registers...
		move $t0, $s0
		move $t1, $s0
		
		# ...from two ends of the array
		sub $t2, $s1, 1
		sll $t2, $t2, 2
		add $t1, $t1, $t2
		
		while2:
			# If two array pointers met at center or get past each other,
			# array is symmetric go to "yes"
			bge $t0, $t1, yes
			
			# -- Checking symmetry --
			lw $t3, 0($t0)
			lw $t4, 0($t1)
			
			bne $t3, $t4, no
			# -- Checking symmetry --
			
			add $t0, $t0, 4
			sub $t1, $t1, 4
			
			j while2
			
		yes:	# Print "symTrue"
			la $t5, symTrue
			li $v0, 4
			move $a0, $t5
			syscall
			
			j stop2
		
		no:	# Print "symFalse"
			la $t5, symFalse
			li $v0, 4
			move $a0, $t5
			syscall
			
			j stop2
		
		stop2:
			add $t0, $zero, $zero
			add $t1, $zero, $zero
			add $t2, $zero, $zero
			add $t3, $zero, $zero
			add $t4, $zero, $zero
			add $t5, $zero, $zero
		
		jr $ra
	
	findMaxMin:
		li   $s2, 0             # Counter
		li   $s3, 0             # Max value
		li   $s4, -1            # Index
	
		# Twin determiner loops
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
		
		# -- Print max value --
		li $v0, 4
		la $a0, maxLabel
		syscall
	
		li $v0, 1
		add $a0, $s3, $zero
		syscall
		# -- Print max value --
	
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
		
		# Twin determiner loops
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
		
		# -- Print min value --
		li $v0, 4
		la $a0, minLabel
		syscall
	
		li $v0, 1
		add $a0, $s3, $zero
		syscall
		# -- Print min value --
		
		jr $ra
