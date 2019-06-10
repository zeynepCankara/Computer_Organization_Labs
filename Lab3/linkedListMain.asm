##	-	-IMPORTANT-	    -
##	The general structure;
##
##		-Main menu
##		-LinkedList creater
## 		-LinkedList displayer
## 		
##is given to you, necessary functions are empty, you have to ##fill them 
##	efficiently for lab3 part 1.
##	Necessary register defined. 	
##IF YOU READ INSTRUCTIONS CAREFULLY YOU FIGURE OUT THAT IT IS ##NOT DIFFICULT TO HANDLE
###############################################################

##

##	_Lab3main - a program that calls linked list utility functions,

##		 depending on user selection.  _Lab3main outputs a 

##		message, then lists the menu options and get the user

##		selection, then calls the chosen routine, and repeats

##

##	a0 - used for input arguments to syscalls and for passing the 

##		pointer to the linked list to the utility functions

##	a1 - used for 2nd input argument to the utility functions that need it

##	a2 - used for 3rd input argument to the utility functions that need it

##	v0 - used for input and output values for syscalls

##	s0 - used to safely hold the pointer to the linked list

##	s1 - used to hold the user input choice of which menu option			


##   


##      linked list consists of 0 or more elements, in 


##		dynamic memory segment (i.e. heap)


##	elements of the linked list contain 2 parts:


##		at address z: pointerToNext element (unsigned integer), 4 bytes


##		at address z+4: value of the element (signed integer), 4 bytes


##

##

###################################################################

#
#					 	

#
#		text segment			

#
#						

#
####################################################################



	

	.text		
 	

	.globl _Lab3main
 


_Lab3main:		# execution starts here


	li $s0, 0	# initialize pointer storage register to 0 (=Null pointer)



	la $a0,msg110	# put msg110 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg110 string






##

##	Output the menu to the terminal,

##	   and get the user's choice

##

##



MenuZ:	
la $a0,msg111	# put msg111 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg111 string




	
la $a0,msg112	# put msg112 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg112 string




	
la $a0,msg113	# put msg113 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg113 string




	
la $a0,msg114	# put msg114 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg114 string




	
la $a0,msg115	# put msg115 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg115 string




	
la $a0,msg116	# put msg116 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg116 string




	
la $a0,msg117	# put msg117 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg117 string


#### NEW OPTIONS ====================
la $a0,msg133	# put msg118 address into a0 ADDNODES
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg118 string
	
la $a0,msg135	# put msg135 address into a0 SWAPNODES
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg118 string
la $a0,msg137	# put msg137 address into a0 FINDSUMINRANGE
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg118 string
	
la $a0,msg141	# put msg141 address into a0 FINDSUMINRANGE
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg118 string
### =========================
	
la $a0,msg118	# put msg118 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg118 string


	



EnterChoice:

	
la $a0,msg119	# put msg119 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg119 string




	li $v0,5	# system call to read  
	

	syscall		# in the integer


	move $s1, $v0	# move choice into $s1





##

##

##	T1 through T7no use an if-else tree to test the user choice (in $s1)

##	   and act on it by calling the correct routine

##

##



T1:	bne $s1,1, T2	# if s1 = 1, do these things. Else go to T2 test

	jal create_list

	move $s0, $v0	# put pointer to linked list in s0 for safe storage

	j MenuZ		# task is done, go to top of menu and repeat



T2:	bne $s1,2, T3	# if s1 = 2, do these things. Else go to T3 test

	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal display_list 

	j MenuZ		# task is done, go to top of menu and repeat



T3:	bne $s1,3, T4	# if s1 = 3, do these things. Else go to T4 test

	
la $a0,msg120	# put msg120 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg120 string




	li $v0,5	# system call to read  
	

	syscall		#   in the integer


	move $a1, $v0	# put integer value into a1 before the call

	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal Insert_end

	j ReportZ 



T4:	bne $s1,4, T5	# if s1 = 4, do these things. Else go to T5 test

	
la $a0,msg120	# put msg120 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg120 string




	li $v0,5	# system call to read  
	

	syscall		#   in the value

	move $a1, $v0	# put integer value into a1 before the call




	la $a0,msg124	# put msg124 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg124 string




	li $v0,5	# system call to read  
	

	syscall		#   in the position number

	move $a2, $v0	# put position number into a2 before the call



	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal Insert_n

	move $s0, $v1	# put the (possibly revised) pointer into s0

	j ReportZ



