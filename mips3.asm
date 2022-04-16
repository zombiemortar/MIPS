.data
    age: .word 37

.text
    li $v0, 1
    lw $a0, age
    syscall