# Zeynep Cankara -- 06/03/2019
# Course: CS224
# Section: 02
# Lab: 02
# Version: 1.2
# lab2.asm -- Lab 2 Solutions 

#*****************
#				 *
#	text segment *
#				 *
#*****************
	.text
	.globl __start
__start:
	# Function call
	jal interactWithUser

	# exit the program
	li $v0, 10
	syscall


## Function takes an array size from the user
## contents of the array is within [0, 100]
## array is dynamically allocated & deallocated
readArray:
	# allocate stack space
	addi $sp, $sp, -32
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	sw $s2, 16($sp)
	sw $s3, 20($sp)
	sw $s4, 24($sp)
	sw $s5, 28($sp)
	# Request the array size
	la $a0, promptSize
	li $v0, 4
	syscall
	# read the user input
	li $v0, 5
	syscall
	sw $v0, 0($sp)  # load size into the stack
	move $s0, $v0 # t0(sizeOfArray), v0(sizeOfArray)
	mul $a0, $v0, 4 # allocate the array space
	li $v0, 9 # dynamic alloc array
	syscall # v0( arrayBaseAddress )
	sw $v0, 4($sp)  # load baseAddress into the stack
	move $s1, $v0 # t1(baseAddress), v0(baseAddress)
	### READ USER INPUT ###
	la $a0, promptReadItems
	li $v0, 4
	syscall
	li $s2, 0 # i = 0 (index)
	# t1(baseAddress), $t0(sizeOfArray)
	readItems:
		li $v0, 5	# user input (int)
		syscall
		# check [0, 100]
		slti $s4, $v0, 101 # t4 ( num < 101 )
		sge $s5, $v0, 0 # t5 ( num >= 0 )
		and $s4, $s4, $s5 # t4( t4 and t5 )
		beq $s4, 1, valid
		beq $s4, 0, invalid
		valid:
			# write to current index
			sw $v0, 0($s1)
			# increment array pos
			addi $s1, $s1, 4	# addressArray = ddressArray + 4
			# increment the index
			addi $s2, $s2, 1	# i += 1
			j continue
		invalid:
			# display an error message
			la $a0, promptInvalidItem
			li $v0, 4
			syscall
		continue:
			blt $s2, $s0, readItems
	#restore from stack
	lw $s5, 28($sp)
	lw $s4, 24($sp)
	lw $s3, 20($sp)
	lw $s2, 16($sp)
	lw $s1, 12($sp)
	lw $s0, 8($sp)
	lw $v0, 4($sp) # obtain base address
	lw $v1, 0($sp) # obtain size
	addi $sp, $sp, 32
	jr $ra # goto next

## Insertion Sort implementation in assambly
## a0( arrayBaseAddress ), a1( sizeOfArray )
insertionSort:
	# save stack
	subi $sp, $sp, 32
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	sw $s2, 16($sp)
	sw $s3, 20($sp)
	sw $s4, 24($sp)
	sw $s5, 28($sp)
	# end of stack alloc
	# index
	li $s2, 1 # i = 0 (index)
	for:
		sll $s3, $s2, 2 # indexAddress =  index * 4
		add $s3, $a0, $s3
		lw $s1, 0($s3) # key = array[i]
		add $s4, $0, $s2 # j = i
		while:
			# obtain array[j - 1]
			subi $s3, $s3, 4
			lw $s5, 0($s3)# array[j-1]
			sgt $s6, $s4, 0 # j > 0
			sgt $s7, $s5, $s1 # array[j-1] > key
			and $s6, $s6, $s7 # t6(j > 0 && array[j-1] > key)
			beq $s6, 0, insert
			swap:
				sll $s6, $s4, 2 # t6(j * 4)
				add $s0, $a0, $s6
				# loadElements
				lw $s7, 0($s0) # t7( array[j] )
				subi $s0, $s0, 4
				lw $s6, 0($s0) # t6( array[j - 1] )
				#swap
				sw $s7, 0($s0)
				addi $s0, $s0, 4
				sw $s6, 0($s0)
				subi $s4, $s4, 1 # j -= 1
				j while
			insert:
				add $s3, $s3, 4
				sw $s1, 0($s3)
				addi $s2, $s2, 1 # i += 1
				blt $s2, $a1, for # continue i < size
	# load from the stack
	lw $s5, 28($sp)
	lw $s4, 24($sp)
	lw $s3, 20($sp)
	lw $s2, 16($sp)
	lw $s1, 12($sp)
	lw $s0, 8($sp)
	lw $v0, 4($sp)
	lw $v1, 0($sp)
	addi $sp, $sp, 32
	jr $ra # goto next

