# Zeynep Cankara -- 11/03/2019
# Course: CS224
# Section: 2
# Lab: 3
# Version: 1.0
# preLIM3Question.asm -- Prelim 3 Solution for Question 3 

#*****************
#				 *
#	text segment *
#				 *
#*****************
	.text
	.globl __start
__start:
	## ===========  Question 3 =================== ##
	# Prompt task
	la $a0, promptDeletion
	li $v0, 4
	syscall

	jal create_list
	move $a0, $v0
	li $a1, 5
	jal Delete_xx

	move $a0, $v0 # print number of deleted nodes
	li $v0, 1
	syscall
	la $a0, endl
	li $v0, 4
	syscall

	move $a0, $v1
	jal display_list

	li $v0, 10
	syscall # exit the program


### @brief: Function deletes nodes with the value x.
# @params: $a0 head of the list. $a1 value nodes to be deleted contains
# @returns: $v0 nodes counted so far. $v1 pointer to head
### ANSWER: No because MIPS does not have an instruction for heap allocation.
# Thus, as a result of lack of memory allocation instructions memory leaks occur in MIPS.
Delete_x:
	# restore the new head pointer in $v1
	move $v1, $a0
	# count number of nodes in the linkedlist
	li $v0, 0
	beq $v1, $0, done
	# head node is not empty
	move $t0, $v1 # t0 = Node *cur = head;
	move $t1, $v1 # t1 = Node *prev = head;
	# check whether head contains target or not
	checkHeadTarget:
		sne $t2, $0, $t0 # t2 = cur != NULL
		lw $t3, 4($t0) # t3 = cur->data
		seq $t4, $a1, $t3 # t4 = cur->data == target
		and $t4, $t4, $t2 # (cur != NULL && cur->data == target)
		bne $t4, 1, headNotTarget # head is not equals target
		lw $s0, 0($v1) # head = head->next
		sw $s0, 0($v1)
		lw $t0, 0($t0) # cur = cur->next
		addi $v0, $v0, 1 # TODO: count++
		j checkHeadTarget
	headNotTarget:
		beq $t0, $0, done # cur != NULL
		lw $t3, 4($t0) # t3 = cur->data
		seq $t4, $a1, $t3 # t4 = cur->data == target
		beq $t4, 1, delNode
		lw $t1, 0($t1) # prev = prev->next;
		lw $t0, 0($t0) # cur = cur->next;
		# TODO: count++;
		j headNotTarget
		delNode:
			lw $t4, 0($t0) # obtain next's pointer
			sw $t4, 0($t1) # prev->next = cur->next;
			sw $0, 0($t0) # make current node's next NULL
			lw $t0, 0($t1) # cur = cur->next;
			addi $v0, $v0, 1 # TODO: count++;
			j headNotTarget
	done:
	 jr $ra #goto next

## WORKING ONE
Delete_x:
	# restore the new head pointer in $v1
	move $v1, $a0
	# count number of nodes in the linkedlist
	li $v0, 0
	beq $v1, $0, done
	# head node is not empty
	move $t0, $v1 # t0 = Node *prev = head;
	lw $t1, 0($t0) # t1 = Node *cur = head->next;
	# check whether head contains target or not
	checkHeadTarget:
		sne $t2, $0, $v1 # t2 = head != NULL
		lw $t3, 4($v1) # t3 = head->data
		seq $t4, $a1, $t3 # t4 = head->data == target
		and $t4, $t4, $t2 # (head != NULL && cur->data == target)
		bne $t4, 1, headNotTarget # head is not equals target
		move $v1, $t1  # head = head->next
		move $t0, $t1 # prev
		lw $t1, 0($t0) # cur
		addi $v0, $v0, 1 # TODO: count++
		j checkHeadTarget
	headNotTarget:
		beq $t1, $0, donex # cur != NULL
		lw $t3, 4($t1) # t3 = cur->data
		seq $t4, $a1, $t3 # t4 = cur->data == target
		beq $t4, 1, delNode
		lw $t1, 0($t1) # prev = prev->next;
		lw $t0, 0($t0) # cur = cur->next;
		# TODO: count++;
		j headNotTarget
		delNode:
			lw $t4, 0($t1) # obtain next's pointer
			sw $0, 0($t1) # make current pointer null
			sw $t4, 0($t0) # prev->next = current->next
			move $t1, $t4 # cur = cur->next;
			addi $v0, $v0, 1 # TODO: count++;
			j headNotTarget
	done:
	 jr $ra #goto next
###################################################################

##

#### create_list - a linked list utility routine,

##			which creates the contents, element

##			by element, of a linked list

##

##	a0 - used for input arguments to syscalls

##	s0 - holds final value of pointer to linked list (to be put in v0 at exit)

##	t0 - temp value, holds # of current element being created; is loop control variable

##	t1 - temp value, holds n+1, where n is the user input for length of list

##	s1 - value of pointer to current element

##	s2 - value of pointer to previous element

##	v0 - used as input value for syscalls (1, 4, 5 and 9),

##		but also for the return value, to hold the address of the

##		first element in the newly-created linked list

##	sp - stack pointer, used for saving s-register values on stack

