.text
.globl main

main:
    # Print prompt message for input
    la $a0,input_a_msg
    li $v0,4
    syscall

    # Initialize array address and loop variables
    la $t6,arr
    move $t7,$zero
    addi $t8,$zero,10
    move $t9,$zero

input:
    # Read integer from user input
    li $v0,5
    syscall

    # Calculate array index and store user input
    move $t0,$t7
    mul $t0,$t0,4
    addu $t1,$t0,$t6
    sw $v0,0($t1)

    # Increment loop variable and check loop condition
    addi $t7,$t7,1
    blt $t7,$t8,input

loop1:
    # Initialize inner loop variables
    addu $t9,$t7,1
    mul $t0,$t7,4
    addu $t1,$t0,$t6

    # Load current array element as max
    lw $t2,0($t1)
    move $t5,$t1

loop2:
    # Calculate address of current array element
    move $t0,$t9
    mul $t0,$t0,4
    addu $t4,$t0,$t6

    # Load array element to compare with max
    lw $t3,0($t4)

    # Compare current element with max
    bge $t2,$t3,skip

    # Update max if current element is greater
    lw $t2,0($t4)
    move $t5,$t4

skip:
    # Increment inner loop variable and check loop condition
    addi $t9,$t9,1
    blt $t9,$t8,loop2

    # Swap values if max has been updated
    lw $t4,0($t1)
    sw $t4,0($t5)
    sw $t2,0($t1)

    # Increment outer loop variable and check loop condition
    addi $t7,$t7,1
    addi $t4,$t7,1
    blt $t4,$t8,loop1

    # Print prompt message for output
    la $a0,output_int_msg
    li $v0,4
    syscall

    # Reset loop variable for next loop
    move $t7,$zero

print:
    # Print array element
    move $t0,$t7
    mul $t0,$t0,4
    addu $t1,$t0,$t6
    lw $a0,0($t1)
    li $v0,1
    syscall

    # Print separator
    la $a0,seperate
    li $v0,4
    syscall

    # Increment loop variable and check loop condition
    addi $t7,$t7,1
    blt $t7,$t8,print

.data
arr: .space 40
input_a_msg: .asciiz "Please input 10 numbers in array\n"
output_int_msg: .asciiz "The result are as follows:\n"
seperate: .asciiz " "
