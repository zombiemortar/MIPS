.data
	welcome1:		.asciiz "Welcome to the Calculator\n"
	welcome2:		.asciiz "Please select from one of the following menu options.\n"
	menu:			.asciiz "1. Addition\n2. Multiplication\n3. Division\n4. Subtraction\n5. Mixed Calculations\n6. Exit\n"
	oopExplain:		.asciiz "This menu lets you perform division then multiplication on three numbers.\nA problem should be for example 2/2*2\n"
	firstNum:		.asciiz "Enter the first number.\n"
	secondNum:		.asciiz "Enter the second number.\n"
	thirdNum:		.asciiz "Enter the third number.\n"
	total:			.asciiz "Your total is: "
	return:			.asciiz "\nPlease select from the following:\n1. Return to main menu.\n2. Exit Program\n"
	error:			.asciiz "Select a number between 1 and 6, returning to Main Menu.\n"
	error2:			.asciiz "Select either 1 or 2.\n"
	exit_msg:		.asciiz "Thank you!\nGood Bye!"
.text
	# Display the welcome messages
	li $v0, 4
	la $a0, welcome1
	syscall
	li $v0, 4
	la $a0, welcome2
	syscall
	jal mainMenu
	
	mainMenu:
	# Display the options menu to the user
	li $v0, 4
	la $a0, menu
	syscall
	# Accept menu input from the user
	li $v0, 5
	syscall
	# Move the user input to register $t0
	move $t0, $v0
	blez $t0, error_msg			# Disallow any entry less than 1
	beq $t0, 1, addition
	beq $t0, 2, multiplication
	beq $t0, 3, division
	beq $t0, 4, subtraction
	beq $t0, 5, mixed
	beq $t0, 6, exit
	bgt $t0, 6, error_msg		# Disallow any entry greater than 6
	
	# Error message display for main menu
	error_msg:
	li $v0, 4
	la $a0, error
	syscall
	jal mainMenu
	
	# Error message display for sub menu
	error_msg2:
	li $v0, 4
	la $a0, error2
	syscall
	
	# Return message options
	return_msg:
	addi $sp, $sp, -4
    sw $ra, 0($sp)
    # Display the return option to the user
	li $v0, 4
	la $a0, return
	syscall
	# Accept the user input for return
	li $v0, 5
	syscall
	move $t1, $v0
	# Determine user input and jump to appropriate menu.
	blez $t1, error_msg2
	beq $t1, 1, mainMenu
	beq $t1, 2, exit
	bgt $t1, 2, error_msg2
	
	# Addition sub menu
	addition:
	# Pre clear registers that will be used
	li $t0, 0
	li $t1, 0
	li $t2, 0
	# Prompt the user for the first number
	li $v0, 4
	la $a0, firstNum
	syscall
	# Accept user input for the first number
	li $v0, 5
	syscall
	# Move the first number to register $t0
	move $t0, $v0
	# Prompt the user for the second number
	li $v0, 4
	la $a0, secondNum
	syscall
	# Accept user input for the second number
	li $v0, 5
	syscall
	# Move the second number to register $t1
	move $t1, $v0
	# Add the first and second numbers together
	add $t2, $t0, $t1
	# Display the answer prompt to the user
	li $v0, 4
	la $a0, total
	syscall
	# Load the answer into register $a0 and display to the user
	li $v0, 1
	move $a0, $t2
	syscall
	jal return_msg
	
	# Multiplication sub menu
	multiplication:
	# pre clear registers that will be used
	li $t0, 0
	li $t1, 0
	li $t2, 0
	# Ask user for first number
	li $v0, 4
	la $a0, firstNum
	syscall
	# Accept the user input
	li $v0, 5
	syscall
	move $t1, $v0
	# Prompt the user for the second number
	li $v0, 4
	la $a0, secondNum
	syscall
	# Accept the user input
	li $v0, 5
	syscall
	# move second integer to register $t2
	move $t2, $v0
	# Multiply $t1 by $t2 and store the answer in register $t0
	mul $t0, $t1, $t2
	# Display the total
	li $v0, 4
	la $a0, total
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	jal return_msg
	
	# Division sub menu
	division:
	# pre clear registers are cleared prior to divisions
	add.d $f14, $f18, $f18
	add.d $f10, $f18, $f18
	add.d $f12, $f18, $f18
	# Ask user for first number
	li $v0, 4
	la $a0, firstNum
	syscall
	# Accept the user input
	li $v0, 7
	syscall
	add.d $f10, $f12, $f0
	# Prompt the user for the second number
	li $v0, 4
	la $a0, secondNum
	syscall
	# Accept the user input
	li $v0, 7
	syscall
	# move second integer to register $t2
	add.d $f14, $f12, $f0
	# Multiply $t1 by $t2 and store the answer in register $t0
	div.d $f16, $f10, $f14
	# Display the total
	li $v0, 4
	la $a0, total
	syscall
	li $v0, 3
	add.d $f12, $f16, $f18
	syscall
	# Jump to return menu
	jal return_msg
	
	# Subtraction sub menu
	subtraction:
	# Pre clear registers that will be used
	li $t0, 0
	li $t1, 0
	li $t2, 0
	# Prompt the user for the first number
	li $v0, 4
	la $a0, firstNum
	syscall
	# Accept user input for the first number
	li $v0, 5
	syscall
	# Move the first number to register $t0
	move $t0, $v0
	# Prompt the user for the second number
	li $v0, 4
	la $a0, secondNum
	syscall
	# Accept user input for the second number
	li $v0, 5
	syscall
	# Move the second number to register $t1
	move $t1, $v0
	# subtract the second number from the first number
	sub $t2, $t0, $t1
	# Display the answer prompt to the user
	li $v0, 4
	la $a0, total
	syscall
	# Load the answer into register $a0 and display to the user
	li $v0, 1
	move $a0, $t2
	syscall
	# Jump to the return menu
	jal return_msg
	
	# Mixed calculation menu
	mixed:
	# Pre cleare registers that will be used
	add.d $f10, $f20, $f20
	add.d $f12, $f20, $f20
	add.d $f14, $f20, $f20
	add.d $f16, $f20, $f20
	add.d $f18, $f20, $f20
	add.d $f22, $f20, $f20
	# Display the instruction set to the user
	li $v0, 4
	la $a0, oopExplain
	syscall
	# Ask the user for their first number
	li $v0, 4
	la $a0, firstNum
	syscall
	# Accept the user input
	li $v0, 7
	syscall
	# Move user input to register $f10
	add.d $f10, $f12, $f0
	# Ask the user for the second number
	li $v0, 4
	la $a0, secondNum
	syscall
	# Accept the user input
	li $v0, 7
	syscall
	# Move the user input to register $f14
	add.d $f14, $f12, $f0
	# Divide first number by second number, store in register $f16
	div.d $f16, $f10, $f14
	# Ask the user for the third number
	li $v0, 4
	la $a0, thirdNum
	syscall
	# Accept the user input
	li $v0, 7
	syscall
	# Move the user input to register $f18
	add.d $f18, $f12, $f0
	# Multiply the quotient from step one by the third number store in register $f22
	mul.d $f22, $f16, $f18
	# Display the result to the user
	# Clear $f220
	add.d $f12, $f20, $f20
	li $v0, 4
	la $a0, total
	syscall
	li $v0, 3
	add.d $f12, $f22, $f20
	syscall
	jal return_msg
	
	# Exit routine
	exit:
	li $v0, 4
	la $a0, exit_msg
	syscall
	li $v0, 10
	syscall