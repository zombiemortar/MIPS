.data
    welcome1:        .asciiz "Welcome to my CSC 2200 Homework Program \n"
    welcome2:        .asciiz "I am a student at Methodist University \n"
    welcome3:        .asciiz "I am taking CSC 2200 in the Spring 2022 Semester \n"
    explain:         .asciiz "This program will add 4 to the numbers that you enter.\n"
    prompt:          .asciiz "Please enter your first number: "
    prompt2:         .asciiz "Please enter your second number: " 
    prompt3:         .asciiz "Please enter your third number: "
    prompt4:         .asciiz "Please enter your fourth number: "
    prompt5:         .asciiz "Please enter your fifth number: "
    answer:          .asciiz "Your total is: "
.text
    # Begin the welcome strings
    li $v0, 4
    la $a0, welcome1
    syscall
    
    li $v0, 4
    la $a0, welcome2
    syscall
    
    li $v0, 4
    la $a0, welcome3
    syscall
    
    li $v0, 4
    la $a0, explain
    syscall
    
    # Ask the user for their first input
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 5
    syscall
    
    # Move the user input to register $t1
    move $t1, $v0 
    
    # Adds the user value from $t1 to $s2, and stores it in $s2
    add $s2, $s2, $t1 
    
    # Stores the value 4 in register $s0
    li $s0, 4
    
    # Adds 4 to the user input and stores it in $s3
    add $s3, $s0, $s2
    
    # Ask the user for their second input
    li $v0, 4
    la $a0, prompt2
    syscall
    
    li $v0, 5
    syscall
    
    # Move the user input to register $t1
    move $t1, $v0
    
    # Adds the user value to and stores it in $t6
    add $t6, $s3, $t1
    
    # Ask the user for their third input
    li $v0, 4
    la $a0, prompt3
    syscall
    
    li $v0, 5
    syscall
    
    # move the user input to register $t2
    move $t2, $v0
    
    # Adds the user input
    add $t6, $t6, $t2
    
    # Ask the user for their fourth input
    li $v0, 4
    la $a0, prompt4
    syscall
    li $v0, 5
    syscall
    move $t3, $v0
    
    # Adds the user input
    add $t6, $t6, $t3
    
    # Ask the user for their fifth input
    li $v0, 4
    la $a0, prompt5
    syscall
    li $v0, 5
    syscall
    
    # Move the user input to register $t4
    move $t4, $v0
    
    # Adds the user input
    add $t6, $t6, $t4
    
    # Display the string preceeding the anser
    li $v0, 4
    la $a0, answer
    syscall
    
    # Display the result
    li $v0, 1
    move $a0, $t6
    syscall
    
    # Clear the registers that were used
    li $s3, 0
    li $t6, 0
    li $s2, 0
    li $s0, 0
    li $t3, 0
    li $t2, 0
    li $t4, 0
    li $t1, 0
    li $a0, 0
    
    