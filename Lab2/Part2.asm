.data
	newLine: .asciiz "\n"
	
	askNum: .asciiz "Enter the to-be-reversed integer: "
	revBin: .asciiz "Binary-reversed result: "
	
.text
	main:
		jal reverser
		
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
		
		# Put shift amount into t7
		li $t7, 31
		
		loop1:
			add $t0, $t0, $s0 # Copy the integer to t0
			srlv $t1, $t0, $t7 # Shift by counter
			bnez $t1, exit1 # If the right most bit is one, exit the loop
			beqz $t7, exit1 # If the counter became 0 without any 1s in the integer, exit the loop
			addi $t7, $t7, -1
			j loop1
		
		exit1: # Here t7 is the bit count before the left most bit
			
			move $t4, $t7 # Storing for another use
			
			li $t6, 32 # t6 is keeping the most number of bits
			sub $t7, $t6, $t7 #  t7 becomes the bit count after the left most bit
			
		li $v0, 1
		loop2:
       			# print the current bit
        		move $a0, $t1
        		syscall

        		beq $t7, $t6, exit2 # If t7 reaches 32, end the loop

        		add $t0, $zero, $s0 # Load the integer
        		sllv $t0, $t0, $t7 # Shift left by counter
        		srl $t1, $t0, 31 # Isolate the bit
        		addi $t7, $t7, 1 # Increment shift amount
        		
        		j loop2
        	
        	exit2:

    			li $v0, 4
    			la $a0, newLine
    			syscall
    			
    			la $a0, revBin
    			syscall
    			
    			# Print reverse binary
    			addi $t6, $t6, -1 # t6 becomes 31
    			move $t7, $t4 # Put t7's value back to t7 (post first loop) 
    			li $t4, 0 # Reset t4
    			li $v0, 1 # Set to print integers
    			li $t5, 0 # Reset t5
    			add $t0, $zero, $s0 # Set t0 to input integer
    			
    			loop3:
        			sub $t4, $t6, $t5 # Put the desired shift amount to t4
        			sllv $t1, $t0, $t4 # Shift left t1 to delete leftover bits on the left
        			srl $a0, $t1, 31 # Same again, but now to reach the desired bit
        			syscall # Print current bit
        			beq $t5, $t7, exit3 # If the reversal is complete, exit the loop
        			addi $t4, $t4, 1 # Incfease the shift amount by one
        			addi $t5, $t5, 1 # Incfease the counter by one
        			j loop3
        			
    			exit3:
    				li $v0, 4
    				la $a0, newLine
    				syscall
