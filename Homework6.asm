# Evaluate the expression 9C-2B*1A+7-5C*BC+23-AA
# You can only use 3 registers.
# Accept three numerical inputs from the user. A, B, C. Then push all numbers on the stack.

# Pop all numbers off the stack and provide the final answer
.data
	valueA:		.asciiz "Please input a value for A\n"
	valueB:		.asciiz "Please input a value for B\n"
	valueC:		.asciiz "Please input a value for C\n"
.text
	main:
		
		li $v0, 4					# Ask the user for Value A
		la $a0, valueA
		syscall
		li $v0, 5					# Accept user input for Value A
		syscall
		move $t0, $v0				# Move value of A to $t0
		
		sub $sp,$sp,4
		sw $t0,4($sp)				# Store the value of A in the bottom of the stack
		
		li $v0, 4					# Ask the user for Value B
		la $a0, valueB
		syscall
		li $v0, 5					# Accept the user input for Value B
		syscall
		move $t0, $v0
		
		sub $sp,$sp,4				# Store the Value B second to bottom in the stack
		sw $t0,4($sp)
		
		li $v0, 4					# Ask the user for value C
		la $a0, valueC
		syscall
		li $v0, 5					# Accept the user input for Value C
		syscall
		move $t0, $v0
		
		sub $sp,$sp,4				# Store Value C third to bottom in the stack
		sw $t0,4,($sp)
		
		lw $t0, 4($sp)				# Load value C from the Stack
		la $t1, 9
		mul $t0,$t0,$t1				# get 9*C
		
		sub $sp,$sp,4				# Push 9*C onto stack
		sw $t0,4,($sp)
		
		lw $t0, 12($sp)				# Recover Value B from the stack
		la $t1, -2
		mul $t0, $t0, $t1			# get -2*B
		lw $t1, 4,($sp)				# Load 9*C from the stack

		add $sp,$sp,4				# shrink the stack
		add $t1, $t1, $t0			# Get 9C-2B
		
		sub $sp,$sp,4				# Push 9C-2B to the stack
		sw $t1,4,($sp)
		
		lw $t0, 16($sp)				# Load value A from the stack		
		la $t1, 1
		mul $t0, $t0, $t1			# Get 1*A
		
		lw $t1, 4($sp)				# Load 9C-2B from the stack
		add $sp,$sp,4				# shrink the stack
		mul $t0, $t0, $t1			# Get 9C-2B*1A
		
		la $t1, 7
		add $t0, $t0, $t1			# get 9C-2B*1A+7
		
		sub $sp,$sp,4				# Push 9C-2B*1A+7 to the stack
		sw $t0,4,($sp)
		
		lw $t0,8($sp)				# Load value C from the stack
		la $t1, 5
		mul $t0, $t0, $t1			# Get 5C
		
		lw $t1,4($sp)				# Get 9C-2B*1A+7 from the stack
		add $sp,$sp,4				# Shrink the stack
		sub $t0, $t1, $t0			# Get 9C-2B*1A+7-5C
		
		sub $sp,$sp,4
		sw $t0,4,($sp)				# Push 9C-2B*1A+7-5C to the stack
		
		lw $t0,12($sp)				# Get value B from the stack
		lw $t1,8($sp)				# Get Value C from the stack
		mul $t0,$t0,$t1				# Get B*C
		
		lw $t1,4($sp)				# Get 9C-2B*1A+7-5C*BC from the stack
		mul $t0,$t0,$t1
		
		la $t1, 23
		add $t0, $t0, $t1			# Get 9C-2B*1A+7-5C*BC+23
		
		lw $t1,16($sp)				# Load value A from the stack
		addu $sp,$sp,-16			# Pop the stack
		mul $t1, $t1, $t1			# Get AA
		sub $t0, $t0, $t1			# Get 9C-2B*1A+7-5C*BC+23-AA
		
	done:
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 10
		syscall
		
		
		
		
		
		
		
	
	
