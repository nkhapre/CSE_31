
.data
x:	.word 5
y:	.word 10
m:	.word 15
b:	.word 2

.text
MAIN:	
	la $t0, x
	lw $s0, 0($t0)		# s0 = x
	la $t0, y
	lw $s1, 0($t0)		# s1 = y
	
	
	# Prepare to call sum(x)
	addu $a0, $zero, $s0	# Set a0 as input argument for SUM
	jal SUM
	addu $t0, $s1, $s0	# temp0 = x + y
	addu $s1, $t0, $v0	# temp1 = temp0 + sum(x)
	addiu $a0, $s1, 0  
	li $v0, 1		 
	syscall	
	j END
		
SUM:
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $a0, 4($sp)
	sw $ra, 8($sp)

	lw $s0, 0($t0)       # Load m into $s0; safe after saving $s0
    	addu $a0, $s0, $a0   # Update a0 for SUB; $a0 = m + n
    	jal SUB              # Call SUB function

    	lw $s0, 0($sp)       # Restore original $s0 for MAIN
    	lw $a0, 4($sp)       # Restore original $a0 (n)
    	lw $ra, 8($sp)       # Restore $ra
    	addiu $sp, $sp, 12   # Reset stack pointer
    	addu $v0, $a0, $v0   # Add original n to result from SUB
    	jr $ra               # Return to MAIN

		
SUB:	
	la $t0, b
	addiu $sp, $sp -4
	sw $s0, 0($sp)		# Backup s0 from SUM
	lw $s0, 0($t0)		# s0 = b
	subu $v0, $a0, $s0
	lw $s0, 0($sp)		# Restore s0 from SUM
	addiu $sp, $sp 4
	jr $ra

END:
