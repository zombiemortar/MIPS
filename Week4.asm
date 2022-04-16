.data
     welcome:        .asciiz "Welcome to the calculator.\n"
     prompt:         .asciiz "What is your name? "
     hello:          .asciiz "Hello "
     userInput:      .space 20
     menuSelectText: .asciiz "Please select from the following menu options:\n1: Addition.\n2: Multiplication\n3: Division.\n4: Exit\n"
     integer1:       .asciiz "Enter the first integer: "
     integer2:       .asciiz "Enter the second integer: "
     answer:         .asciiz  "The answer is: "
     newLine:        .asciiz "\n"
.text
    main:
        #Display the welcome message
        li $v0, 4
        la $a0, welcome
        syscall
    
        jal greeting # jump to the greeting procedure
        jal mainMenu # jump to the calculator main menu
        
        # Tell the program we are done
        li $v0, 10
        syscall
    
    greeting:
        # Asks for the users name
        li $v0, 4
        la $a0, prompt
        syscall
    
        # Accepts the users name and stores it in memory
        li $v0, 8
        la $a0, userInput
        li $a1, 20
        syscall
    
        #Displays the name
        li $v0, 4
        la $a0, hello
        syscall
        li $v0, 4
        la $a0, userInput
        syscall
    
        jr $ra
        
    mainMenu:        
        # Load menu selections into memory
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        addi $t1, $zero, 1
        addi $t2, $zero, 2
        addi $t3, $zero, 3
        addi $t4, $zero, 4
        
        # Display the menu options to the user
        li $v0, 4
        la $a0, menuSelectText
        syscall
        
        # Accept the menu selection from the user
        li $v0, 5
        syscall
        
        # Store the user menu selection in $t0
        move $t0, $v0
        
        # Based off the user selection stored in $t0, compare and select from the appropriate menu
        beq $t0, 1, addition
        beq $t0, 2, multiplication
        beq $t0, 3, division
        beq $t0, 4, exit

        
        lw $s0, 0($sp) #retreive the starting number from the stack to $s0
        addi $sp, $sp, 4 #restore the stack
        
        # Return to main
        jr $ra
        
   addition:
        addi $sp, $sp, -4 # allocate space in the stack to store $ra
        sw $ra, 0($sp) # Store $ra in the stack
        
        # Display the message asking for the first integer
        li $v0, 4
        la $a0, integer1
        syscall
        
        # Receive the first integer and store it in $f16 to create space in $f0
        li $v0, 7
        syscall
        add.d $f16, $f0, $f30
        
        # Display the message asking for the second integer
        li $v0, 4
        la $a0, integer2
        syscall
        
        # Retreive the first integer and store it in $f14 to create space in $f0
        li $v0, 7
        syscall
        add.d $f14, $f0, $f30
        
        # Display the answer string
        li $v0, 4
        la $a0, answer
        syscall
        
        # Display the float answer to the usre
        li $v0, 3
        add.d $f12, $f14, $f16
        syscall
        
        # Insert a blank new line for readability
        li $v0, 4
        la $a0, newLine
        syscall
        
        lw $s0, 0($sp) #retreive the starting number from the stack to $s0
        addi $sp, $sp, 4 #restore the stack
        
        # Return to calculator main menu
        jal mainMenu
        
   multiplication:
        addi $sp, $sp, -4 # Allocate space in the stack to store $ra
        sw $ra, 0($sp) # Store $ra in the stack
        
        # Display the message asking the user for the first integer
        li $v0, 4
        la $a0, integer1
        syscall
        
        # Retreive the integer and store it in $f16
        li $v0, 7
        syscall
        add.d $f16, $f0, $f30
        
        # Display the message asking for the second integer
        li $v0, 4
        la $a0, integer2
        syscall
        
        # Retrieve the integer and store it in $f14
        li $v0, 7
        syscall
        add.d $f14, $f0, $f30
        
        # display the first part of the answer string
        li $v0, 4
        la $a0, answer
        syscall
        
        # Multiply $f14 by $f16, store the result in $f12 then display to the user
        li $v0, 3
        mul.d  $f12, $f14, $f16
        syscall
        
        # Display a blank new line
        li $v0, 4
        la $a0, newLine
        syscall
        
        lw $s0, 0($sp) #retreive the starting number from the stack to $s0
        addi $sp, $sp, 4 #restore the stack
        
        # Return to main menu
        jal mainMenu     
        
   division:
        addi $sp, $sp, -4 # Allocate space in the stack to store the position of $ra
        sw $ra, 0($sp) # Store $ra in the stack
        
        # Display a message asking the user for the first integer
        li $v0, 4
        la $a0, integer1
        syscall
        
        # Retrieve the integer and store it in $f16
        li $v0, 7
        syscall
        add.d $f16, $f0, $f30
        
        # Display a message asking the user for the second integer
        li $v0, 4
        la $a0, integer2
        syscall
        
        # Retrieve the integer and store it in $f14
        li $v0, 7
        syscall
        add.d $f14, $f0, $f30
        
        # Display the first part of the answer string
        li $v0, 4
        la $a0, answer
        syscall
        
        # Divide $f16 by $f14, store the result in $f12 and display to the user 
        li $v0, 3
        div.d $f12, $f16, $f14
        syscall
        
        # Display a blank new line
        li $v0, 4
        la $a0, newLine
        syscall
        
        lw $s0, 0($sp) #retreive the starting number from the stack to $s0
        addi $sp, $sp, 4 #restore the stack
        
        # Return to the main menu
        jal mainMenu
        
   exit:
        li $v0, 10
        syscall