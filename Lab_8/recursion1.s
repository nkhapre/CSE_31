.data
prompt: .asciiz "Please enter a number: "


.text
.globl main
main:
    # Print prompt
    li $v0, 4                  # syscall for print string
    la $a0, prompt             # load address of prompt string
    syscall

    # Read integer input
    li $v0, 5                  # syscall for read integer
    syscall
    move $s0, $v0              # move read integer to $s0 to save it

    # Call the recursive function
    move $a0, $s0              # move saved integer into argument register
    jal recursion              # call the recursion function

    # Print result
    move $a0, $v0              # move result into $a0 for printing
    li $v0, 1                  # syscall for print integer
    syscall

    # Exit program
    li $v0, 10                 # syscall for exit
    syscall

recursion:
    addi $sp, $sp, -12         
    sw $ra, 0($sp)             # save return address
    sw $a0, 4($sp)             # save argument m

    # Base case checks
    li $t1, -1
    bne $a0, $t1, check_lower_base_case
    li $v0, 3
    j recursion_end

check_lower_base_case:
    li $t1, -2
    bgt $a0, $t1, recursive_case
    li $t1, -3
    bgt $a0, $t1, return_1
    li $v0, 2
    j recursion_end

return_1:
    li $v0, 1
    j recursion_end

recursive_case:
    # Compute recursion(m - 3)
    lw $a0, 4($sp)
    addi $a0, $a0, -3
    jal recursion
    sw $v0, 8($sp)             # save result of recursion(m - 3)

    # Compute recursion(m - 2)
    lw $a0, 4($sp)
    addi $a0, $a0, -2
    jal recursion
    lw $t1, 8($sp)             # load result of recursion(m - 3)
    add $v0, $v0, $t1          # add results of recursion(m - 3) and recursion(m - 2)

    # Add m to the result
    lw $t1, 4($sp)             # reload m
    add $v0, $v0, $t1          # add m to the result

recursion_end:
    lw $ra, 0($sp)             # restore return address
    lw $a0, 4($sp)             # restore argument m
    addi $sp, $sp, 12          # restore stack pointer
    jr $ra                     # return from function
