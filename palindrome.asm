.data
string1: .asciiz "Enter a character string: "
string2: .asciiz "The string is a palindrome."
string3: .asciiz "The string is not a palindrome."
.align 2
buffer: .space 20

.text
.globl main

main:
	# print string ask for input
	li $v0,4
	la $a0,string1
	syscall
	
	# input your string
	li $v0,8
	la $a0,buffer
	la $a1,20
	syscall
			
	jal strlen
	# $t1 (j) = strlen(A[],max_size)
	move $t1,$v0
	addi $t1,$t1,-1
	# $t0 (i) = 0
	li $t0,0
while:
	# while(i<j)
	bge $t0,$t1,end
	# get A[i} character
	add $t2,$a0,$t0
	lb $t4,0($t2)
	# get A[j] character
	add $t3,$a0,$t1
	lb $t5,0($t3)
	
	beq $t4,$t5,continous
	
	li $v0,4
	la $a0,string3
	syscall
	
	j exit
continous:
	addi $t0,$t0,1
	addi $t1,$t1,-1
	j while
end:	
	li $v0,4
	la $a0,string2
	syscall	
exit:	
	# exit the program
	li $v0,10
	syscall
	
# int strlen(A[], size) -> int	
strlen:
	addi $sp,$sp,-4
	sw $s0,0($sp)
	
	# count = 0
	li $t0,0
loop:
	lb $t1,0($a0)	
	
	beqz $t1,done
	
	addi $t0,$t0,1
	addi $a0,$a0,1
	j loop
done:
	addi $v0,$t0,-1
	lw $s0,0($sp)
	addi $sp,$sp,4
	jr $ra
	
