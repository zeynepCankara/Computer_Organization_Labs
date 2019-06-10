	
	.text
	again:	
			addi $t0, $0,2
			addi $t1, $0, 3
			addi $t2, $0, 0
			addi $t3, $0, 0
			beq   $t0, $t1, next
			bne   $t2, $t3, again
			add $t0, $0, $t0
			add $t0, $0, $t0
			jr      $ra
	next:	
			j	again