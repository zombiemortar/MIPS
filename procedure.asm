.data
     message: .asciiz "Hi everybody. \nMy name is Joseph.\n\n"
     message2: .asciiz "\n\nSecond message should be here.\n\n"
.text
    main:
        jal displayMessage
        addi $s0, $zero, 5
        li $v0, 1
        move $a0, $s0
        syscall
        jal displayMessage2
    
    #Tell the system that the program is done
    li $v0, 10
    syscall
    
    displayMessage:
         li $v0, 4
         la $a0, message
         syscall
         
         jr $ra
         
    displayMessage2:
    	li $v0, 4
    	la $a0, message2
    	syscall
    	
    	jr $ra