T5:	bne $s1,5, T6	# if s1 = 5, do these things. Else go to T6 test

	
la $a0,msg125	# put msg125 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg125 string




	li $v0,5	# system call to read  
	

	syscall		#   in the position number

	move $a1, $v0	# put position number into a1 before the call

	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal Delete_n

	move $s0, $v1	# put the (possibly revised) pointer into s0

	j ReportZ



T6:	bne $s1,6, T8	# if s1 = 6, do these things. Else go to T7 test

	
la $a0,msg126	# put msg126 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg126 string




	li $v0,5	# system call to read  
	

	syscall		#   in the value x

	move $a1, $v0	# put x value into a1 before the call

	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal Delete_x

	move $s0, $v1	# put the (possibly revised) pointer into s0

	j ReportZ





# Add Nodes Option
T8: bne $s1, 7, T9

la $a0,msg134	# put msg134 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg134 string


	li $v0,5	# system call to read  
	

	syscall		#   in the value x

	move $a1, $v0	# put x value into a1 before the call

	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal AddNodes

	move $s0, $v1	# put the (possibly revised) pointer into s0

	j ReportZ
	
# Swap nodes option
T9: bne $s1, 8, T10
	la $a0,msg136	# put msg134 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg136 string


	li $v0,5	# system call to read  
	

	syscall		#   in the value x

	move $a1, $v0	# put x value into a1 before the call

	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal SwapNodes

	move $s0, $v1	# put the (possibly revised) pointer into s0

	j ReportZ


# SunInRange option
T10: bne $s1, 9, T11
	la $a0,msg138	# put msg134 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg136 string


	li $v0,5	# system call to read  
	

	syscall		#   in the value x
	

	move $a1, $v0	# first index
	
	
	la $a0,msg139	# put msg134 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg136 string


	li $v0,5	# system call to read  
	

	syscall		#   in the value x
	

	move $a2, $v0	# second index

	move $a0, $s0	# put pointer to linked list in a0 before the call

	jal FindSumInRange
	
	move $s3, $v0
	 
	la $a0, msg140 # print sum message
	li $v0, 4
	syscall
	
	move $a0, $s3 # print the sum
	li $v0, 1
	syscall
	
	li $v0, 0 # always success
	move $s0, $v1	# put the (possibly revised) pointer into s0

	j ReportZ


## CountCommon Option
T11: bne $s1, 10, T7
	
	# another call to create linkedlist function
	
	jal create_list

	move $a1, $v0	# put pointer to linked list in s0 for safe storage
	
	move $a0, $s0	# put pointer to linked list in a0 before the call
	
	jal countCommonValues
	
	move $s3, $v0 # obtain the sum
	
	move $s4, $a0 # retrieve the original list's pointer
	
	la $a0, msg142
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1 # print sum
	syscall	
	
	move $s0, $s4	# put the (possibly revised) pointer into s0
	li $v0, 0 # always success
	j ReportZ

T7:	bne $s1,11, T7no	# if s1 = 7, do these things. Else go to T7no


	la $a0,msg127	# put msg127 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the thank you string
	
	li $v0,10
	# the exit syscall is 10

	syscall		# goodbye...



T7no:	
la $a0,msg128	# put msg128 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg128 string

	j EnterChoice	# go to the place to enter the choice





##

##

##	ReportZ determines if the return value in $v0 is

##	   0 for success, -1 for failure, or other (invalid)

##

##



ReportZ: beq $v0,0,Succeed

	 beq $v0,-1,Fail



Invalid: la $a0,msg130  # put msg130 address into a0
	

	 li $v0,4	# system call to print
	

	 syscall	#   out the invalid message

	 j MenuZ	# task is done, go to top of menu and repeat

	

Succeed: la $a0,msg131  # put msg131 address into a0
	

	 li $v0,4	# system call to print
	

	 syscall	#   out the success message

	 j MenuZ	# task is done, go to top of menu and repeat



