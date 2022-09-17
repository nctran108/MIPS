.data
input:.asciiz "Input array = "
sorted: .asciiz "sorted array = "
space:	.asciiz " "
newline: .asciiz "\n"
.align 2
array1: .word 1,5,6,4,3,7,9,8,2
array2: .word 8,1,6,2,3,5,9,7,4

.text
.globl main

main:
	li $v0,4
	la $a0,input
	syscall
	# print input array
	la $a0,array1
	addi $a1,$zero,9
	jal print
	
	# sort the array
	jal bubbleSort
	
	# add newline
	li $v0,4
	la $a0,newline
	syscall
	
	# print sorted array
	li $v0,4
	la $a0,sorted
	syscall
	la $a0,array1
	addi $a1,$zero,9
	jal print
	
	# exit program
	li $v0,10
	syscall
	
# void swap(int* a,int* b);
swap:
	
	# temp = b
	move $t0,$a0
	# a = b
	move $a0,$a1
	# b = temp
	move $a1,$t0
	jr $ra

# void bubbleSort(int A[],int n);
bubbleSort:
	addi $sp,$sp,-12	
	sw $ra,12($sp)	# store $ra
	sw $s2,8($sp)	# store $s2
	sw $s1,4($sp)	# store $s1
	sw $s0,0($sp)	# store $s0
	
	move $s0,$a0	# save $a0 to $s0
	move $s1,$a1	# save $a1 to $s1
	move $s2,$zero	# i = 0
	
	# j = 0
	li $t1,0
	# $t3 = n - 1
	addi $t3,$a1,-1
loop1:
	# while(i<n-1)
	bge $s2,$t3,return
	# $t4 = n - 1 - i = $t3 - i
	sub $t4,$t3,$s2
	loop2:	# while(j<n-i-1)
		bge $t1,$t4,end_loop2
		# $t2 = 4*j = 4*$t1
		mul $t2,$t1,4
		# $t5 = j + 1 which equal 4*$t1 + 4
		addi $t5,$t2,4

		# load $a0 = A[j] and $a1 = A[j+1]
		add $t6,$s0,$t2	
		lw $a0,0($t6)
		
		add $t7,$s0,$t5
		lw $a1,0($t7)
		# if(A[j] > A[j+1])
		ble $a0,$a1,skip
		jal swap
		# store swap value back to array
		sw $a0,0($t6)
		sw $a1,0($t7)
	skip:		
		# j++
		addi $t1,$t1,1
		j loop2
	end_loop2:
	# reset j = 0 or $t1 = 0
	li $t1,0
	# i++
	addi $s2,$s2,1
	j loop1
return:	
	move $a0,$s0	# restore $a0 = A[]
	move $a1,$s1	# restore $a1 = n
	lw $s0,0($sp)	# restore $s0
	lw $s1,4($sp)	# restore $s1
	lw $s2,8($sp)	# restore $s2
	lw $ra,12($sp)	# restore $ra
	addi $sp,$sp,12	# remove stack
	jr $ra		# return


# void print(int A[],int n);
print:
	addi $sp,$sp,-4
	sw $s0,0($sp)
	
	# save $a0 to $s0
	move $s0,$a0
		
	# i = 0
	li $t0,0
while:
	# while(i<n)
	bge $t0,$a1,end
	mul $t3,$t0,4
	# get temp[i]
	add $t2,$s0,$t3
	# load $a0 = temp[i]
	lw $a0,0($t2)
	# print integer syscall
	li $v0,1
	syscall
	
	# i++
	addi $t0,$t0,1
	j while
end:
	# reset array
	move $a0,$s0
	lw $s0,0($sp)
	addi $sp,$sp,4
	jr $ra
