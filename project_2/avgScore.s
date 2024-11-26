.data 

orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100


str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded down) with dropped scores removed: "
space: .asciiz " "
newLine: .asciiz "\n"


.text 

# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for dropped scores).
# It then prints out average score with the specified number of (lowest) scores dropped from the calculation.
main: 
	addi $sp, $sp -4
	sw $ra, 0($sp)
checker:
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	move $s0, $v0	# $s0 = numScores
	
bge $s0, 26, checker		#checks for input validation
ble $s0, $zero checker
	
	
	
move $t0, $0
la $s1, orig	# $s1 = orig
la $s2, sorted	# $s2 = sorted
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	# Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	move $a0, $s0
	jal selSort	# Call selSort to perform selection sort in original array
	
	li $t0, 25
	bne $s0, $t0, after_check
	
	addi $s2, $s2, 4
	
after_check:
	li $v0, 4 
	la $a0, str2 
	syscall
	move $a0, $s1	# More efficient than la $a0, orig
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	# More efficient than la $a0, sorted
	jal printArray	# Print sorted scores
	
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	move $a1, $v0
	sub $a1, $s0, $a1	# numScores - drop
	move $a0, $s2
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	# Your code here to compute average and print it
	
	div $v0, $a1 # calcSum / (numScores - drop)
	mflo $t1 
	move $a0, $t1
	li $v0, 4
    	la $a0, str5 # Print the line
    	syscall

	# Check if there's a remainder, if so, print the average
	bnez $t0, print_average

	
	move $t1, $v0
	move $a0, $v0
	li $v0, 1 # Print the average score
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10
	syscall

print_average:
	move $a0, $t1
	li $v0, 1 
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10
	syscall

cont:
	move $t1, $v0
	move $a0, $v0
	li $v0, 1
	move $a0, $t1 
	syscall 

	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10
	syscall

# printList takes in an array and its size as arguments.
# It prints all the elements in one line with a newline at the end.
printArray:
	# Your implementation of printList here
	
	la $t1, ($a0)
	add $t3, $zero, $a1

Loop:	beq $t3, $zero, return
	lw $t0, ($t1) 
	li $v0, 1 
	move $a0, $t0
	syscall 
	addi $t3, $t3, -1 
	addi $t1, $t1, 4
	li $v0, 4
	la $a0, space
	syscall
	j Loop
	
	


return:
	li $v0, 4
	la $a0, newLine
	syscall
	jr $ra

# selSort takes in the number of scores as argument.
# It performs SELECTION sort in descending order and populates the sorted array
selSort:

	# Your implementation of selSort here
	addi $sp, $sp -8
	sw $ra, 4($sp)
	sw $s2, 8($sp)
	la $t0, ($s1) 
	la $t5, ($s2) 
	li $t1, 0 
	li $t3, 0

loop_start:
	lw $t3, ($t0) 
	sw $t3, ($s2) 
	addi $t0, $t0, 4 
	addi $s2, $s2, 4
	addi $t1, $t1, 1 
	blt $t1, $a0, loop_start 

reset: 
	add $s2, $t5, $0 
	beq $t1, $zero, reset


	li $t0, 0 
	addi $t2, $a0, -1 

iLoop:
    bgt $t0, $t2, End          
    add $t3, $zero, $t0        
    addi $t1, $t0, 1          

jLoop:
    bgt $t1, $a0, iEnd         

   
    sll $t4, $t3, 2            
    add $s2, $s2, $t4         
    lw $t5, ($s2)              
    sub $s2, $s2, $t4        
    sll $t4, $t1, 2           
    add $s2, $s2, $t4          
    lw $t6, ($s2)              
    sub $s2, $s2, $t4          

    bgt $t6, $t5, NewMax       

    addi $t1, $t1, 1          
    j jLoop                    

iEnd:
    
    sll $t5, $t3, 2            
    add $s2, $s2, $t5          
    lw $t6, 0($s2)             
    sub $s2, $s2, $t5          
    sll $t5, $t0, 2            
    add $s2, $s2, $t5         
    lw $t7, 0($s2)            
    sub $s2, $s2, $t5          
    sll $t5, $t0, 2            
    add $s2, $s2, $t5         
    sw $t6, 0($s2)             
    sub $s2, $s2, $t5         
    sll $t5, $t3, 2            
    add $s2, $s2, $t5        
    sw $t7, 0($s2)            
    sub $s2, $s2, $t5         

    addi $t0, $t0, 1           
    j iLoop                    

End:
    lw $s2, 8($sp)   
    lw $ra, 4($sp)   
    addi $sp, $sp, 8 
    jr $ra           
	
NewMax:
	add $t3, $t1, $zero 
	addi $t1, $t1, 1
	j jLoop


# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	sub $sp,$sp,16
	sw $ra,12($sp)
	sw $a1,16($sp)
	li $v0, 0
	li $t3, 0

calcSum_call:
	beq $a1, $zero, end_recur	
	sll $t0, $t3, 2
	add $t0, $a0, $t0
	lw $t1, ($t0)
	add $v0, $t1, $v0
	addi $a1, $a1,-1
	addi $t3, $t3, 1
	j calcSum_call

end_recur:
	lw $a1, 16($sp)
	lw $ra, 12($sp)
	addiu $sp, $sp, 16
	jr $ra

rounddown:
	addi $v0, $a0, 1
	j cont
