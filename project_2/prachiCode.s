.data
orig: .space 100 # In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100
str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded down) with dropped scores removed: "
newline: .asciiz "\n"
count: .word 23

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
	addi $sp, $sp -4	# create space on the stack for return address
	sw $ra, 0($sp)	# return address
    
	# Prompt the user to enter the number of assignments
 
numAssignments:
	li $v0, 4		# syscall command for printing string
	la $a0, str0	# prints string 0
    	syscall
    
    	# Read the number of assignments from the user
    	li $v0, 5		# syscall command for reading int from user
    	syscall
   	
    	move $s0, $v0	# store the number of assignments into s0
    
    	# Check if the entered value is within the valid range
    # If not, prompt the user to enter the number of assignments again
    bge $s0, 26, numAssignments		# if the number of assignments is >= 26 then loop back to prompt
    ble $s0, $zero numAssignments	# if the number of assignments is <= 0 then loop back to prompt
    
    # Initialize loop variables
    move $t0, $0
    la $s1, orig	# origional array
    la $s2, sorted	# sorted array
  
    
    
loop_in:

	# Print out the string to read the scores
    	li $v0, 4
    	la $a0, str1
    	syscall
   
    	sll $t1, $t0, 2	# doing sll so that we can multiply by 4 to make it easier to append to array (ints are 4 bytes)
    	add $t1, $t1, $s1 # $t1 = $t1 + origional array 
   
    	li $v0, 5 	# Read elements from user
    	syscall
    	sw $v0, 0($t1)
   
    	addi $t0, $t0, 1	# increase counter for num scores asked
    	bne $t0, $s0, loop_in	# keep askig for scores until num scores == num input
    	
    	move $a0, $s0		# after it's done, move s0 to a0
    	jal selSort 	# Call selSort to perform selection sort in original array
    
    	# print string for the origional scores
    	li $v0, 4
    	la $a0, str2
    	syscall
    
    	move $a0, $s1 	# move number of assignments into arg register a0
    	move $a1, $s0	# move the address of orig array over to arg register a1
    	jal printArray 	# Print original scores
   
   	# Print Sorted scores
    	li $v0, 4
    	la $a0, str3
    	syscall
   
    	move $a0, $s2 	# move the sorted arr address into arg a0
    	jal printArray 	# Print sorted scores
    
    	# print the string for entering the numebr of scores to top
    	li $v0, 4
    	la $a0, str4
    	syscall
    
    	# Read the number of scores to drop
    	li $v0, 5 
    	syscall
    	
    	move $a1, $v0	# move the num scores to drop to arg register a1

    	# Check if number of scores to drop is >= to total number of assignments
    	bge $a1, $s0, average_done_else	#if yes then go to else condition; 

    	sub $a1, $s0, $a1 # a0 = numScores - dropped --> finds out how many scores to keep
    	move $a0, $s2 # moves the sorted base address to the arg register a0

    	jal calcSum # Call calcSum to RECURSIVELY compute the sum of scores that are not dropped

    	# Calculate average and print it
    	move $a0, $t4 # Move the returned sum to $a0
    	div $t0, $a0, $a1 # Divide the sum by the number of scores (rounded down)
    	mflo $t5 # Move the quotient to $t5 (average score)

    	li $v0, 4
    	la $a0, str5 # Print the line
    	syscall

    	move $a0, $t5 # Load the rounded up average score
    	li $v0, 1 # Print the average score
    	syscall

    	j average_done

average_done_else:
    	li $v0, 4
    	la $a0, str5
    	syscall
    
    	li $v0, 1
    	li $a0, 0 # Print 0 for average score
    	syscall
   
average_done:
    	li $v0, 10 # Exit program
    	syscall
   
   
   
# printList takes in an array and its size as arguments.
# It prints all the elements in one line with a newline at the end.
printArray:
    	# Your implementation of printList here
    	add $t0, $a0, $zero	# t0 = address of arr
    	addi $t1, $zero, 0	# initialize t1 to 0
   
printArray_2:
    	li $v0, 1
    	lw $a0, 0($t0) # a[i]
    	syscall
    	
    	li $a0, 32
    	li $v0, 11 # syscall number for printing character
    	syscall
    	
    	addi $t0, $t0, 4	# get next element
    	addi $t1, $t1, 1	# increment counter
    	
    	bne $t1, $a1, printArray_2	# as long as counter ≠ size, keep printing
    	
    	li $v0, 4
    	la $a0, newline
    	syscall
    	
    	jr $ra
   
   
   
