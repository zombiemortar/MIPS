.data
	welcome1:		.asciiz "Welcome to the bulk fuel calculator.\n"
	welcome2:		.asciiz "With this calculator, you will be able to see account information on 5 accounts.\n"
	welcome3:		.asciiz "You will also be able to see a rollup of accounts recievable and accounts payable.\n"
	menuSelect1:	.asciiz "Please select from one of the following menu items to continue.\n"
	menuSelect2:	.asciiz "\n1. Account Control.\n2. Accounts Recievable.\n3. Accounts Payable\n4. Exit.\n"
	basePrice:		.asciiz "What is the base price per gallon?\n"
	taxesPrice:		.asciiz "What is the tax rate in decimal?  For example 0.7\n"
	accCtrlSel:		.asciiz "Please select one of the following accounts to modify, or exit."
	accountControl:	.asciiz "\n1. Smith\n2. Jones\n3. Bradley\n4. House\n5. Chan\n6. Return to Main Menu\n7. Exit\n"
	accMod1:		.asciiz "Account summary is as follows: \n"
	accMod2:		.asciiz "Total Sold: $"
	accMod3:		.asciiz "\nAmount Owed: $"
	accMod4:		.asciiz "\nTaxes Owed: $"
	accMod5:		.asciiz "\nPlease select from the following menu items:"
	accModSel:		.asciiz "\n1. Sell Fuel on Account.\n2. Pay Account.\n3. Return to Previous Menu\n4. Exit\n"
	error_msg1:		.asciiz "Incorrect entry, please try again.\n"
	error_msg2:		.asciiz "Incorrect entry, please try again.\n"
	exit_msg:		.asciiz "\nThank you!\nGood Bye!"
	zeroAsFloat: 	.float 0.0
	sellMsg1:		.asciiz "Please enter the amount to be sold\n"
	payQuestion:	.asciiz "How much would you like to pay toward the base?\n"
	payQuestion2:	.asciiz "How much would you like to pay toward taxes?\n"

.text
	# Welcome Section
	# Load known constants into the program
	lwc1 $f30, zeroAsFloat
	li $v0, 4
	la $a0, welcome1
	syscall
	li $v0, 4
	la $a0, welcome2
	syscall
	li $v0, 4
	la $a0, welcome3
	syscall
	
	# Jump to constant entry menu
	jal constants
	# Jump to main menu
	jal mainMenu
	
	# Menu for the user to input their data constants
	constants:
	# Ask user for base price
	li $v0, 4
	la $a0, basePrice
	syscall
	# Accept user entry
	li $v0, 6
	syscall
	# Store base price into $f26 DO NOT OVERWRITE THIS REGISTER
	add.s $f26, $f0, $f30
	# Ask user for the tax rate
	li $v0, 4
	la $a0, taxesPrice
	syscall
	# Accept the user input
	li $v0, 6
	syscall
	# store the base price into $f28 DO NOT OVERWRITE THIS REGISTER
	add.s $f28, $f0, $f30
	# Return to previous
	jr $ra
	
	# Main Menu to select accounts to modify
	mainMenu:
	# Ask user for menu selection
	li $v0, 4
	la $a0, menuSelect1
	syscall
	li $v0, 4
	la $a0, menuSelect2
	syscall
	# Accept the user input for menu selection
	li $v0, 5
	syscall
	# Move the user input from $v0 to $t0
	move $t0, $v0
	# If routine to determine where to place user
	blez $t0, error_msg_main
	beq $t0, 1, account_control
	beq $t0, 2, account_recieve
	beq $t0, 3, account_payable
	beq $t0, 4, exit
	bgt $t0, 4, error_msg_main
	
	# Error subroutines
	error_msg_main:
	li $v0, 4
	la $a0, error_msg1
	syscall
	jal mainMenu
	
	error_msg_sub:
	li $v0, 4
	la $a0, error_msg2
	syscall
	
	# Main account control area
	# Ask the user which account to modify
	account_control:
	li $v0, 4
	la $a0, accCtrlSel
	syscall
	li $v0, 4
	la $a0, accountControl
	syscall
	# Accept the user input
	li $v0, 5
	syscall
	# Move the user input to $t0
	move $t0, $v0
	# If routine to determine where to drop the user
	blez $t0, error_msg_sub
	beq $t0, 1, smith
	beq $t0, 2, jones
	beq $t0, 3, bradley
	beq $t0, 4, house
	beq $t0, 5, chan
	beq $t0, 6, mainMenu
	beq $t0, 7, exit
	bgt $t0, 7, error_msg_sub
	# Account 1 location "Smith"
	smith:
	# Display the account main page welcome screen
	li $v0, 4
	la $a0, accMod1
	syscall
	# Display account information
	# Sold information
	li $v0, 4
	la $a0, accMod2
	syscall
	li $v0, 2
	add.s $f12, $f2, $f30
	syscall
	# Taxes owed information
	li $v0, 4
	la $a0, accMod4
	syscall
	li $v0, 2
	add.s $f12, $f4, $f30
	syscall
	# Display account sub menu options
	li $v0, 4
	la $a0, accMod5
	syscall
	li $v0, 4
	la $a0, accModSel
	syscall
	# Accept user input for account sub menu
	li $v0, 5
	syscall
	# Move user selection  to $s0
	move $t1, $v0
	# Error checking and menu selection route
	blez $t1, smith_error_msg
	beq $t1, 1, smithSell
	beq $t1, 2, smithPay
	beq $t1, 3, account_control
	beq $t1, 4, exit
	bgt $t1, 4, smith_error_msg
	
	# Smith's error message
	smith_error_msg:
	li $v0, 4
	la $a0, error_msg2
	syscall
	jal smith

	# Sell fuel to Smith sub menu
	smithSell:
	# Display the selling message
	li $v0, 4
	la $a0, sellMsg1
	syscall
	# Accept the user input
	li $v0, 6
	syscall
	# Move the user input into $f8
	add.s $f8, $f0, $f8
	# Multiply $f8 by $f26, store in $f8
	mul.s $f8, $f8, $f26
	# Multiply $f8 by $f28, store in $f10
	mul.s $f10, $f8, $f28
	# Add this transaction amount to current transactions, store in $f2
	add.s $f2, $f8, $f2
	# Add these taxes to previous taxes, store in $f4
	add.s $f4, $f4, $f10
	# clear our temp registers
	add.s $f8, $f30, $f30
	add.s $f10, $f30, $f30
	jal smith
	
	# Pay smith fuel bill
	smithPay:
	# Display the pay question
	li $v0, 4
	la $a0, payQuestion
	syscall
	# accept the user input
	la $v0, 6
	syscall
	# temp store the information into $f6
	add.s $f6, $f0, $f30
	# subtract payment amount from total, store new total
	sub.s $f2, $f2, $f6
	# clear register $f6
	sub.s $f6, $f30, $f30
	# Ask the user how much to pay in taxes
	li $v0, 4
	la $a0, payQuestion2
	syscall
	# Accept the user input
	la $v0, 6
	syscall
	# temp store the information into $f6
	add.s $f6, $f0, $f30
	# subtract payment from current taxes owed
	sub.s $f4, $f4, $f6
	# Clear the temp register
	sub.s $f6, $f30, $f30
	jal smith
	
	# Account 2 location
	jones:
	li $v0, 4
	la $a0, accMod1
	syscall
	# Display the account information
	# Sold Information
	li $v0, 4
	la $a0, accMod2
	syscall
	li $v0, 2
	add.s $f12, $f3, $f30
	syscall
	# Display the taxes owed
	li $v0, 4
	la $a0, accMod4
	syscall
	li $v0, 2
	add.s $f12, $f5, $f30
	syscall
	# Sub menu selection
	li $v0, 4
	la $a0, accMod5
	syscall
	li $v0, 4
	la $a0, accModSel
	syscall
	# Accepts the user input for sub menu
	li $v0, 5
	syscall
	# Moves the user input to $s0
	move $s0, $v0
	# Error checking and menu routine
	blez $s0, jones_error_msg
	beq $s0, 1, jonesSell
	beq $s0, 2, jonesPay
	beq $s0, 3, account_control
	beq $s0, 4, exit
	bgt $s0, 4, jones_error_msg
	
	# jones error message
	jones_error_msg:
	li $v0, 4
	la $a0, error_msg2
	syscall
	jal jones
	
	# Sell fuel to Jones sub menu
	jonesSell:
	li $v0, 4
	la $a0, sellMsg1
	syscall
	# Accept the user input
	li $v0, 6
	syscall
	# Move the input to $f8
	add.s $f8, $f0, $f8
	# Multiply the amount sold by selling price
	mul.s $f8, $f8, $f26
	# Get taxes
	mul.s $f10, $f8, $f28
	# add these transactions
	add.s $f3, $f8, $f3
	add.s $f5, $f10, $f5
	# clear the temp registers
	add.s $f8, $f30, $f30
	add.s $f10, $f30, $f30
	jal jones
	
	# Pay account 2 bill
	jonesPay:
	# Display the pay question
	li $v0, 4
	la $a0, payQuestion
	syscall
	# Accept the user input
	li $v0, 6
	syscall
	# Temp store information into register $f6
	add.s $f6, $f0, $f30
	# subtract pay amount from sold
	sub.s $f3, $f3, $f6
	# clear register $f6
	sub.s $f6, $f30, $f30
	# Ask the user how much to pay in taxes
	li $v0, 4
	la $a0, payQuestion2
	syscall
	# Accept the user input
	li $v0, 6
	syscall
	# Temp store the value in register $f6
	add.s $f6, $f0, $f30
	# subtract the tax payment
	sub.s $f5, $f5, $f6
	# clear the temp register
	sub.s $f6, $f30, $f30
	jal jones
	
	# Account 3 menu
	bradley:
	# Account main welcome screen
	li $v0, 4
	la $a0, accMod1
	syscall
	# Display the account information
	# Sold information
	li $v0, 4
	la $a0, accMod2
	syscall
	li $v0, 2
	add.s $f12, $f14, $f30
	syscall
	# Tax informatin
	li $v0, 4
	la $a0, accMod4
	syscall
	li $v0, 2
	add.s $f12, $f7, $f30
	syscall
	# Display account sub menu options
	li $v0, 4
	la $a0, accMod5
	syscall
	li $v0, 4
	la $a0, accModSel
	syscall
	# Accept user input for account sub menu
	li $v0, 5
	syscall
	# Move user selection to $s0
	move $s0, $v0
	# Error checking and menu selection route
	blez $s0, bradley_error
	beq $s0, 1, bradleySell
	beq $s0, 2, bradleyPay
	beq $s0, 3, account_control
	beq $s0, 4, exit
	bgt $s0, 4, bradley_error
	
	bradley_error:
	li $v0, 4
	la $a0, error_msg2
	syscall
	jal bradley
	
	# Sell fuel to bradley
	bradleySell:
	# Pay account bradley
	bradleyPay:
	
	# Account 4 menu
	house:
	# Sell fuel to account 4
	
	# Pay account 4
	
	# Account 5 menu
	chan:
	# Sell fuel to account 5
	
	# Pay account 5
	
	# Main accounts receivable area
	account_recieve:
	# Display by account how much is owed on each account
	
	# Main accounts payable area
	account_payable:
	# Display tax information both by account and by business

	# Exit subroutine
	exit:
	li $v0, 4
	la $a0, exit_msg
	syscall
	li $v0, 10
	syscall

	
