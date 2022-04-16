.data
     newLine: .asciiz "\n"
.text
     main:
          addi $s0, $zero, 10
          
          jal increaseMyRegister
          
          #Prints a new line
          li $v0, 4
          la $a0, newLine
          syscall
          
         #Print Value!
          li $v0, 1
          move $a0, $s0
          syscall
     
     #This line signals end of program
     li $v0, 10
     syscall
     
     increaseMyRegister:
          addi $sp, $sp, -4 #we use -4 here to allocate 4 bytes of information to store an integer from above, subtraction increases stack size.
          sw $s0, 0($sp) #save the value of s0 to the first location in the stack pointer
          
          addi $s0, $s0, 30
          
          #Print new value in function
          li $v0, 1
          move $a0, $s0
          syscall
          
          lw $s0, 0($sp) #retreive the starting number from the stack to $s0
          addi $sp, $sp, 4 #restore the stack
                    
          jr $ra