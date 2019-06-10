# Zeynep Cankara -- 27/02/2019
# Course: CS223
# Section: 02
# Lab: 01
# Program5.asm -- Interactive menu to perform operations on an user defined array (max size 100 elements (int) )

#************************
#					 	*
#		text segment	*
#						*
#************************
	.globl __start
	.text	
__start:
	# Print an intro message on screen
	li $v0, 4
	la $a0, intro
	syscall
	# Instantiating the array
	jal setSize
	jal setItems
	# start interactive menu program
	menu:	
		# display the menu
		jal displayMenu
		# read the user input type(char)
		li $v0, 12 # v0 contains char
		syscall
		# load character options into the registers
		li $t0, 'a'
		li $t1, 'b'
		li $t2, 'c'
		li $t3, 'd'
		li $t4, 'e'
		# make calls to the subprogram labels according to the which option chosen
		beq $v0, $t0, subA
		beq $v0, $t1, subB
		beq $v0, $t2, subC
		beq $v0, $t3, subD
		beq $v0, $t4, end # quit the menu
		# invalid character print an error message
		li $v0, 4
		la $a0, errorMsg
		syscall
		j menu
		# make function calls to the subprograms
		subA:
			jal sumGreaterThanThreshold
			j loop
		subB:
			jal sumWithinRange
			j loop
		subC:
			jal modDivisibleBy
			j loop
		subD:
			jal numOfUniqueNum
			j loop
		loop:
			# Display menu again
			j menu
	end:
		# exit from the loop
		
		
	# exit the program
	li $v0, 10	
	syscall
	
# Function to read size of the array
setSize:
	# prompt user to enter size of the array
	li $v0, 4
	la $a0, arrayMsg
	syscall
	
	# read the user input
	li $v0, 5
	syscall
	sw $v0, size
	jr $ra # go to start (main)
	
# Function for instantiating the array with the user input 
setItems:
	lw $t1, size # load the size into the t1
	la $t0, array # load the base address into the t0
	add $t2, $0, $0 # i = 0 (index)
	# prompt user to enter the values
	la $a0, readItemsMsg
	li $v0, 4
	syscall
	readInput:
		li $v0, 5	# user input (int)
		syscall
		# write data to the current index
		sw $v0, 0($t0)
		# increment array index by one position (4 bytes)
		addi $t0, $t0, 4	# array[i]
		# increment the index
		addi $t2, $t2, 1	# i += 1
		# continue if i < size
		blt $t2, $t1, readInput
	jr $ra # go to the next instruction


# Function for displaying the menu
displayMenu:
	li $v0, 4
	la $a0, menuMsg
	syscall
	la $a0, subProgramA
	syscall
	la $a0, subProgramB
	syscall
	la $a0, subProgramC
	syscall
	la $a0, subProgramD
	syscall
	la $a0, subProgramE
	syscall	
	jr $ra # back to start	

# Function returns summation of items greater than the threshold
sumGreaterThanThreshold:
	# save $s0 , $s1, $s3 registers
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s3, 8($sp)
	# load the array address and array size from memory
	la $t0, array
	lw $t1, size
	addi $s0, $0, 0 # sum = 0 # s0 reg contains sum
	addi $t2, $0, 0 # (index) i = 0
	# prompt user to enter the threshold
	la $a0, thresholdMsg
	li $v0, 4
	syscall
	# read user inptut
	li $v0, 5
	syscall
	move $s1, $v0 # s1 reg contains threshold
	forLoop:
		# check whether current element greater than the threshold
		lw $t3, 0($t0) # store current item in t3
		bgt $t3, $s1, addToSum
		j pass
		addToSum:
			add $s0, $s0, $t3
		pass:
			addi $t0, $t0, 4 # increment array position
			addi $t2, $t2, 1 # i += 1
			blt $t2, $t1, forLoop
	# store the sum
	sw, $s0, sum
	# display the sum
	la $a0, sumMsg
	li $v0, 4
	syscall
	li $v0, 1
	lw $a0, sum
	syscall
	#restore back $s0, $s1, $s3 registers
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	addi $sp, $sp, 12
	jr $ra # go back to start

# Function calculates the sum of elements within the range
sumWithinRange:
	# save $s0 , $s1, $s3 registers
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s3, 8($sp)
	# Load array with it's size
	la $t0, array
	lw $t1, size
	addi $s0, $0, 0 # sum = 0 # s0 reg contains sum
	addi $t2, $0, 0 # (index) i = 0
	# ask user to specify the range
	readRange:
		# ask the user specify the range
		la $a0, rangeMsg
		li $v0, 4
		syscall
		# read user inptut start index
		li $v0, 5
		syscall
		move $s1, $v0 # s1 contains the start index
		li $v0, 5
		syscall
		move $s3, $v0 # s3 contains the end index
		blt $s3, $s1, readRange # user end index < start index prompt user to enter a range again
	# iterate through the array
	readItems:
		lw $t4, 0($t0)
		# check whether current item within the range
		blt $t4, $s1, done # not in range element < rangeStart
		bgt $t4, $s3, done # not in range element > rangeEnd
		#add current item to the sum
		add $s0, $s0, $t4
		done:
			addi $t0, $t0, 4 # increment the array index
			addi $t2, $t2, 1 # i += 1
			blt $t2, $t1, readItems
	# display the sum to the user
	la $a0, rangeResult
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	#restore back $s0, $s1, $s3 registers
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	addi $sp, $sp, 12
	jr $ra # go back to start

