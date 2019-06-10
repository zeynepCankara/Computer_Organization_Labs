# Zeynep Cankara -- 20/02/2019
# prelimReport.asm -- Solutions for the Preliminary Report before Lab1
# Registers used:
# $t0: base address of the array
# $t1 size of the array
# $t2 index of the array
# $t5 swapping
# $t6 swapping

## Text Section ##
	.globl __start
	.text
	
__start:
	# prompt the task on screen
	li $v0, 4
	la $a0, task
	syscall

	# prompt user to enter size of the array
	li $v0, 4
	la $a0, arrayMsg
	syscall
	
	# read the user input
	li $v0, 5
	syscall
	sw $v0, size
	jal createArray
	jal displayItems
	# $t0 points to the address of the last element, load as an argument to reverseArray
	la $a0, 0($t0)
	jal reverseArray
	jal displayItems
	# exit the program
	li $v0, 10	
	syscall

# Function for instantiating the array with the user input 
createArray:
	lw $t1, size # load the size into the t0
	la $t0, array # load the base address into the t1
	addi $t2, $0, 0 # i = 0 (index)
	
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

# Function displays the array content
displayItems:
	lw $t1, size # load the size into the t0
	la $t0, array # load the base address into the t1
	addi $t2, $0, 0 # i = 0 (index)
	
	# display message
	li $v0, 4
	la $a0, displayMsg
	syscall
	display:
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
		ble $t1, $t4, done	# else done
		seperate:
			la $a0, comma
			li $v0, 4
			syscall
		done:
		# increment the index
		addi $t2, $t2, 1	# i += 1
		# continue if i < size
		blt $t2, $t1, display
	# set $t0 adress to the last element
	subi $t0, $t0, 4
	jr $ra # go to the next instruction
	
## Function reverses array items 
reverseArray:
	# $t0 already have the address of the last element in the array
	la $t1, array # load the base address into the t1
	# swap elements if  ($t1 > $t0)
	swapItems:
		# load items into the registers
		lw $t5, 0($t0)
		lw $t6,	0($t1)
		# swap and store items
		sw $t5, 0($t1)
		sw $t6,	0($t0)
		# increment address of $t0 by 1 word (4 byte)
		addi $t1, $t1, 4
		# decrement address of $t1 by 1 word (4 byte)
		subi $t0, $t0, 4
		# check condition
		bgt $t0, $t1, swapItems
	jr $ra # go to the next instruction
	
## Data Section ##
	.data
array: .space  80 # word (4 bytes) => 20 words (80 bytes), array of 80 bytes allocated
size: .word  0 # int user input (4 bytes)
task: .asciiz "Program creates an array of max size 20 initializes the array in accordance with the user input. \n" 
arrayMsg: .asciiz "Enter the size of the array: (1 <= size <= 20) \n" 
readItemsMsg: .asciiz "Please enter the array items: \n"
comma: .asciiz ", "
displayMsg: .asciiz "\n Displaying the array items \n" 
