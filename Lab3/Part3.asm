.data
line:	
	.asciiz "\n --------------------------------------"

nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
addressOfCurrentNodeLabel:
	.asciiz	"\n Address of Current Node: "
	
addressOfNextNodeLabel:
	.asciiz	"\n Address of Next Node: "
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "
.text
# CS224 Spring 2021, Program to be used in Lab3
# February 23, 2021
# 
	li	$a0, 10 	#create a linked list with 10 nodes
	move $s0, $a0
	jal	createLinkedList
	
	move $a0, $v0
	move $a1, $s0
	jal DisplayReverseOrderRecursively
	
	
# Stop. 
	li	$v0, 10
	syscall

createLinkedList:
# $a0: No. of nodes to be created ($a0 >= 1)
# $v0: returns list head
# Node 1 contains 4 in the data field, node i contains the value 4*i in the data field.
# By 4*i inserting a data value like this
# when we print linked list we can differentiate the node content from the node sequence no (1, 2, ...).
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	li	$s1, 1		# $s1: Node counter
# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.
	sll	$s4, $s1, 2	
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	
addNode:
# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	sll	$s4, $s1, 2	
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	j	addNode
allDone:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	jr	$ra
#=========================================================
DisplayReverseOrderRecursively:
# $a0: Points to the list head
# $a1: Node number to print

beq $a1, $zero, Done

# Save registers to the stack
addi $sp, $sp, -20
sw $t0, 16($sp)
sw $s0, 12($sp)
sw $s1, 8($sp)
sw $s2, 4($sp)
sw $ra, 0($sp)

# $a0 > $s0: Head node's address
move $s0, $a0

# $s1: Current node
move $s1, $s0

# $s1: $a1 th node's address
add $s2, $a1, -1 # Go $s2 times forward to find the node to print

# Node finder loop
li $t0, 1
findNode:
	beq $t0, $a1, found
	
	lw $s3, 0($s1)
	move $s1, $s3
	
	addi $t0, $t0, 1
	j findNode
	
found:

# Line seperator
la	$a0, line
li	$v0, 4
syscall

la	$a0, nodeNumberLabel
li	$v0, 4
syscall

move	$a0, $a1	# $s2: Counter is now counting backwards
li	$v0, 1
syscall

la	$a0, addressOfCurrentNodeLabel
li	$v0, 4
syscall
	
move	$a0, $s1	# $s1: Address of current node
li	$v0, 34
syscall

la	$a0, dataValueOfCurrentNode
li	$v0, 4
syscall
		
lw	$a0, 4($s1)	# $s2: Data of current node
li	$v0, 1		
syscall

# Recover head address
move $a0, $s0

# Reload registers from the stack
lw $t0, 16($sp)
lw $s0, 12($sp)
lw $s1, 8($sp)
lw $s2, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 20

# Recursive part depends on $a1 counting backwards
addi $a1, $a1, -1
j DisplayReverseOrderRecursively

Done:
jr $ra
