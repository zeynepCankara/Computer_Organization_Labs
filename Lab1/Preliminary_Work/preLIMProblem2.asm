# Zeynep Cankara -- 20/02/2019
# isPalindrome.asm -- Takes a string as user input checks isPalindrome
# Registers used:

## Text Section ##
	.globl __start
	.text
	
__start:
	# prompt the task on screen
	li $v0, 4
	la $a0, task
	syscall
	
	# ask user enter the string
	li $v0, 4
	la $a0, prompt
	syscall
	
	# read the string 
	li $v0,8  # read str
    la $a0, strBuffer #load byte space into address
    li $a1, 20 # allot the byte space for strings
    sw $a0, strBuffer # store string in the buffer
    syscall

    # $t0 points to the address of the string
	la $a0, strBuffer
	jal size	# obtain size of the string
	move $a0, $v0	# save the last character adress
	jal isPalindrome
	
	
	# test ispalindrome function
	move $s0, $v0

	# return result isPalindrome
	li $v0, 4
	la $a0, isPalindromeMsg
	syscall
	# test ispalindrome function
	move $a0, $s0
	li $v0, 1
	syscall
	
	

    li $v0,10 # exit program 
    syscall    

## Function for counting number of characters in the string
## reg used: v0: returns the address of the last char in the string
size:
	# $a0 have the address of the string
	move $t0, $a0  # store string in $t0 reg
	addi $t2, $0, 0 # cnt = 0, counter for characters in the string
	startCnt:
		lbu $t3, 0($t0)   # load current character in t3
		beq $t3, $0, done # finish when encounter a NULL character
		addi $t2, $t2, 1 # cnt += 1
		addi $t0, $t0, 1 # go to next char
		j startCnt
		done:
			subi $t2, $t2, 1 # exclude enter character
			sw $t2, strSize # store the size of the string
			subi $t0, $t0, 2 # go back 2 chars (1 for ENTER 1 for 00(end of string))
			move $v0, $t0 # return the sadress of the last char
	jr $ra # goto the next instruction

## Function Takes the last char address of the string (a0) loads adress of the first char from the buffer (strBuffer)
## Compares and return 1 if the string is palindrome 0 otherwise
## reg used: a0,t0, t1, v0	
isPalindrome:
	la $t0, strBuffer # address of the first char
	move, $t1, $a0 # adress of the last char
	next:
		lb $t3, 0($t0)	# load the first character
		lb $t4, 0($t1)	# load the last character
		bne $t3, $t4, false	# characters not equal return 0
		ble $t1, $t0, true	# address of last char <= adress of first char return 1
		addi $t0, $t0, 1
		subi $t1, $t1, 1
		j next
		false:
			li $v0, 0	# return 0
			j finish
		true:
			li $v0, 1 # return 1
		finish:
	jr $ra # goto the next instruction



## Data Section ##
	.data
strBuffer: .space 20 # 1 char (1 byte), string can have max 20 letters
task: .asciiz "Program checks whether string is palindrome or not \n" 
prompt: .asciiz "Please enter the string: \n"
strSize: .word  0 # number of characters in string
isPalindromeMsg: .asciiz "String is palindrome if result is 1, 0 otherwise \n" 


