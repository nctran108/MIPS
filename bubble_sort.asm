.data
input:.asciiz "Input array = "
space:	.asciiz " "
newline: .asciiz "\n"
.align 2
array1: .word 1,5,6,4,3,7,9,8,2
array2: .word 8,1,6,2,3,5,9,7,4

main:



	# exit program
	li $v0,10
	syscall
	
# void swap(int* a,int* b);
void:



# void bubbleSort(int A[], int n);
bubbleSort:


# void print(int A[], int n);
print: