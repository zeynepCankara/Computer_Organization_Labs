##
##	Program3.asm is a loop implementation
##	of the Fibonacci function
##        

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
.globl __start
 
__start:		# execution starts here
	li $a0,5	# to calculate fib(7)
	
	jal fib		# call fib #ERROR FIX: change 'l' -> 'i'
	move $a0,$v0	# print result
	li $v0, 1
	syscall #ERROR FIX: add 'l' -> "syscall"

	la $a0,endl	# print newline #ERROR FIX: add 'l' -> "endl"
	li $v0,4
	syscall #ERROR FIX: add 'l' -> "syscall"

	li $v0,10 #ERROR FIX: 100->10 generate an exit syscall
	syscall #ERROR FIX: add 'l' -> "syscall" # bye bye

#------------------------------------------------


fib:
	move $v0,$a0	# initialise last element
	beq $a0,1,setOne
	blt $a0,2,done	# fib(0)=0, fib(1)=1 #ERROR FIX: add 'e' -> "done"

	li $t0,0	# second last element
	li $v0,1	# last element

loop:	add $t1,$t0,$v0	# get next value #ERROR FIX: add '$' before "v0" so operand will have the correct type
	move $t0,$v0	# update second last
	move $v0,$t1	# update last element
	sub $a0,$a0,1	# decrement count
	bgt $a0,1,loop	# exit loop when count=0 #ERROR FIX: continue untill (n-1) addition operations performed 
done:	
	jr $ra
setOne:
	li $v0, 1
	jr $ra
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
endl:	.asciiz "\n"

##
## end of Program3.asm
