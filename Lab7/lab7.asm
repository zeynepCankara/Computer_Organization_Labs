# Zeynep Cankara -- 15/05/2019
# Course: CS224
# Section: 2
# Lab: 7
# Version: 1.0
# lab7.asm -- Description: Introduction to PIC32 Programming (Programme 1)

# ========== TEXT SECTION ============ ###
		.text 
	.globl	__start
	
__start:
	# // Program No 1
	# char junk;
	# SPI2ACONbits.ON = 0;
	initspi:
		# // load the address of SPI2ACON -> $t0
		# // SPI2ACON has virtual address 0xBF80
		# // Access the SPI2ACONbits.ON -> 16th bit -> 5A00
		lui $t0, 0xBF80 
		ori $t0, 0x5A00
		# // Get the value of SPI2ACON -> $t1
		lw $t1, 0($t0) 
		# // AND mask to clear bit 15
		andi $t1, $t1, 0x7FFF
		# // Store the value back in SPI2ACON
		sw $t1, 0($t0)
		# junk = SPI2ABUF;
		# // Read the value in SPI2ABUF (5A20) -> $t1
		lw $t1, 0x20($t0)
		# SPI2ABRG = 7; 
		# // Store value 7 in SPI2ABRG (5A30) 
		li $t2, 7
		sw $t2, 0x30($t0)
		# SPI2CONbits.MSTEN = 1;
		# // Enable bit 5 (MSTEN) of SPI2ACON
		lw $t2, 0($t0)
		# // OR mask to enable bit 5 (6th bit)
		ori $t2, $t2, 0x0020
		# // Store the value back in SPI2ACON 
		sw $t2, 0($t0)
		# SPI2CONbits.CKE = 1;
		lw $t2, 0($t0)
		# // Apply OR mask to enable bit 8 (CKE) of SPI2ACON
		ori $t2, $t2, 0x0100
		# // Store the value back in SPI2ACON 
		sw $t2, 0($t0)
		# while(!SPI2CONbits.SSEN);
	while:
		# // load the value SPI2ACON -> $t2
		lw $t2, 0($t0)
		# // Mask all bits except bit 7 (SSEN) of SPI2ACON
		# // Masked value -> $t3
		andi $t3, $t2, 0x0080
		# // Spin in the loop while loop untill SSEN = 1
		beq $t3, $0, while
		# SPI2CONbits.ON = 1;
		# // Value of SPI2CON -> $t3
		lw $t3, 0($t0)
		# // Apply OR mask to enable bit 15 (ON) of SPI2ACON
		ori $t3, $t3, 0x8000
		# // Save value back in SPI2ACON
		sw $t3, 0($t0)
	# exit the Programme 1
	li $v0, 10 
	syscall