##

##################################################################




create_list:		# entry point for this utility routine
	addi $sp,$sp,-12 # make room on stack for 3 new items
	sw $s0, 8 ($sp) # push $s0 value onto stack
	sw $s1, 4 ($sp) # push $s1 value onto stack
	sw $s2, 0 ($sp) # push $s2 value onto stack



	li $v0,5	# system call to read  (NUM ELEMENTS)
	syscall		#   in the integer



	addi $t1,$v0,1	# put limit value of n+1 into t1 for loop testing
	bne $v0, $zero, devam90 #if n = 0, finish up and leave


	move $s0, $zero # the pointer to the 0-element list will be Null
	j Finish90	#


devam90:		# continue here if n>0
	li $t0, 1	# t=1
	li $a0, 16	# get 16 bytes of heap from OS
	li $v0, 9	# syscall for sbrk (dynamic memory allocation)
	syscall

	move $s0, $v0	# the final value of list pointer is put in $s0
	move $s1, $v0	# the pointer to the current element in the list is put in $s1
	j Prompt90	#


Top90:	move $s2, $s1	# pointer to previous element is updated with pointer to current element

	sll $t2,$t0,4	# $t2 is 16 x the number of the current element ($t0)
	move $a0, $t2	# get $t2 bytes of heap from OS
	li $v0, 9	# syscall for sbrk (dynamic memory allocation)
	syscall


	move $s1, $v0	# the pointer to the new current element in the list is put in $s1
	sw $s1, 0($s2)	# the previous element's pointerToNext is loaded with the new element's address

Prompt90:

	move $a0, $t0	# put x (the current element #) in $a0
	li $v0,1	# system call to print
	syscall		#   out the integer in $a0



	li $v0, 5	# system call to read in
	syscall		#   the integer from user
	sw $v0, 4($s1) 	# store the value from user into

			#   current element's value part


	addi $t0,$t0,1	# x = x+1  increment element count
	bne $t0,$t1, Top90 # If x != n+1, go back to top of loop and iterate again

	sw $0,0($s1)	# Put Null value into pointerToNext part of last element in list



Finish90: move $v0,$s0	# put pointer to linked list in $v0 before return

	lw $s0, 8 ($sp) # restore $s0 value from stack


	lw $s1, 4 ($sp) # restore $s1 value from stack


	lw $s2, 0 ($sp) # restore $s2 value from stack


	addi $sp,$sp,12 # restore $sp to original value (i.e. pop 3 items)


	jr $ra		# return to point of call


##################################################################

#### display_list - a linked list utility routine,

##			which shows the contents, element

##			by element, of a linked list

##

##	a0 - input argument: points to the linked list, i.e. contains

##		the address of the first element in the list

##	s0 - current pointer, to element being displayed

##	s1 - value of pointerToNext part of current element

##	v0 - used only as input value to syscalls (1, 4, and 34)

##	sp - stack pointer is used, for protecting s0 and s1

##

#################################################################





display_list:		# entry point for this utility routine



	addi $sp, $sp,-8 # make room on stack for 2 new items
	sw $s0, 4 ($sp) # push $s0 value onto stack
	sw $s1, 0 ($sp) # push $s1 value onto stack





	move $s0, $a0	# put the pointer to the current element in $s0
	bne $s0, $zero, devam80	# if pointer is NULL, there is no list
	j Return80	# done, so go home


devam80:		# top of loop

	lw $s1, ($s0)	# read the value of pointerToNext
	move $a0, $s1	# put the pointerToNext value into a0
	li $v0, 34	# system call to print out the integer
	syscall		#   in hex format
	# add a space
	la $a0, endl
	li $v0, 4
	syscall


	lw $a0, 4($s0)	# read the value part, put into a0
	li $v0, 1	# system call to print
	syscall		#   out the integer


	# add a space
	la $a0, endl
	li $v0, 4
	syscall



Top80:	beq $s1, $zero, Return80 # if pointerToNext is NULL, there are no more elements

	move $s0, $s1	# update the current pointer, to point to the new element
	lw $s1, ($s0)	# read the value of pointerToNext in current element
	move $a0, $s1	# put the pointerToNext value into a0
	li $v0, 34	# system call to print out the integer
	syscall		#   in hex format


	# add a space
	la $a0, endl
	li $v0, 4
	syscall




	lw $a0, 4($s0)	# read the value part, put into a0
	li $v0, 1	# system call to print
	syscall		#   out the integer


	# add a space
	la $a0, endl
	li $v0, 4
	syscall


	j Top80		# go back to top of loop, to test and


			#   possibly iterate again




Return80:
	# add a space
	la $a0, endl
	li $v0, 4
	syscall


	lw $s0, 4 ($sp) # restore $s0 value from stack
	lw $s1, 0 ($sp) # restore $s1 value from stack
	addi $sp, $sp, 8 # restore $sp to original value (i.e. pop 2 items)
	jr $ra		# return to point of call

#******************
#				  *
#	data segment  *
#				  *
#******************
	.data
promptDeletion: .asciiz "Program deletes nodes with the given value x...\nReturns the number of nodes counted"
endl: .asciiz "\n"
