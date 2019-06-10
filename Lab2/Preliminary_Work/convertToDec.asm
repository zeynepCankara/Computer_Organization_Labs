# Zeynep Cankara -- 04/03/2019
# Course: CS223
# Section: 02
# Lab: 02
# convertToDec.asm -- Converts user input octal to decimal

#************************
#					 	*
#		text segment	*
#						*
#************************
	.globl __start
	.text	
__start:
	# Request the string
	la $a0, promptOctal
	li $v0, 4
	syscall
	la $a0, octalAddress
	li $a1, 21 # max 21 bytes to read 
	li $v0, 8 # read octal number as string
	sw $a0, octalAddress
	syscall
	# load the address
	la $a0, octalAddress
	# Converts user input str (octal) to dec
	jal convertToDec
	
	# print the decimal value
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall # Exit the programme
	
convertToDec:
	malloc:	# allocate the stack space
		subi $sp, $sp, 20
		sw $s0, 16($sp) 	
		sw $s1, 12($sp)
		sw $s2, 8($sp)
		sw $s3, 4($sp)
		sw $ra, 0($sp)
	# find end of the string
	# s0 contains address of the last char after stringEnd
	stringEnd:
		move $s0, $a0 # s0: address of the string
		nextChar:
			lb $s1, 0($s0) # s1: current char
			blt $s1, 10, foundEnd # "enter" (ASCII : 10)"
			addi $s0, $s0, 1 # goto next char
			j nextChar
		foundEnd:
				subi $s0, $s0, 2 # excluding enter (ASCII: 10)
	li $s2, 1 # go from lsd(least sig digit) to msd(most sig digit)
	li $s3, 8
	li $v0, 0 # will contain the result
	calcDec:
		# check beginning of string reached or not
		blt $s0, $a0, finish
		lb $s1, 0($s0) # load the octal character
		bgt $s1, 56, notValidOctal # digit > 7 (not valid octal value)
		blt $s1, 48, notValidOctal # digit < 0 (not valid octal value)
		asciiToDec:
			subi $s1, $s1, 48 # get the decimal value
			mul $s1, $s2, $s1 # adjust 
		# add to the result
		add $v0, $v0, $s1
		# decrement the address go to the next char in string
		subi $s0, $s0, 1
		mul $s2, $s2, $s3 # 8**(digit)
		j calcDec
	notValidOctal:
		# raise an error
		li $v0, -1
	finish:
		# obtained the result in v0
	calloc:	# deallocate the stack space
		lw $ra, 0($sp)
	 	lw $s3, 4($sp)
	 	lw $s2, 8($sp)
	 	lw $s1, 12($sp)
	 	lw $s0, 16($sp)
	 	addi $sp, $sp, 20
	jr $ra # return main



#************************
#					 	*
#		data segment	*
#						*
#************************
	.data
octalAddress: .space 8
promptOctal: .asciiz "\nPlease enter the octal value(7 digits max): "