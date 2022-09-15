.data
string1: .asciiz "Enter a character string: "
string2: .asciiz "The string is a palindrome."
string3: .asciiz "The string is not a palindrome."
.align 2
buffer: .space 20

.text
.globl main

main:
	# print string1 to ask for input
	li $v0,4
	la $a0,string1
	syscall
	
	# input your string to buffer address
	li $v0,8
	la $a0,buffer
	la $a1,20
	syscall
			
	jal strlen
	# $t1 (j) = strlen(buffer[],max_size)
	move $t1,$v0
	# j = j - 1
	addi $t1,$t1,-1
	# $t0 (i) = 0
	li $t0,0
while:
	# while(i<j) and does not care index i = j because it is same character
	bge $t0,$t1,end
	# get character in index i from buffer and load it to $t4
	add $t2,$a0,$t0
	lb $t4,0($t2)
	# get character in j index from buffer and load it to $t5
	add $t3,$a0,$t1
	lb $t5,0($t3)
	
	# if($t4==$t5) then jump to continous label to have i++ and j-- and loop back
	beq $t4,$t5,continous
	
	# else just print out string3 since both char are not the same
	li $v0,4
	la $a0,string3
	syscall
	
	# jump to exit the program
	j exit
continous:
	# i++
	addi $t0,$t0,1
	# j--
	addi $t1,$t1,-1
	# re-loop
	j while
end:	
	# if the while successful then it is palindrome string
	# so print string2 out
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
	
	# assign temp ($t5) = string array ($a0)
	move $t5,$a0
	
	# count = 0
	li $t0,0
loop:
	# load each char (byte) in $t5 string
	lb $t1,0($t5)	
	
	# check if char is zero which right after Null char
	# if true then stop the loop
	beqz $t1,done
	
	# else count++
	addi $t0,$t0,1
	# increment $t5 address by 1-byte each loop
	addi $t5,$t5,1
	j loop
done:
	# because after string always have neuline (\n)
	# so return count - 1 to uncount the newline
	addi $v0,$t0,-1
	lw $s0,0($sp)
	addi $sp,$sp,4
	jr $ra