Fail:	 la $a0,msg132  # put msg132 address into a0
	

	 li $v0,4	# system call to print
	

	 syscall	#   out the failure message

	 j MenuZ	# task is done, go to top of menu and repeat

	
	






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
	

	



	la $a0, msg91	# put msg91 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg91 string

	



	la $a0, msg92	# put msg92 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg92 string

	



	li $v0,5	# system call to read  
	

	syscall		#   in the integer
	



	addi $t1,$v0,1	# put limit value of n+1 into t1 for loop testing

	



	bne $v0, $zero, devam90 #if n = 0, finish up and leave

	



	la $a0, msg93	# put msg93 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg93 string

	



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

	



Prompt90: la $a0,msg94	# put msg94 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg94 string

	



	move $a0, $t0	# put x (the current element #) in $a0
	

	li $v0,1	# system call to print
	

	syscall		#   out the integer in $a0

	

	

	la $a0, msg95	# put msg95 address into a0
	

	li $v0,4	# system call to print
	

	syscall		#   out the msg95 string

	



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
	



	la $a0, msg81	# put msg81 address into a0
	
	
	li $v0, 4	# system call to print
	
	
	syscall		#   out the msg81 string

	



	bne $s0, $zero, devam80	# if pointer is NULL, there is no list
	
	
	la $a0, msg82	# put msg82 address into a0	
	
	
	li $v0, 4	# system call to print
	
	
	syscall		#   out the msg82 string
	

	j Return80	# done, so go home





devam80:		# top of loop	
	

	la $a0, msg83	# put msg83 address into a0
	

	li $v0, 4	# system call to print
	

	syscall		#   out the msg83 string

	

	

	lw $s1, ($s0)	# read the value of pointerToNext
	

	move $a0, $s1	# put the pointerToNext value into a0
	

	li $v0, 34	# system call to print out the integer 
	

	syscall		#   in hex format

	



	la $a0, msg84	# put msg84 address into a0
	

	li $v0, 4	# system call to print
	

	syscall		#   out the msg84 string

	



	lw $a0, 4($s0)	# read the value part, put into a0
	

	li $v0, 1	# system call to print  
	

	syscall		#   out the integer

	



	la $a0, msg85	# put msg85 address into a0
	

	li $v0, 4	# system call to print
	

	syscall		#   out the msg85 string (new line)





Top80:	beq $s1, $zero, Return80 # if pointerToNext is NULL, there are no more elements

	

	

	la $a0, msg86	# put msg86 address into a0
	

	li $v0, 4	# system call to print
	

	syscall		#   out the msg86 string

	



	move $s0, $s1	# update the current pointer, to point to the new element

	

	lw $s1, ($s0)	# read the value of pointerToNext in current element
	

	move $a0, $s1	# put the pointerToNext value into a0
	

	li $v0, 34	# system call to print out the integer 
	

	syscall		#   in hex format

	



	la $a0, msg84	# put msg84 address into a0
	

	li $v0, 4	# system call to print
	

	syscall		#   out the msg84 string

	



	lw $a0, 4($s0)	# read the value part, put into a0
	

	li $v0, 1	# system call to print  
	

	syscall		#   out the integer

	



	la $a0, msg85	# put msg85 address into a0
	

	li $v0, 4	# system call to print
	

	syscall		#   out the msg85 string (new line)

	



	j Top80		# go back to top of loop, to test and

 
			#   possibly iterate again





Return80:	
	

	la $a0, msg89	# put msg89 address into a0
	

	li $v0, 4	# system call to print
	

	syscall		# out the msg89 string

	



	lw $s0, 4 ($sp) # restore $s0 value from stack
	

	lw $s1, 0 ($sp) # restore $s1 value from stack
	

	addi $sp, $sp, 8 # restore $sp to original value (i.e. pop 2 items)
	

	jr $ra		# return to point of call







#################################################

##

##

##	dummy routines for the 4 utilities which

##	  students should write for Lab3

##

##

###############################################
#

### Fill Those functions
#Insert_end:
	
	#jr $ra


