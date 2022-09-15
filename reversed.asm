.data
reversed:.asciiz "Reversed array = "
space:	.asciiz " "
NEWLINE: .ascii "\n"
.align 2
array1: .word 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
array2: .word 2, 4, 6, 8, 10

.text
.globl main

main: 
	li $v0,4		# load $v0 to 4 to print string from address $a0
	la $a0, reversed	# load address from $a0
	syscall			# print the string in terminal
      
	# $t0 = start and $t1 = end     
	add $t0, $zero, $zero	
	# 36 because array size = 10 will have index from 0*4 to 9*4 = 0 to 36
	addi $t1, $zero, 36	
	
reverse: 
	bge $t0, $t1, Finish	# while (start < end) 
        
        # set integer from label address $t0 to $t5   
	lw $t5, array1($t0)	
	# set integer from label address $t1 to $t6
	lw $t6, array1($t1)	
	
	# store integer from $t5 to label address $t1  
	sw $t5, array1($t1)
	# store integer from $t6 to label address $t0
	sw $t6, array1($t0)
	
	# $t0 = $t0 + 4                        
	addi $t0, $t0, 4
	# $t1 = $t1 - 4
	subi $t1, $t1, 4
	j reverse
Finish:
	# i = 0
	addi $t0, $zero, 0	
	# $t1 = 0 (index start at 0)
	addi $t1, $zero, 0

print: 
	bge $t0, 10, end	# while(i < 10)
      	
      	# load $v0 to 1 to print integer from $a0
	li $v0,1		
	# load A[$t1} value to $t3	
	lw $t2, array1($t1)	
	# move value from $t2 to $a0 to print out the integer
	move $a0, $t2		
	syscall      
	
	# $t1 = $t1 + 4      
	addi $t1, $t1, 4
	# load string from space address to add space for every loop
	li $v0,4			
	la $a0, space
	syscall
      	
      	# i = i + 1
	addi $t0, $t0, 1		
	j print
end:
