# Zeynep Cankara -- 04/03/2019
# Course: CS223
# Section: 02
# Lab: 02
# preLIM2.asm -- Perfprms number conversions

#************************
#					 	*
#		text segment	*
#						*
#************************
	.globl __start
	.text	
__start:
	# Print an intro message
	li $v0, 4
	la $a0, intro
	syscall

	# Call menu
interactWithUser:	
	# display the menu
	jal display
	# user option selection
	li $v0, 4 # v0 contains char
	syscall
	# load options
	li $t0, 'a'
	li $t1, 'b'
	li $t2, 'c'
	# make calls to the subprogram labels according to the which option chosen
	beq $v0, $t0, option1
	beq $v0, $t1, option2
	beq $v0, $t2, option3
	# invalid character print an error message
	li $v0, 4
	la $a0, errorOptionsMsg
	syscall
	j interactWithUser
	# make function calls to the subprograms
	option1:
		#jal convertToDec
		j continue
	option2:
		#jal reverseNumber
		j continue
	continue:
		# Display menu again
		j interactWithUser
	option3:
		# exit from the loop
	
	# exit the program
	li $v0, 10	
	syscall
	
# Function for intereacting with the user


		
# Function for displaying the options
display:
	li $v0, 4
	la $a0, menuMsg
	syscall
	la $a0, convertToDecMsg
	syscall
	la $a0, reverseNumberMsg
	syscall
	la $a0, exitMsg
	syscall
	jr $ra # back to main	
	
#************************
#					 	*
#		data segment	*
#						*
#************************
	.data
intro: .asciiz "\nPROGRAM: Interactive menu for performing number conversions\n"
menuMsg: .asciiz "\n*** MENU ***\n"
convertToDecMsg: .asciiz "a) Convert user input(octal) to decimal\n"
reverseNumberMsg: .asciiz "b) Reverse the user input(hex)\n"
exitMsg: .asciiz "c) Exit menu\n"
errorOptionsMsg: .asciiz "\nERROR: Please choose a valid menu option!!!\n"