## Function inserts a node with the given value to the corresponding position in linkedlist 
# Params:
# 	$a0 - contains pointer to head 
# 	$a1 - contains value of the new node
# 	$a2 - contains position to insert the node
# Assumption: (position > 1) no insertion at head
# If position is out of bounds then insert at end 
# If list is empty no insertion done
# Returns:  $v0 = -1 (fail) $v0 = 0 (succsessful)
Insert_n:
	# push values to stack
	subi $sp, $sp, 4
	sw $a0, 0($sp)
	# check: list empty ?
	move $t0, $a0 # $t0 = head = cur
	beq $t0, $0, failInsert
	# create the node
	li $a0, 8 # 8 byte reserved [(0)address | (4)data]
	li $v0, 9 
	syscall # $v0 contains the new node address
	sw $a1, 4($v0) # store the value
	# get cur->next
	lw $t1, 0($t0) # t1 = cur->next
	li $t2, 2
	searchPosN:
		beq $t2, $a2, insertN # cnt == position
		move $t0, $t1 # cur = cur->next
		lw $t1, 0($t0) # obtain next pointer
		# check cur == NULL
		beq $t1, $0, Insert_end
		addi $t2, $t2, 1
		j searchPosN
		insertN:
		# obtain cur->next address
		lw $t1, 0($t0) # t1 = cur->next
		# store in new node
		sw $t1, 0($v0) 
		# store new pointers address in cur node
		sw $v0, 0($t0)
		# finish process
		j successInsert
	Insert_end:
		sw $v0, 0($t0)
		sw $0, 0($v0) # set next element to NULL
	successInsert:
		li $v0, 0
		j doneInsert
	failInsert:
		li $v0, -1
	doneInsert:
		# pop values back from stack
		lw $a0, 0($sp)
		move $v1, $a0 # return pointer to head
		addi $sp, $sp, 4
		jr $ra


## Function deletes the node at position n. If position exceeds boundary deletes from last
# Params:
# 	$a0 - contains pointer to head 
# 	$a1 - contains position to delete the node
# If list is empty no deletion is done
# Returns:  $v0 = -1 (fail) $v0 = 0 (succsessful)
Delete_n:
	# push values to stack
	subi $sp, $sp, 4
	sw $a0, 0($sp)
	# check list empty
	move $t0, $a0
	beq $t0, $0, failDel
	# check value to delete @head
	beq $a1, 1, delHead
	# get cur->next
	lw $t1, 0($t0) # t1 = cur->next
	li $t2, 2 # t2 = position
	delPosN:
		bge $t2, $a1, delN # cnt == position
		move $t0, $t1 # cur = cur->next
		lw $t1, 0($t0) # obtain next pointer
		# check cur->next->next == NULL
		lw $t5, 0($t1)
		beq $t5, $0, Del_end
		addi $t2, $t2, 1 # cnt += 1
		j delPosN
		delN:
		# obtain cur->next address
		lw $t1, 0($t0) # t1 = cur->next
		lw $t4, 0($t1) # t4 = cur->next->next
		# store the address
		sw $t4, 0($t0) 
		# finish process
		j successDel
	delHead:
		lw $a0, 0($sp) # obtain head pointer from stack
		lw $t3, 0($a0) # get head pointer's next
		move $a0, $t3 # head = head->next
		sw $a0, 0($sp) # store back in stack
		j successDel
	Del_end:
		sw $0, 0($t0)
		j successDel
	successDel:
		li $v0, 0
		j doneDel
	failDel:
		li $v0, -1
	doneDel:
		# retieve values back from the stack
		lw $a0, 0($sp)
		move $v1, $a0 # obtain address to the head
		addi $sp, $sp, 4
		jr $ra



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
		beq $t1, $0, done # cur != NULL
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
		li $v0, 0 # success indication
		jr $ra		


## Function adds nodes and deletes node @ consecutive position
# $a0 - pointer to head of the list
# $a1 - contains the position
# Returns: $v0  = 0 if pos exist else $v0 = -1, $v1 contains pointer to head 
AddNodes:
	# check position <= 0 
	ble $a1, $0, failAdd
	# allocate stack
	subi $sp, $sp, 4
	sw $a0, 0($sp)
	# initialize current position
	move $t0, $a0 # t0 = cur = head
	lw $t1, 0($t0) # t1 = cur->next
	li $t2, 1
	findPos:
		beq $t2, $a1, foundPos # change pointers
		beq $t1, $0, successAdd # do nothing no consecutive elements
		move $t0, $t1 # cur = cur->next
		lw $t1, 0($t0) # t1 = cur->next
		addi $t2, $t2, 1 # pos += 1
		j findPos
		foundPos:
			# check last element 
			beq $t1, $0, successAdd
			# cur->data = cur->data + cur->next->data
			lw $t4, 4($t0)
			lw $t5, 4($t1)
			add $t4, $t4, $t5 # t4 contains sum value
			sw $t4, 4($t0)
			# now delete the node
			lw $t4, 0($t1) # t4 contains cur->next->next
			sw $t4, 0($t0)
			j successAdd
	successAdd:
		li $v0, 0
		j doneAdd
	failAdd:
		li $v0, -1
	doneAdd:
		lw $a0, 0($sp)
		move $v1, $a0 # obtain the head back
		addi $sp, $sp, 4
		jr $ra


