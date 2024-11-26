.data
even_sum: .word 0
odd_sum: .word 0
str1: .asciiz "Please enter a number: "
str2: .asciiz "Sum of even numbers is: "
str3: .asciiz "\nSum of odd numbers is: "

.text
main: 
	

loop:
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	beqz $t0, print
	srl $t1, $t0, 1         
    sll $t1, $t1, 1
    bne $t1, $t0, check_even
	lw $t2, odd_sum          
    	add $t2, $t2, $t0        
    	sw $t2, odd_sum         
    	j loop 
    	
check_even:
	lw $t2, even_sum         
    	add $t2, $t2, $t0        
    	sw $t2, even_sum         
    	j loop
print:
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 1
    	lw $a0, odd_sum
    	syscall
    	
    	li $v0, 4
	la $a0, str3
	syscall
    	
    	li $v0, 1
    	lw $a0, even_sum
    	syscall
    	
    	li      $v0, 10		
	syscall
