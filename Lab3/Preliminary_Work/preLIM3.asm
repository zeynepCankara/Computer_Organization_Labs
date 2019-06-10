# Zeynep Cankara -- 11/03/2019
# Course: CS224
# Section: 2
# Lab: 3
# Version: 1.0
# preLIM3.asm -- Prelim 3 Solutions

#***************** 
#				 *
#	text segment *
#				 *
#*****************
	.text
	.globl __start
__start:
	## ===========  Question 1 =================== ##
	# Prompt task 
	la $a0, promptRecursiveDivision
	li $v0, 4
	syscall
	la $a0, promptDividend
	syscall
	# obtain the integer from the user
	li $v0, 5
	syscall
	move $s0, $v0
	# prompt the divisor
	la $a0, promptDivisor
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a1, $v0
	move $a0, $s0
	# Recursive function call
	jal recursiveDivision
	move $s0, $a0
	la $a0, resultQuotient
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall # print quotient
	la $a0, resultRemainder
	li $v0, 4
	syscall
	move $a0, $a1 
	li $v0, 1
	syscall # print remainder
	## ===========  Question 2 =================== ##
	# Prompt Question 2 task 
	la $a0, promptMultiplyDigits
	li $v0, 4
	syscall
	la $a0, promptNumber
	syscall
	# obtain the integer from the user
	li $v0, 5
	syscall
	move $a0, $v0
	# Function call
	jal multiplyDigits
	# store result s0
	move $s0, $v0
	la $a0, resultMultDigits
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall # exit program

# Function divides two numbers returns the quotient in $a0 reg
# Assumption1: numbers are positive
recursiveDivision:
	# malloc
	subi $sp, $sp, 12  
	sw   $a1, 8($sp) 
    sw   $a0, 4($sp)   
    sw   $ra, 0($sp)   
    # base condition
    # if num1 < num2 else
    bgt $a0, $a1, elseDiv
    move $t0, $a0 # obtain the remainder, remainder = num1 
    addi $a0, $0, 0	# return 0, quotient = 0
    move $a1, $t0
    addi $sp, $sp, 12  # dealloc
    jr  $ra   # goto next
elseDiv:
	# num1 = num1-num2
	sub $a0, $a0, $a1
	# recursive function call
	jal recursiveDivision # return 1 + recursiveDivision(num1-num2, num2)
    # load arguments back to reg
    lw   $ra, 0($sp)  
    addi $sp, $sp, 12  # dealloc stack pointer
    addi $a0, $a0, 1 # quotient += 1
	jr $ra # goto next
	
## Function takes an integer returns multiplication of it's digits 
# int multiplyDigits(int number ($a0))
multiplyDigits:
	# alloc stack space
	subi $sp, $sp, 8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	# base case
	bgt $a0, $0, elseMul # if (num <= 0)
	addi $v0, $0, 1	# return 1
	addi $sp, $sp, 8  # dealloc
	jr  $ra   # goto next
elseMul:
	div $a0, $a0, 10
	mflo $a0 # obtain the quotient
	jal multiplyDigits # else {return (int)(num % 10) * multiplyDigit(num/10);}
	lw $a0, 4($sp)  # pop a0 from the stack
    div $t0, $a0, 10
    mfhi $t0
    mul $v0, $v0, $t0 # (int)(num % 10)
    # load arguments back to reg
    lw   $ra, 0($sp)  
    addi $sp, $sp, 8  # dealloc stack pointer
	jr $ra # goto next
	
	
#******************
#				  *
#	data segment  *
#				  *
#******************
	.data
promptRecursiveDivision: .asciiz "Function divides 2 numbers returns the quotient and the remainder..."
promptDividend: .asciiz "\nPlease enter the Dividend (dividend > 0): "
promptDivisor: .asciiz "\nPlease enter the Divisor (divisor > 0): "
resultQuotient: .asciiz "\nQuotient: "
resultRemainder: .asciiz "\nRemainder: "
promptMultiplyDigits: .asciiz "\nFunction multiplies digits of an integer recursively..."
promptNumber: .asciiz "\nPlease enter the number: "
resultMultDigits: .asciiz "\nMultiplication of digits: "
