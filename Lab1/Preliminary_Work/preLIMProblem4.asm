## Sample Program
	.text
	.globl __start
__start:
	la	$t1, a
	la	$t2, b
	lw	$t2, b
	lw	$t2, b
	
		
	# exit the program
	li $v0, 10	
	syscall
	
	.data
	.space	20
a:	.word	1, 2, 3
b:	.word   	1
	
