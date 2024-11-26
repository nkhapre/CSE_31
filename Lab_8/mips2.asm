.data

# TPS 2 #3 (input prompt to be displayed)
prompt: .asciiz "Please enter an integer: "

.text
main: 	addi $sp, $sp, -4	# Moving stack pointer to make room for storing local variables (push the stack frame)
	# TPS 2 #3 (display input prompt)
	li $v0, 4
	la $a0, prompt
	syscall
	
	#move $s1, $sp
	
	# TPS 2 #4 (read user input)
	li $v0,5
	syscall
	add $a0, $v0, $zero
		
	jal recursion	# Call recursion(x)
	
	# TPS 2 #6 (print out returned value)
	sw $v0, 0($sp)
	li $v0, 1
	lw $a0, 0($sp)
	syscall
	
	j end		# Jump to end of program


# Implementing recursion
recursion: addi $sp, $sp, -12	# Push stack frame for local storage

	# TPS 2 #7 
	sw $ra, 0($sp)
			
	addi $t0, $a0, 1
	bne $t0, $zero, not_minus_one
	
	# TPS 2 #8 (update returned value)
	addi $v0, $zero, 1
	
	j end_recur
		
not_minus_one:	bne $a0, $zero, not_zero
	# TPS 2 #9 (update returned value)
	addi $v0, $zero, 3
	
	j end_recur		

not_zero: sw $a0, 4($sp) 	
	# TPS 2 #11 (Prepare new input argument, i.e. m - 2)
	addi $a0, $a0, -2
	
	jal recursion	# Call recursion(m - 2)
	
	# TPS 2 #12 
	sw $v0, 8($sp)
		
	# TPS 2 #13 (Prepare new input argument, i.e. m - 1)
	lw $a0, 4($sp)
	addi $a0, $a0, -1
	
	jal recursion	# Call recursion(m - 1)
	
end:

end_recur:
