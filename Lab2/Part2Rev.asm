.data
	newLine: .asciiz "\n"
	
	askNum: .asciiz "Enter the to-be-reversed integer: "
	revBin: .asciiz "Binary-reversed result: "
	
.text
	main:
		jal reverser
		
		li $v0, 4
		la $a0, revBin
		syscall
		
		li $v0, 1
		move $a0, $s1
		syscall
		
		li $v0, 10
		syscall
	
	reverser:
		# Receive decimal number
		li $v0, 4
		la $a0, askNum
		syscall
		
		# Store the integer in s0
		li $v0, 5
		syscall
		move $s0, $v0
		
		move $t0, $s0
		while:
			ble $t0, 0, exit
			
			sll $t1, $t1, 1
			
			and $t2, $t0, 1
			beq $t2, 0, skip
			
			xor $t1, $t1, 1
			
			skip:
			srl $t0, $t0, 1
			
			j while
		exit:
			move $s1, $t1
		
		jr $ra