## Function takes arrayBaseAddress ($a0) sizeOfArray ($a1)
## Returns the mode ($v0) median ($v1)
medianMode:
	# save into the stack
	subi $sp, $sp, 40
	sw $s7, 36($sp)
	sw $s6, 32($sp)
	sw $s5, 28($sp)
	sw $s4, 24($sp)
	sw $s3, 20($sp)
	sw $s2, 16($sp)
	sw $s1, 12($sp)
	sw $s0, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	findMode:
		# Finding the mode
		move $s0, $a0 # t0(arrayAddress)
		li $s1, 1 # i = 1 (index)
		lw $s2, 0($s0) # num = array[i]
		move $s3, $s2 # mode = num
		li $s4, 1 # cnt = 1
		li $s5, 1 # cntMode = 1
		iter:
			sll $s6, $s1, 2 # t6(i *= 4)
			add $s6, $s0, $s6 # t6(array[i] address)
			lw $s7, 0($s6) # t7(array[i])
			# array[i] == num
			seq $s6, $s7, $s2
			beq $s6, 1, if
			beq $s6, 0, else
			if:
				# cnt ++
				addi $s4, $s4, 1
				addi $s1, $s1, 1
				blt $s1, $a1, iter # i < size
				j else
			else:
				sgt $s6, $s4, $s5 # cnt > cntMode
				beq $s6, 1, setModeGreater
				seq $s6, $s4, $s5 # cnt  ==  cntMode
				beq $s6, 1, setModeEqual
				j reset
				setModeGreater:
					move $s5, $s4 # cntMode = cnt
					move $s3, $s2 # mode = num
					j reset
				setModeEqual:
					# find smaller element
					slt $s6, $s3, $s2 # mode < num
					beq $s6, 0, numSmaller
					j reset
					numSmaller:
						move $s3, $s2
				reset:
					li $s4, 1 # cnt = 1
					move $s2, $s7 # num = array[i]
					addi $s1, $s1, 1 # i += 1
					blt $s1, $a1, iter # i < size
					j end # finish process
		end:
			move $v0, $s3 # return mode
			findMedian:
				beq $a1, 1, onlyOne # case: only 1 element
				li $s0, 2
				div $a1, $s0
				mfhi $s1 # remainder
				mflo $s2 # dividend
				beq $s1, 1, oddElements
				beq $s1, 0, evenElements
				oddElements:
					mul $s2, $s2, 4 # divident * 4
					add $s3, $a0, $s2
					lw $s2, 0($s3)
					move $v1, $s2 # store the median
					j done
				evenElements:
					li $s5, 0
 					mul $s2, $s2, 4 # divident * 4
 					add $s3, $a0, $s2
 					lw $s2, 0($s3)
 					add $s5, $s5, $s2 # add the first element
 					subi $s3, $s3, 4
 					lw $s2, 0($s3)
 					add $s5, $s5, $s2 # add the second element
 					div $s5, $s5, $s0
 					mflo $v1 # store the median
 					j done
 				onlyOne:
 					lw $v1, 4($a0) # access the first element
				done:
					# load from the stack
					lw $s7, 36($sp)
					lw $s6, 32($sp)
					lw $s5, 28($sp)
					lw $s4, 24($sp)
					lw $s3, 20($sp)
					lw $s2, 16($sp)
					lw $s1, 12($sp)
					lw $s0, 8($sp)
					lw $a0, 4($sp)
					lw $a1, 0($sp)
					addi $sp, $sp, 40
					jr $ra # goto next