## Function swaps two consecutive nodes
# $a0 - pointer to head of the list
# $a1 - contains the position of the first mode to be swapped
# Returns: $v0  = 0 if pos exist else $v0 = -1, $v1 contains pointer to head 
SwapNodes:
	# check position <= 0 
	ble $a1, $0, failSwap
	# check head
	bne $a1, 1, notHeadSwap
	move $t0, $a0
	lw $t1, 0($t0) # cur->next
	lw $t2, 0($t1) # cur->next->next
	sw $t2, 0($t0) # cur->next = cur->next->next
	sw $t0, 0($t1) # cur->next = cur
	move $a0, $t1
	notHeadSwap:
	# allocate stack
	subi $sp, $sp, 4
	sw $a0, 0($sp)
	beq $a1, 1, successSwap
	# initialize current position
	move $t0, $a0 # t0 = cur = head
	lw $t1, 0($t0) # t1 = cur->next
	li $t2, 1 # pos  = 1
	findSwapPos:
		beq $t2, $a1, foundSwap # change pointers
		beq $t1, $0, successSwap # do nothing no consecutive elements
		addi $t2, $t2, 1 # pos += 1
		bne $t2, $a1, skip 
		move $t5, $t0 # cur->prev
		skip:
			move $t0, $t1 # cur = cur->next
			lw $t1, 0($t0) # t1 = cur->next
			j findSwapPos
		foundSwap:
			# check last element 
			beq $t1, $0, successSwap
			sw $t1, 0($t5) # prev->next = cur->next
			lw $t4, 0($t1) # store t1's next in t4
		    sw $t4, 0($t0) # t0->next = t1->next
		    sw $t0, 0($t1) # t1->next = t0
			j successSwap
	successSwap:
		li $v0, 0
		j doneSwap
	failSwap:
		li $v0, -1
	doneSwap:
		lw $a0, 0($sp)
		move $v1, $a0 # obtain the head back
		addi $sp, $sp, 4
		jr $ra

## Recursive Function finds sum within value range specified by the user
# $a0 - contains pointer to the head of the list
# $a1 - contains index1
# $a2 - contains index2
# Assumption index1 <= index2
# Returns: $v1 - head of the list
# $v0 - contains sum
FindSumInRange:
	# push values to stack
	subi $sp, $sp, 8
	sw	$a0, 4($sp)
	sw	$ra, 0($sp)
	# if head pointer $a0 == $0 (NULL) stop
	bne $a0, $0, elseSumInRange
	li $v0, 0 # initialize the sum
	# retrieve back the stack pointer
	lw	$a0, 4($sp)
	move $v1, $a0 # $v0 - contains pointer to head
	addi $sp, $sp, 8
	jr $ra # goto next 
elseSumInRange:
	# get the next pointer
	lw $t1, 0($a0) # t1 contains next pointer
	move $a0, $t1
	jal FindSumInRange
	lw	$a0, 4($sp)
	lw $t2, 4($a0) # contains the data
	sge $t4, $t2, $a1 # head->data >= val1
	sle $t5, $t2, $a2 # head->data <= val2
	and $t4, $t5, $t4 # $t4 - contains head->data <= val2 && head->data >= val1
	bne $t4, 1, notIncrementSum
	add $v0, $v0, $t2 # v1 contains sum
	notIncrementSum:
	# retrieve values back from stack
	lw	$ra, 0($sp)
	move $v1, $a0 # $v0 - contains pointer to head
	addi $sp, $sp, 8
	jr	$ra
	

