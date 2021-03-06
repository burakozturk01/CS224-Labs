.text
	.globl __main
	
__main:
	# User menu
	la $a0, menuMsg
	li $v0, 4
	syscall
	
	la $a0, opt1
	li $v0, 4
	syscall
	
	la $a0, opt2
	li $v0, 4
	syscall
	
	la $a0, opt3
	li $v0, 4
	syscall
	
	la $a0, opt4
	li $v0, 4
	syscall
	
	la $a0, opt5
	li $v0, 4
	syscall
	
	la $a0, opt6
	li $v0, 4
	syscall
	
	la $a0, menuQst
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, 1, option1 # s0 <- N
	beq $v0, 2, option2 # s1 <- addr(arr)
	beq $v0, 3, option3
	beq $v0, 4, option4
	beq $v0, 5, option5
	beq $v0, 6, exit
	
option1:
	# Read N from user
	la $a0, getN
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 # s0: N
	
	j __main
	
option2:
	# Allocate array in memory
	# s0: N
	
	mul $t0, $s0, $s0 # t0: NxN
	
	move $a0, $t0
	li $v0, 9
	syscall
	
	move $s1, $v0 # s1: Head address of array
	move $t1, $s1
	
	li $t2, 1
	
	addi $t0, $t0, 1
	loop2:
		beq $t0, $t2, exit2
	
		sw $t2, 0($t1)
		addi $t1, $t1, 4
	
		addi $t2, $t2, 1
	
		j loop2
	exit2:
	
	j __main
	
option3:
	la $a0, getRow
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 # t0: i
	
	la $a0, getCol
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0 #t1: j
	
	# Displacement(a0) = (i - 1) x N x 4 + (j - 1) x 4
	addi $t0, $t0, -1  # i -= 1
	mul $t0, $t0, $s0  # i *= N
	sll $t0, $t0, 2    # i *= 4
	addi $t1, $t1, -1  # j -= 1
	sll $t1, $t1, 2    # j *= 4
	add $a0, $t0, $t1  # a0 = i + j
	
	add $a0, $a0, $s1
	
	lw $a0, 0($a0)
	li $v0, 1
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
			
	j __main
	
option4:
	#Average row-major
	move $t0, $s0 # t0: N
	move $t1, $s1 # t1: Head address
	
	add $s2, $zero, 0
	
	addi $s3, $zero, 1 # i
	addi $s4, $zero, 1 # j
	
	loop5:
		bgt $s4, $t0, row
		
		cont2:
		
		move $t2, $s3
		move $t3, $s4
		
		addi $t2, $t2, -1  # i -= 1
		mul $t2, $t2, $s0  # i *= N
		sll $t2, $t2, 2    # i *= 4
		addi $t3, $t3, -1  # j -= 1
		sll $t3, $t3, 2    # j *= 4
		add $t4, $t2, $t3
		
		add $t4, $t4, $t1
		
		lw $t5, 0($t4)
		
		#Test code
		#li $v0, 1
		#move $a0, $t5
		#syscall
		
		add $s2, $s2, $t5
		
		addi $s4, $s4, 1
		
		j loop5
		
		row:
		beq $s3, $t0, exit5
		
		addi $s3, $s3, 1
		li $s4, 1
		
		j cont2
		
	exit5:
	
	la $a0, avgMsg
	li $v0, 4
	syscall
	
	mul $t0, $t0, $t0
	div $a0, $s2, $t0
	
	li $v0, 1
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	j __main
	
option5:
	#Average column-major
	move $t0, $s0 # t0: N
	move $t1, $s1 # t1: Head address
	
	add $s2, $zero, 0
	
	addi $s3, $zero, 1 # i
	addi $s4, $zero, 1 # j
	
	loop4:
		bgt $s3, $t0, col
		
		cont:
		
		move $t2, $s3
		move $t3, $s4
		
		addi $t2, $t2, -1  # i -= 1
		mul $t2, $t2, $s0  # i *= N
		sll $t2, $t2, 2    # i *= 4
		addi $t3, $t3, -1  # j -= 1
		sll $t3, $t3, 2    # j *= 4
		add $t4, $t2, $t3
		
		add $t4, $t4, $t1
		
		lw $t5, 0($t4)
		
		#Test code
		#li $v0, 1
		#move $a0, $t5
		#syscall
		
		add $s2, $s2, $t5
		
		addi $s3, $s3, 1
		
		j loop4
		
		col:
		beq $s4, $t0, exit4
		
		addi $s4, $s4, 1
		li $s3, 1
		
		j cont
		
	exit4:
	
	la $a0, avgMsg
	li $v0, 4
	syscall
	
	mul $t0, $t0, $t0
	div $a0, $s2, $t0
	
	li $v0, 1
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	j __main
	
	
exit:
	li $v0, 10
	syscall

.data
	newLine: .asciiz "\n"
	
	menuMsg: .asciiz "Menu Options (1-6):\n"
	opt1:    .asciiz "1. Enter the dimensions of the matrix\n"
	opt2:    .asciiz "2. Allocate array\n"
	opt3:    .asciiz "3. Display an element\n"
	opt4:    .asciiz "4. Calculate average row by row\n"
	opt5:    .asciiz "5. Calculate average column by column\n"
	opt6:    .asciiz "6. Exit\n"
	menuQst: .asciiz "Your choose: "
	
	getN:    .asciiz "Enter N number: "
	getRow:  .asciiz "Enter row number: "
	getCol:  .asciiz "Enter column number: "
	
	avgMsg:  .asciiz "Average is "