# selSort takes in the number of scores as argument.
# It performs SELECTION sort in descending order and populates the sorted array
# selSort: Perform selection sort in descending order
# Arguments:
#   $a0: Pointer to the array
#   $a1: Length of the array
selSort:
    	move $t4, $a0	# t4 = pointer to array
    	move $s3, $s1	# s3 = origional arr address
    	move $s4, $s2   # s4 = sorted arr address
    	li $t0, 0	# this is the loop counter
    	
copy_loop:	# copies from one array to another
    	beq $t0, $t4, sort_loop_init  	# if the pointer to array ≠ number of scores then continue, if it's = then branch
    	
    	sll $t1, $t0, 2	# multiply by 4 to change the ptr of the array to calculate offset for elements in arr (ints are 4 bvytes)
    	
    	add $t2, $s3, $t1	# t2 = origional arr address + offset
    	add $t3, $s4, $t1	# t3 = sorted arr adress + offset
    		
    	lw $t5, 0($t2)	# loading the address thats there at t2 --> origional
    	sw $t5, 0($t3)  # load the address at t3 --> sorted
    	
    	addi $t0, $t0, 1  # increment loop counter by 1
    	
    	j copy_loop	# keep looping this until counter = num scores

sort_loop_init:
    	move $t4, $a0	# reuses register to store address of origional array
    	move $s4, $s2	# s4 = address of sorted array


    	# Outer loop - $t4 is used as loop counter
outer_loop:
    	li $t5, -2147483648	# smallest possible int so that we can use it for comparison
    	move $t6, $s4	# ptr to sorted array gets moved to t6 because then we are using  	
    	move $t7, $0	# initialize t7 to 0

    	# Inner loop - find the max element
    	move $t0, $0	# initialize t0 to 0; t0 --> the index of max int of unsorted
    	     
inner_loop:
    	lw $t1, 0($t6)	# loads the address of current element of sorted 
    	bge $t1, $t5, found_new_max	# if element > max then branch, if not then keep max index same
    	
no_new_max:
        addi $t6, $t6, 4	# add 4 to move to next element 
       	addi $t0, $t0, 1  	# increment the counter by 1
       	blt $t0, $t4, inner_loop	# leep looping as logn as the counter ≠ length of array
    	j continue_outer	# if equal then exit inner loop and go back to outer loop

found_new_max:
       	move $t5, $t1	# move the new max into prev max
       	move $t7, $t0   # move the new max INDEX to replace prev max INDEX 
        
        j no_new_max	# go back to no_new_max so that we can keep moving thru array and keep comparing

continue_outer:
    	# Swap max element with the first element in unsorted part
    	sll $t8, $t7, 2	# sll because we need to access the address of the max element in the array and store it in t8
    	add $t9, $s4, $t8  # add offset ot base address and store it in t9
    	lw $t2, 0($t9)	# load max element 
    	lw $t3, 0($s4)	# load curr address
    	sw $t2, 0($s4)	# store the curr address to t2
    	sw $t3, 0($t9)  # store max address to t3

    	# Move unsorted part's boundary
    	addi $s4, $s4, 4	# increment the pointer by 4 to ponit to next element
    	addi $t4, $t4, -1	# decrement the counter by 1 so that the counter doesn't account for the already sorted elements
    	bne $t4, $zero outer_loop  # a long as size of arr ≠ 0, keep looping

    	jr $ra   # Return from selSort
   
   
   
# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
    # Your implementation of calcSum here
    	addi $sp, $sp, -12 # make space for 3 var
    	sw $ra, 8($sp) # Save return address
    	sw $a0, 4($sp) # save the sorted array onto the stack
    	sw $a1, 0($sp) # Save size of arr
    	
    	bgt $a1, $zero, n_zero # if size of array > 0 then branch
    	addi $t4, $zero, 0	# initialize sum of array to 0
   
end_recur:
    	lw $a1, 0($sp)	# load size 
    	lw $a0, 4($sp)	# load array
    	lw $ra, 8($sp)	# load ra
    	addi $sp, $sp, 12 # deallocarte space form stack 
    	jr $ra
   
n_zero:
	addi $a1, $a1, -1	# decrement the size of array so that 
    	jal calcSum	# jal to calculate the sum (recursive)
    	
    	lw $a1, 0($sp) # loads the initial size
    	addi $a1, $a1, -1 # decreement by 1 since the c code says to sub 1 everytime
    	
    	sll $t0, $a1, 2 # Make the increment of 4 to access element
    	
    	add $t1, $a0, $t0 # add the origional address to the offset
    	lw $t2, 0($t1)	# loads the element from that position
    	add $t4, $t4, $t2 # add to curr sum
    	
    	j end_recur
