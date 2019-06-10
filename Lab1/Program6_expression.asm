# Zeynep Cankara -- 27/02/2019
# Program4.asm -- Implements the arithmetic expression x = (4 * a * b) % ((c - 2) / 3)

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

	
	## Get value a
	# prompt user to enter a
	li $v0, 4
	la $a0, aMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, a
	## Get value b
	# prompt user to enter b
	li $v0, 4
	la $a0, bMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, b
	## Get value c
	# prompt user to enter c
	li $v0, 4
	la $a0, cMsg
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, c
	
	# Call formula function
	jal formula
	
	beq $v0, -1, end
	# print x messGE
	li $v0, 4
	la $a0, xMsg
	syscall
	# print x
	li $v0, 1
	lw $a0, x
	syscall
	
	end:
	# modulo by 0
	# exit the program
	li $v0, 10	
	syscall
	
formula:
	lw $t0, a
	lw $t1, b
	lw $t2, c
	# formula: (a * b) % ((c - 2) / 3)
	mul $t3, $t0, $t1 # t3 contains (4 * a * b)
	mul $t3, $t3, 4 # t3 contains (4* a * b)
	subi $t4, $t2, 2 # t4 contains (c - 2)
	div $t4, $t4, 3 # t4 contains ((c - 2) / 3)
	# check whether expression ((c - 2) / 3) > 0
	ble $t4, 0, error
	
	blt $t3, $0, makePositive
	bge $t3, $0, eval
	
	makePositive:
		add $t3, $t3, $t3  # consecutively add (4 * a * b) to make (4* a * b)  positive
		blt $t3, 0, makePositive
	eval:
		addi $t5, $0, 1 # int i = 1 (index)
		addi $t6, $0, 0 # int product = 0 
		while:
			mul $t6, $t4, $t5 # product = ((c - 2) / 3) * i
			addi $t5, $t5, 1 # i += 1
			ble $t6, $t3, while
		# evaluate x
		# x  = (4* a * b) - (product - ((c - 2) / 3) )
		sub $t6, $t6, $t4  # (product - B)
		sub $v0, $t3, $t6 # A  = (B * C + D / B  - C)  - (product - B)
		sw $v0, x
		j done
	
	error: 
		# prompt user to enter c
		li $v0, 4
		la $a0, errorMsg
		syscall
		li $v0, -1
	done:
		jr $ra
#************************
#					 	*
#		data segment	*
#						*
#************************
	.data
task: .asciiz "Program implements the arithmetic expression x = (4* a * b) % ((c - 2) / 3)"
aMsg: .asciiz "\nPlease enter a value: "
bMsg: .asciiz "\nPlease enter b value: "
cMsg: .asciiz "\nPlease enter c value: "
xMsg: .asciiz "\nValue of x is "
errorMsg: .asciiz "\nModulo 0 is not defined."
a: .word  0 # A value type(int) size(4 bytes)
b: .word  0 # B value type(int) size(4 bytes)
c: .word  0 # C value type(int) size(4 bytes)
x: .word  0 # D value type(int) size(4 bytes)

	
	