# Function displays number of occurances divisible by user input
modDivisibleBy:
	# save $s0 , $s1, $s3 registers
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s3, 8($sp)	
	# Load array with it's size
	la $t0, array
	lw $t1, size
	addi $s0, $0, 0 # occurances = 0 # s0 reg contains occurances
	addi $t2, $0, 0 # (index) i = 0
	# ask user to specify number to divide by
	la $a0, modMsg
	li $v0, 4
	syscall
	# read the user inptut
	li $v0, 5
	syscall
	move $s1, $v0 # s1 contains the number to divide
	# iterate through the array
	forLoop1:
		# save item at current index in t3
		lw $t3, 0($t0)
		div $t3, $s1 # item/input
		mfhi $s3 # store the remainder in s3
		bne $s3, $0, continue
		addi $s0, $s0, 1
		continue:
			addi $t0, $t0, 4
			addi $t2, $t2, 1
			blt $t2, $t1, forLoop1
	# display the number of occurances
	la $a0, modResult
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	#restore back $s0, $s1, $s3 registers
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	addi $sp, $sp, 12
	jr $ra # go back to start

# Function displays number of unique numbers within the array
numOfUniqueNum:
	# save $s0 , $s1, $s3 registers
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s3, 8($sp)	
	# Load array with it's size
	la $t0, array
	lw $t1, size
	addi $s0, $0, 0 # unique = 0 # s0 reg contains occurances
	addi $t2, $0, 0 # (index) i = 0
	# iterate through the array
	forLoopOrig:
		# save item at current index in t3
		lw $t3, 0($t0)
		# check whether current element is unique
		isUnique:
			la $s1, array # start iterating from start
			addi $s3, $0, 0 # j type(int) = 0
			# iterate unique array
			loopUnique:
				# save item at current index in t3
				lw $t5, 0($s1)
				beq  $t2, $s3, addIt # increment if everything checked untill current
				beq $t5, $t3, done3 # element is not unique
				#addi $t7, $s3, 1
				bne $t2, $s3, skip
				# increment unique numbers
				addIt:
					addi $s0, $s0, 1 
				skip: 
				# not all elements being checked
				pass2:
					addi $s3,$s3, 1 # j += 1
					addi $s1,$s1, 4
					ble $s3, $t2, loopUnique 
		done3:
			addi $t2, $t2, 1
			addi $t0, $t0, 4
			blt $t2, $t1, forLoopOrig 
	# display the number of occurances
	la $a0, uniqueResult
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	#restore back $s0, $s1, $s3 registers
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	addi $sp, $sp, 12
	jr $ra # go back to start
#************************
#					 	*
#		data segment	*
#						*
#************************
	.data
array: .space  400 # word (4 bytes) => 100 words (100 bytes), array of 100 bytes allocated
size: .word  0 # type(int) user input (4 bytes)
sum: .word 0 # type(int) 
menuMsg: .asciiz "\n************ Interactive Menu ************\n"
subProgramA: .asciiz "*** Press (a) to find summation of items greater than the threshold input.\n"
subProgramB: .asciiz "*** Press (b) to find summation of items within the user specified range (inclusive) specified by the user display the sum.\n"
subProgramC: .asciiz "*** Press (c) to display the number of occurrences of the items divisible by the input.\n"
subProgramD: .asciiz "*** Press (d) to display number of unique characters.\n"
subProgramE: .asciiz "*** Press (e) to quit.\n"
intro: .asciiz "\nProgram: Interactive menu for performing operations on an user defined array.\n"
arrayMsg: .asciiz "\nEnter the size of the array: (1 <= size <= 100): " 
readItemsMsg: .asciiz "\nEnter the array items: \n"
thresholdMsg: .asciiz "\nEnter the threshold value: "
sumMsg: .asciiz "\nSum above threshold is: "
rangeMsg: .asciiz "\nEnter range [start, end]:\n"
rangeResult: .asciiz "\nSum within the range [start, end]: "
modMsg: .asciiz "\nPlease enter the number you want to divide by: "
modResult: .asciiz "\nNumber of occurances numbers divisible by the user input: "
errorMsg: .asciiz "\nInvalid character!!! Choose a valid option." 
uniqueResult: .asciiz "\nNumber of unique elements: " 
