.data
	newLine: .asciiz "\n"
	formMsg: .asciiz "The formula is A = (B % C + D) / B * (C - D)\n"
	inpMsg: .asciiz "Please enter an integer: "
	finalMsg: .asciiz "Result is: "
	
.text
	li $s0, 0 # Reg for result
	
	li $v0, 4
	la $a0, formMsg
	syscall
	
	# Reading and saving variable B
	li $v0, 4
	la $a0, inpMsg
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	# Reading and saving variable C
	li $v0, 4
	la $a0, inpMsg
	syscall
	
	li $v0, 5
	syscall
	move $s2, $v0
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	# Reading and saving variable D
	li $v0, 4
	la $a0, inpMsg
	syscall
	
	li $v0, 5
	syscall
	move $s3, $v0
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	# A = (B % C + D) / B * (C - D)
	
	# t0: B % C
	div $s1, $s2
	mfhi $t0
	
	# t0: B % C + D
	add $t0, $t0, $s3
	
	# t0: (B % C + D) / B
	div $t0, $s1
	mflo $t0
	
	# t1: C - D
	sub $t1, $s2, $s3
	
	# s0: (B % C + D) / B * (C - D)
	mul $s0, $t0, $t1
	
	# Print result
	li $v0, 4
	la $a0, finalMsg
	syscall
	
	li $v0, 1
	add $a0, $s0, $zero
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	# Exit
	li $v0, 10
	syscall