.data
	addMask: .word 0xFC00003F # 11111100000000000000000000111111
	addFormat: .word 0x20 # 00000000000000000000000000100000
	
	addMsg: .asciiz "Number of add instructions: "
	lwMsg: .asciiz "Number of lw instructions: "
	
	newLine: .asciiz "\n"
.text
	### Main program
	
	## For main part counting
	
	# Address start, end labels
    L1:	la $a0, L1
	la $a1, L2
	
	# Function call and save v0 value
	jal instructionCount
	add $s0, $zero, $v0
	
	# -- Print add inst count --
	li $v0, 4
	la $a0, addMsg
	syscall
	
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	# -- Print add inst count --
	
	# -- Print lw inst count --
	li $v0, 4
	la $a0, lwMsg
	syscall
	
	li $v0, 1
	add $a0, $zero, $v1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	# -- Print lw inst count --
	syscall
	
	## For subprogram counting
	
	li $v0, 0
	li $v1, 0
	
	# Addresses
	la $a0, L3
	la $a1, L4
	
	# Function call and save v0
	jal instructionCount
	add $s0, $zero, $v0
	
	# -- Print add inst count --
	li $v0, 4
	la $a0, addMsg
	syscall
	
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	# -- Print add inst count --
	
	# -- Print lw inst count --
	li $v0, 4
	la $a0, lwMsg
	syscall
	
	li $v0, 1
	add $a0, $zero, $v1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	# -- Print lw inst count --
	syscall
	
	# End of the program
	li $v0, 10
    L2: syscall
	
	### Subprogram
	instructionCount:
		# a0: Address of the first instruction
		# a1: Address of the last instruction
		
		# v0: Number of add instructions
		# v1: Number of lw instructions
		
		# Mutatable variable for first address
	    L3: add $s0, $zero, $a0
		
		# Load required values
		lw $s2, addMask
		lw $s3, addFormat
		
		addLoop:				# Loop starts
			bgt $s0, $a1, exitAdd
			
			lw $s1, 0($s0)			# Take data from current address
			
			and $s1, $s1, $s2		# Mask s1 to keep only first and last 6 bits and making the rest 0
			
			beq $s1, $s3, addPlus		# Compare result with wanted sample, increase counter accordingly
			addCont:
			
			add $s0, $s0, 4			# Continue to next address
			
			j addLoop			# Loop ends
			
		exitAdd:
			add $s0, $zero, $a0		# Mutatable variable again
		
		lwLoop:					# Loop starts
			bgt $s0, $a1, exitLw
			
			lw $s1, 0($s0)			# Take data from current address
			
			srl $s1, $s1, 26		# Right shift 26 times to keep only last 6 bits
			
			beq $s1, 35, lwPlus		# Compare result with wanted sample, increase counter accordingly
			lwCont:
			
			add $s0, $s0, 4			# Continue to next address
			
			j lwLoop			# Loop ends
			
		exitLw: jr $ra
		
		# -- Counter increasers --
		addPlus:
			add $v0, $v0, 1
			j addCont
		
		lwPlus:
			add $v1, $v1, 1
		   L4:  j lwCont
		# -- Counter increasers --
		
		
		