## Function finds number of common values within 2 linkedlist
# $a0 - contains pointer to head of first list
# $a1 - contains pointer to head of second list
# $v0 - contains result
countCommonValues:
	# push values to stack
	subi $sp, $sp, 8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	# iterate through the first list
	li $t2, 0
	# flag to indicate whether there is a prev value
	li $t6, -1
	whileLoop:
		beq $a0, $0, endCountCommon
		# get current value
		lw $t3, 4($a0)
		move $t4, $a1
		whileLoop2:
			beq $t4, $0, notCommon
			# get the current value
			lw $t5, 4($t4)
			beq $t3, $t5, successCommon
			lw $t4, 0($t4)
			j whileLoop2
		successCommon:
			beq $t6, $t5, notcountIt
			addi $t2, $t2, 1 # increment the number
			move $t6, $t5
			notcountIt:				
		notCommon:
		lw $a0, 0($a0) # load next value
		j whileLoop
	endCountCommon:
	move $v0, $t2
	# retieve values back from the stack
	lw $a0, 4($sp)
	lw $a1, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	


################################################

#
#

#
#     	 	data segment			

#
#						

#
#

################################################



	 .data


msg81:	 .asciiz "This is the current contents of the linked list: \n"


msg82:   .asciiz "No linked list is found, pointer is NULL. \n"


msg83:   .asciiz "The first node contains:  pointerToNext = "


msg84:   .asciiz ", and value = "


msg85:   .asciiz "\n"


msg86:   .asciiz "The next node contains:  pointerToNext = "


msg89:   .asciiz "The linked list has been completely displayed. \n"


msg91:	 .asciiz "This routine will help you create your linked list. \n"


msg92:   .asciiz "How many elements do you want in your linked list? Give a non-negative integer value: 0, 1, 2, etc.\n"


msg93:   .asciiz "Your list is empty, it has no elements. Also, it cannot not be displayed. \n"


msg94:   .asciiz "Input the integer value for list element #"


msg95:   .asciiz ": \n"




msg110:  .asciiz "Welcome to the Lab3 program about linked lists.\n"


msg111:  .asciiz "Here are the options you can choose: \n"

msg112:  .asciiz "1 - create a new linked list \n"

msg113:  .asciiz "2 - display the current linked list \n"

msg114:  .asciiz "3 - insert element at end of linked list \n"

msg115:  .asciiz "4 - insert element into linked list at position n  \n"

msg116:  .asciiz "5 - delete element at position n from linked list \n"

msg117:  .asciiz "6 - delete element from linked list with value x \n"

msg118:  .asciiz "11 - exit this program \n"

msg119:  .asciiz "Enter the integer for the action you choose:  "

msg120:  .asciiz "Enter the integer value of the element that you want to insert:  "

msg124:  .asciiz "Enter the position number in the linked list where you want to insert the element:  "	

msg125:  .asciiz "Enter the position number in the linked list of the element you want to delete:  "

msg126:  .asciiz "Enter the integer value of the element that you want to delete:  "



msg127:  .asciiz "Thanks for using the Lab3 program about linked lists.\n"


msg128:  .asciiz "You must enter an integer from 1 to 7. \n"

msg130:  .asciiz "The return value was invalid, so it isn't known if the requested action succeeded or failed. \n"	

msg131:  .asciiz "\nThe requested action succeeded. \n"

msg132:  .asciiz "\nThe requested action failed. \n"

# MY DATA

msg133: .asciiz "7 - AddNodes: Add consecutive element value and delete the node \n"  

msg134: .asciiz "Please enter the position you want to add value with it's consecutive: "

msg135: .asciiz "8 - SwapNodes: Swap 2 consecutive nodes\n"

msg136: .asciiz "Please enter the position to swap 2 consecutive numbers: "  

msg137: .asciiz "9 - FindSumInRange: Calculates sum within the range specified by the user\n"

msg138: .asciiz "Please enter the 1st index number: "  

msg139: .asciiz "\nPlease enter the 2nd index number: "  

msg140: .asciiz "\nSum is: "  

msg141: .asciiz "10 - CountCommon: Finds number of common values between 2 linkedlists\n" 

msg142: .asciiz "\nNumber of common values between list1 and list 2: " 

##


## end of file Lab3main.txt
##SK
