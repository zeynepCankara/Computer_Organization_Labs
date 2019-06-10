##
## Program2.asm asks user for temperature in Celsius,
##  converts to Fahrenheit, prints the result.
##
##	v0 - reads in Celsius
##	t0 - holds Fahrenheit result
##	a0 - points to output strings
##

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
	.globl __start	

__start:
	la $a0,prompt	# output prompt message on terminal
	li $v0,4	# syscall 4 prints the string
	syscall

	li $v0, 5	# syscall 5 reads an integer	# ERROR: "v0" operand of incorrect type for v0 FIX: v0->$v0
	syscall									# ERROR: "li" too few or incorrectly formatted operations. Expected li $t1, -100. FIX: li $v0, 5(integer) 
											# $v0 contains  0x0000 0005 just at 2nd syscall after 2nd syscall reg v0 contains user input in hex format

	mul $t0,$v0,9	# to convert,multiply by 9 # ERROR: (t0 * 9) / 5 + 32 will calculated independent from user input. Thus ans always be 32 since t0 -> 0
	div $t0,$t0,5	# divide by 5, then
	add $t0,$t0,32	# add 32

	la $a0,ans1	# print string before result
	li $v0,4
	syscall

	move $a0,$t0	# print integer result
	li $v0,1		# using syscall 1
	syscall

	la $a0,endl	# system call to print
	li $v0,4		# out a newline
	syscall

	li $v0,10		# system call to exit
	syscall		#    bye bye


#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
prompt:	.asciiz "Enter temperature (Celsius): "
ans1:	.asciiz "The temperature in Fahrenheit is "
endl:	.asciiz "\n"

##
## end of file Program2.asm

