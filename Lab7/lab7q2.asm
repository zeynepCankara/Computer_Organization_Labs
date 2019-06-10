# Zeynep Cankara -- 15/05/2019
# Course: CS224
# Section: 2
# Lab: 7
# Version: 1.0
# lab7q2.asm -- Description: Introduction to PIC32 Programming (Programme 2)
#								- Note: Used "->" notation to indicate which variable in which register
#										My comments indicated by "//" 

# ========== TEXT SECTION ============ ###
		.text 
	.globl	__start
	
__start:
	# // Program No 2
	# int stop = 0;
	# // stop -> $t1
	li $t1, 0b0
	# int initial  = 0b01110111;
	# // initial -> $t0
	li $t0, 0b01110111
	# int right = 1;
	# // right -> $t2
	li $t2, 0b0
	main: 
		# TRISD = 0x0;
		# // Virtual address of TRISD 0xBF88 60C0
		# // TRISD's address -> $t3
		lui $t3, 0xBF88
		ori $t3, 0x60C0
		# // Set the bits of TRISD 0 (output)
		sw $t1, 0($t3)
		# // Three bits of PORTA are inputs
		# TRISA = 0b111; 
		li $t4, 0b111 # 0b111 -> $t4
		# // Address of TRISA 0xBF88 6000
		andi $t3, $t3, 0x0000 # // AND mask to clear lower 16 bits 
		ori $t3, $t3, 0x6000 # // Address of TRISA -> $t3
		sw $t4, 0($t3) # // Store the value 0b111 in TRISA
		# PORTD = initial;
		# // Address of PORTD 0xBF88 60D0
		andi $t3, $t3, 0x0000 # // AND mask to clear lower 16 bits 
		ori $t3, $t3, 0x60D0 # // Address of PORTD -> $t3
		sw $t0, 0($t3) # // Store initial in PORTD 
		# while(1) {
		while1:
			# // continue until 0
			bne $0, $0, end
			# int lsb;
			# int mask;
			# if(PORTABits.RA1 == 0) {
			# // Address PORTA : 0xBF88 6010 
			andi $t3, $t3, 0x0000 # // AND mask to clear lower 16 bits 
		    ori $t3, $t3, 0x60D0 # // Address of PORTA -> $t3
		    # // load value into the $t4
		    lw $t4, 0($t3)
		    # // mask all bits except bit 1 to access PORTABits.RA1
		    # // Store masked value ->  $t5
		    andi $t5, $t4, 0x0020
		    # // Check if(PORTABits.RA1 == 0) condition
			bne $t5, $0, ifStop
				# stop = !stop;
				# // change value of STOP -> $t1
				beq $t1, $0, change1:
					li $t1, 0
					j endChange
				change1:
					li $t1, 1 
				endChange:
				# if(!stop){ 
				ifStop:
					bne $t1, $0, else # // continue if stop is not 0
					# // Get the PORTD's address
					andi $t3, $t3, 0x0000 # // AND mask to clear lower 16 bits 
					ori $t3, $t3, 0x60D0 # // Address of PORTD -> $t3
					# PORTD = initial;
					sw $t0, 0($t3) # // Store initial in PORTD 
				else: 
			# // check value stop
			ifStop2: 
			# if(!stop){
				bne $t1, $0, else2 # // continue if stop is not 0
				# // lsb -> $t6
				# // get PORTDs value inside $t6
				lw $t6, 0($t3)
				# lsb = PORTD & 0x1;
				andi $t6, $t6, 0x1 
				# // mask -> $t7
				# mask = lsb << 7;
				addi $t7, $t6, 0
				sll  $t7, $t7, 7
				# PORTD = (PORTD >> 1) | mask; 
				# // get PORTDs value inside $t5
				lw $t5, 0($t3)
				# // right shift
				srl $t5, $t5, 1
				# apply OR mask
				or $t5, $t5, $t7 
				# store value back in PORTD
				sw $t5, 0($t3)
				j endElse2
			# else {
			else2:
				# PORTD = 0b11111111;
				li $t5, 0b11111111
				# // $t3 contains address of PORTD
				sw $t5, 0($t3)
			endElse2:
			# delay_ms(1000); 
			li $v0, 32
			li $a0, 1000
			syscall # // one second waiting
			j while1
		end:
	# // exit the Programme 2
	li $v0, 10 
	syscall