# Zeynep Cankara -- 01/04/2019
# Course: CS224
# Section: 2
# Lab: 4
# Version: 1.0
# preLIM4.asm -- Test new instructions which will performed by the control unit
# @Describe: Small program for testing new instructions are working with the previous instructions


#***************** 
#				 *
#	text segment *
#				 *
#*****************
	.text
	.globl __start
__start:
	
	# addi test
	addi $v1, $0, 3 # $v1(3)
	# and test
	and $a1, $v1, $a0 # $a1(0)
	# or test
	or $a0, $a1, $v1 # $a0(3) 
	# beq test
	beq $a1, $a3, 0x0003 # jump 4 instructions forward
	# slt test
	slt $a2, $a1, $a0 # $a2(1) since a1(0) < a0(3)
	# sw test
	sw $a0, 0X10010044($0) # memory address 0X10010044 contains 3
	# lw test
	lw $a3, 0X10010044($0) # $a3(3)
	# sub test
	sub $a3, $a0, $a2 # $a3(2)
	# subi test
	subi $a3, $a0, 0x0010 # $a3(1)
	# nop test
	nop
	# j test
	j 0x00400000
	
	li $v0, 10
	syscall # exit program
