.data
n: .word 25
str1: .asciiz "Less than \n"
str2: .asciiz "Less than or equal to\n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to\n"

.text
main: 
	la $t0, n
	lw $s0, 0($t0)
	
	# TPS2 , problem 4
	li $v0, 5
	syscall
	move $s1, $v0
	
	# TPS2 , problem 5
	slt $t0, $s1, $s0
	bne $t0, $zero, Less
	
	# TPS2 , problem 6
	beq $t0, $zero, GreaterOrEqual
	
	# TPS2 , problem 7
	slt $t0, $s0, $s1
	bne $t0, $zero, Greater
		
	# TPS2 , problem 8
	beq $t0, $zero, GreaterOrEqual
	
Less:
	li $v0, 4
	la $a0, str1
	syscall
	li      $v0, 10		
	syscall	

LessOrEqual:
	li $v0, 4
	la $a0, str2
	syscall
	li      $v0, 10		
	syscall
	
Greater:
	li $v0, 4
	la $a0, str3
	syscall
	li      $v0, 10		
	syscall
	
GreaterOrEqual:
	li $v0, 4
	la $a0, str4
	syscall
	li      $v0, 10		
	syscall
	

	