## Interactive menu for interacting with the user
# Function for intereacting with the user
interactWithUser:
	mallocMenu:	# allocate the stack space
		subi $sp, $sp, 36
		sw $s7, 32($sp)
		sw $s6, 28($sp)
		sw $s5, 24($sp)
		sw $s0, 20($sp)
		sw $s1, 16($sp)
		sw $s2, 12($sp)
		sw $s3, 8($sp)
		sw $s4, 4($sp)
		sw $ra, 0($sp)
	menu:
		# display the menu
		jal display
		#user option selection
		li $v0, 12 # v0 contains char
		syscall
		# load options
		li $s0, 'a'
		li $s1, 'b'
		li $s2, 'c'
		li $s3, 'e'
		li $s5, 'd'
		# make calls to the subprogram labels according to the which option chosen
		beq $v0, $s0, option1
		beq $v0, $s1, option2
		beq $v0, $s2, option3
		beq $v0, $s3, exitOption
		beq $v0, $s5, option4
		# invalid character print an error message
		li $v0, 4
		la $a0, promptInvalidOption
		syscall
		j menu
		# make function calls to the subprograms
		option1:
			# Instantiate an dynamic array
			jal readArray
			move $a0, $v0
			move $a1, $v1
			j menu
		option2:
			# Sort the array
			jal insertionSort
			j menu
		option3:
			# Find mean and median of the array
			jal medianMode
			# prompt displaying mode
			move $s4, $v0
			move $s6, $a1
			move $s7, $a0
			la $a0, displayMode
			li $v0, 4
			syscall
			move $a0, $s4
			li $v0, 1
			syscall
			# prompt displaying median
			move $s4, $v0
			la $a0, displayMedian
			li $v0, 4
			syscall
			move $a0, $v1
			li $v0, 1
			syscall
			move $a1, $s6
			move $a0, $s7
			j menu
		option4:
			jal displayItems
			j menu
		exitOption:
			# deallocate space
	callocMenu:	# deallocate the stack space
		lw $ra, 0($sp)
		lw $s4, 4($sp)
	 	lw $s3, 8($sp)
	 	lw $s2, 12($sp)
	 	lw $s1, 16($sp)
	 	lw $s0, 20($sp)
	 	lw $s5, 24($sp)
	 	lw $s6, 28($sp)
	 	sw $s7, 32($sp)
	 	addi $sp, $sp, 36
		jr $ra # return main

## Function display menu options
display:
	# save $a0 to the stack
	subi $sp, $sp, 4
	sw $a0, 0($sp)
	li $v0, 4
	la $a0, promptMenu
	syscall
	la $a0, promtOption1
	syscall
	la $a0, promtOption2
	syscall
	la $a0, promptOption3
	syscall
	la $a0, promptOption5
	syscall
	la $a0, promptOption4
	syscall
	# Obtain back from the stack
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	jr $ra # back to main

# Function displays the array content
displayItems:
	# save $a0, a1 to the stack
	subi $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	move $t1, $a1 # load the size into the t0
	move $t0, $a0 # load the base address into the t1
	addi $t2, $0, 0 # i = 0 (index)
	# display message
	li $v0, 4
	la $a0, displayMsg
	syscall
	displayArr:
		# read data from the memory
		lw $a0, 0($t0)
		# increment array index by one position (4 bytes)
		addi $t0, $t0, 4	# array[i]
		# print item
		li $v0, 1
		syscall
		# if not the last element add seperator in between
		addi $t4, $t2, 1
		bgt $t1, $t4, seperate # if (index + 1) < size seperate
		ble $t1, $t4, doneArr	# else done
		seperate:
			la $a0, comma
			li $v0, 4
			syscall
		doneArr:
		# increment the index
		addi $t2, $t2, 1	# i += 1
		# continue if i < size
		blt $t2, $t1, displayArr
	# set $t0 adress to the last element
	subi $t0, $t0, 4
	# Obtain back from the stack
	lw $a1, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, 8
	jr $ra # back to main
#******************
#				  *
#	data segment  *
#				  *
#******************
	.data
promptMenu: .asciiz   "\n* * * * * * * * * * Menu * * * * * * * * * *  *\n"
promtOption1: .asciiz "* * * a) Create an array:   		         *\n"
promtOption2: .asciiz "* * * b) Sort the array (Insertion Sort):     *\n"
promptOption3: .asciiz "* * * c) Find Mode and Median of the array:   *\n"
promptOption4: .asciiz "* * * e) EXIT menu				*\n"
promptInvalidOption: .asciiz "\nERROR: Please choose a valid menu option!!!\n"
promptSize: .asciiz "\nPlease enter the array size: "
promptReadItems: .asciiz "\nPlease enter the items [0, 100] of the array: \n"
promptInvalidItem: .asciiz "\nERROR: Item out of range [0, 100] !!!!\n"
displayMode: .asciiz "\nValue of mode is (smaller if there is a tie): "
displayMedian: .asciiz "\nValue of median is: "
promptOption5: .asciiz "* * * d)Display Items			*\n"
comma: .asciiz ", "
displayMsg: .asciiz "\n Displaying the array items \n"
