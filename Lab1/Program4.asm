# Zeynep Cankara -- 27/02/2019
# Program4.asm -- Implements the arithmetic expression A = (B * C + D / B  - C  ) Mod B

#************************
#					 	*
#		text segment	*
#						*
#************************

	.globl __start
	.text
__start:
	# prompt the program task on screen
	li $v0, 4
	la $a0, task
	syscall
	
	## Get value B
	# prompt user to enter B
	li $v0, 4
	la $a0, BMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, B
	## Get value C
	# prompt user to enter C
	li $v0, 4
	la $a0, CMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, C
	## Get value D
	# prompt user to enter D
	li $v0, 4
	la $a0, DMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, D
	
	# Call formula function
	jal formula
	
	# print A messGE
	li $v0, 4
	la $a0, AMsg
	syscall
	# print A
	li $v0, 1
	lw $a0, A
	syscall
	
	# exit the program
	li $v0, 10	
	syscall

# Calculates value A according to formula, returns value in v0 register
formula:
	lw $t0, B
	lw $t1, C
	lw $t2, D
	# formula: A = (B * C + D / B  - C) Mod B
	mul $t3, $t0, $t1 # t3 contains (B*C)
	add $t3, $t3, $t2 # t3 contains (B*C)+D
	sub $t4, $t0, $t1 # t4 contains (B-C)
	div $t2, $t3, $t4 # t2 contains (B * C + D / B  - C)
	blt $t2, $0, makePositive
	bge $t2, $0, eval
	makePositive:
		add $t2,$t2, $t0  # consecutively add B to make (B * C + D / B  - C)  positive
		blt $t2, 0, makePositive
	eval:
		addi $t3, $0, 1 # int i = 1 (index)
		addi $t4, $0, 0 # int product = 0 
		while:
			mul $t4, $t3, $t0 # product = B * i
			addi $t3, $t3, 1 # i += 1
			ble $t4, $t2, while
		# evaluate A
		# A  = (B * C + D / B  - C)  - (product - B)
		sub $t4, $t4, $t0  # (product - B)
		sub $v0, $t2, $t4 # A  = (B * C + D / B  - C)  - (product - B)
		sw $v0, A
	jr $ra

#************************
#					 	*
#		data segment	*
#						*
#************************
	.data
task: .asciiz "Program implements the arithmetic expression A = (B * C + D / B  - C  ) Mod B"
CMsg: .asciiz "\nPlease enter C value: "
BMsg: .asciiz "\nPlease enter B value: "
DMsg: .asciiz "\nPlease enter D value: "
AMsg: .asciiz "\nValue of A is "
A: .word  0 # A value type(int) size(4 bytes)
B: .word  0 # B value type(int) size(4 bytes)
C: .word  0 # C value type(int) size(4 bytes)
D: .word  0 # D value type(int) size(4 bytes)
