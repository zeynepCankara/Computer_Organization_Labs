# Zeynep Cankara -- 21/02/2019
# preLIMProblem3.asm -- Implements the arithmetic expression (c - d) % 16 without using div


## Text Section ##
	.globl __start
	.text
__start:
	# prompt the program task on screen
	li $v0, 4
	la $a0, task
	syscall
	
	# prompt user to enter c
	li $v0, 4
	la $a0, cMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, c
	
	# prompt user to enter d
	li $v0, 4
	la $a0, dMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, d
	
	# call the function to evaluate expression
	lw $a0, c
	lw $a1, d
	jal evaluate
	
	# print x
	li $v0, 4
	la $a0, xMsg
	syscall
	# print remainder
	li $v0, 1
	lw $a0, x
	syscall

	
	# exit the program
	li $v0, 10	
	syscall

## Function evaluates expression x = (c - d) % 16 without using command div
## Inputs: [$a0: c; $a1: d} 
## Outputs: {$v0: x}
evaluate:
	move $t0, $a0 # t0 holds c
	move $t1, $a1 # t1 holds d
	sub $t2, $t0, $t1 # t2 holds (c-d)
	blt $t2, $0, makePositive
	bge $t2, $0, eval
	makePositive:
		#mul $t2, $t2, -1 # if (c-d) < 0 do -1 * (c-d)
		addi $t2,$t2, 16 # consecutively add 16 to make (c-d) positive
		blt $t2, 0, makePositive
	eval:
		addi $t3, $0, 1 # int i = 1 (index)
		addi $t4, $0, 0 # int product = 0 
		while:
			mul $t4, $t3, 16 # product = 16 * i
			addi $t3, $t3, 1 # i += 1
			ble $t4, $t2, while
		# evaluate x
		# x  = (c-d) - (product - 16)
		subi $t4, $t4, 16  # (product - 16)
		sub $v0, $t2, $t4 # x  = (c-d) - (product - 16)
		sw $v0, x
	jr $ra
	
	
 	
## Data Section ##
	.data
task: .asciiz "Program implements the arithmetic expression x = (c - d) % 16 without using div. \n"
cMsg: .asciiz "Please enter c value: "
dMsg: .asciiz "\nPlease enter d value: "
xMsg: .asciiz "\nValue of x is "
c: .word  0 # c value type(int) size(4 bytes)
d: .word  0 # d value type(int) size(4 bytes)
x: .word  0 # x value type(int) size(4 bytes)

