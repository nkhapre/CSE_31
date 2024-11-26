.data
prompt: .asciiz "Please enter a number: "

        .text
main:
        # Print prompt
        li      $v0, 4          # syscall for print string
        la      $a0, prompt     # load address of prompt string
        syscall                 # execute syscall

        # Read integer input from user
        li      $v0, 5          # syscall for read integer
        syscall                 # execute syscall
        move    $t3, $v0        # move read integer to $t3

        # Initialize registers for Fibonacci calculation
        add     $t0, $0, $zero  # $t0 = 0
        addi    $t1, $zero, 1   # $t1 = 1
        
fib:
        beq     $t3, $0, finish # if $t3 == 0, jump to finish
        add     $t2, $t1, $t0   # $t2 = $t1 + $t0
        move    $t0, $t1        # $t0 = $t1
        move    $t1, $t2        # $t1 = $t2
        subi    $t3, $t3, 1     # $t3 = $t3 - 1
        j       fib             # jump to fib
        
finish:
        addi    $a0, $t0, 0     # move $t0 to $a0 for printing
        li      $v0, 1          # syscall for print integer
        syscall                 # execute syscall

        # Exit program
        li      $v0, 10         # syscall for exit
        syscall                 # execute syscall