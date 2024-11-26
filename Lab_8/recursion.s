.data
prompt: .asciiz "Please enter an integer: "
returning_1: .asciiz "Returning 1\n"
returning_3: .asciiz "Returning 3\n"

.text
main:
	addi $sp, $sp, -4
    	li $v0, 4
    	la $a0, prompt
    	syscall

    	li $v0, 5
    	syscall
    	add $a0, $v0, $zero

    	jal recursion

    	sw $v0, 0($sp)
    	li $v0, 1
    	lw $a0, 0($sp)
    	syscall

    	j end

recursion:
    	addi $sp, $sp, -12

    	sw $ra, 0($sp)

    	addi $t0, $a0, 1
    	bne $t0, $zero, not_minus_one

    	li $v0, 4               # Print "Returning 1"
    	la $a0, returning_1
    	syscall

    	addi $v0, $zero, 1
    	j end_recur
	
not_minus_one:
    	bne $a0, $zero, not_zero

    	li $v0, 4               # Print "Returning 3"
    	la $a0, returning_3
    	syscall

    	addi $v0, $zero, 3
    	j end_recur

not_zero:
    	sw $a0, 4($sp)
    	addi $a0, $a0, -2
    	jal recursion

    	sw $v0, 8($sp)          # Store the result of recursion(m - 2)

    	lw $a0, 4($sp)
    	addi $a0, $a0, -1
    	jal recursion

    	lw $t0, 8($sp)          # Load the result of recursion(m - 2)
    	add $v0, $v0, $t0       # Add the result of recursion(m - 2) to the result of recursion(m - 1)

end_recur:
    	lw $ra, 0($sp)
    	addi $sp, $sp, 12
    	jr $ra

end:
    	addi $sp, $sp, 4
    	li $v0, 10
    	syscall
