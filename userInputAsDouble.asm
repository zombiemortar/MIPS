.data
     prompt:       .asciiz "Enter the value of e: "
.text
     # Display Message to the user
     li $v0, 4
     la $a0, prompt
     syscall
     
     #get the double from user
     li $v0, 7
     syscall
     
     # Display user input
     li $v0, 3
     add.d $f12, $f0, $f10
     syscall