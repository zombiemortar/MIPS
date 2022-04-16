.data

.text
    addi $s0, $zero, 4
    
    sll $t0, $s0, 2 #the number 2 is i to the power of where i is two
    
    #print it out
    li $v0, 1
    add $a0, $zero, $t0
    syscall