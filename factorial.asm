.data
string1: .asciiz "Enter N: "
string2: .asciiz "N! = "
.align 2
N: .space 4

.text
.globl main

main:
	# input N
	li $v0,4
	la $a0,string1
	syscall
	
	# user input integer
	li $v0,5
	syscall
	# load address of N to $t0
	la $t0,N
	# store user input to address of N by using $t0
	sw $v0,0($t0)
	
	# load user input to $a0 for factorial(N) function
	lw $a0,0($t0)
	# call function
	jal factorial
	# #t0 = factorial(N)
	move $t0,$v0
	
	# print string2
	li $v0,4
	la $a0,string2
	syscall
	
	# move value from $t0 to $a0
	move $a0,$t0
	# print out factorial output
	li $v0,1
	syscall
	
	# exit program
	li $v0,10
	syscall

# int factorial(N);
factorial:
	addi $sp,$sp,-4
	sw $s0,0($sp)
	
	# initial factorial = 1
	addi $v0,$zero,1
	# if(N<=1) then return 1
	ble $a0,1,return
		
	# initial i = 1
	li $t0,1
while:
	# while(i<=N)
	bgt $t0,$a0,end
	# factorial = factorial * i
	mul $v0,$v0,$t0
	# i++
	addi $t0,$t0,1
	j while
end:	
	
return:	
	# return $v0
	lw $s0,0($sp)
	addi $sp,$sp,4
	jr $ra