.data
	dividendMsg: .asciiz "Please enter dividend: "
	divisorMsg: .asciiz "Please enter divisor: "
	quotientMsg: .asciiz "Quotient is "
	
	contMsg: .asciiz "Do you want to continue? (Yes => 1, No => 0)\n"
	
	newLine: .asciiz "\n"
	
.text
	Start:
		li $v0, 4
		la $a0, dividendMsg
		syscall
		
		li $v0, 5
		syscall
		add $s0, $zero, $v0
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4
		la $a0, divisorMsg
		syscall
		
		li $v0, 5
		syscall
		add $s1, $zero, $v0
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		add $a0, $zero, $s0
		add $a1, $zero, $s1
		
		jal RecursiveDivision
		add $s2, $zero, $v0
		
		li $v0, 4
		la $a0, quotientMsg
		syscall
		
		li $v0, 1
		add $a0, $zero, $s2
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4
		la $a0, contMsg
		syscall
		
		li $v0, 5
		syscall
		
		beq $v0, 1, Start
		
		li $v0, 10
		syscall
		
		RecursiveDivision:
			# a0: Dividend
			# a1: Divisor
			
			# v0: Quotient
			
			# Base case
			blt $a0, $a1, Return
			
			# Recursive part
			sub $a0, $a0, $a1
			add $s3, $s3, 1
			j RecursiveDivision
			
			Return:
				add $v0, $zero, $s3
				add $s3, $zero, $zero
				jr $ra