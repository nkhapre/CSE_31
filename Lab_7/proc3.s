.data

newLine: .asciiz "\n"
fooPrint: .asciiz "p + q: "

.text 
main:
	addi $s0, $0, 2		# x = 5 at $s0
	addi $s1, $0, 4		# y = 4 at $s1
	addi $s2, $0, 6		# z = 6 at $s2
	
	move $a0, $s0		# a0 = x = m
	move $a1, $s1		# a1 = y = n
	move $a2, $s2		# a2 = z = o
	
	jal foo
	
	add $t0, $s0, $s1	# temp0 = x + y
	add $t1, $s2, $v0	# temp1 = z + foo(x,y,z)
	add $s2, $t1, $t2	# z = temp0 + temp1 (x+y+z+foo(x,y,z)
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 10	# exit code
	syscall
	
	
foo:
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $ra, 8($sp)
	
	add $t0, $a0, $a2
	add $t1, $a1, $a2
	add $t2, $a0, $a1
	
	sub $t3, $a0, $a2
	sub $t4, $a1, $a0
	add $t5, $a1, $a1
	
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	
	jal bar
	move $s0, $v0	# p = result of bar
	
	move $a0, $t3
	move $a1, $t4
	move $a2, $t5
	
	jal bar
	move $s1, $v0	# q = result of bar
	
	
	add $t6, $s0, $s1 # temp6 = p + q
	
	
	li $v0, 4
	la $a0, fooPrint
	syscall
	
	li $v0, 1
	move $a0, $t6
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	add $v0, $s0, $s1	# return p+q
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $ra, 8($sp)
	add $sp, $sp, 12
	
	jr $ra
	
bar:
	sub $t0, $a1, $a0
	sllv $v0, $t0, $a2
	jr $ra
	
	
