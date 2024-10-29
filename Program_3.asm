# Program_3.asm
# Program that convert a decimal number to hexadecimal value

# Tell the program where to execute
.globl main

# Data section - Allocate memory
.data
    hexLookup: .byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
    prompt: .asciiz "Please enter an integer from 0 to 15: "

# Code
.text
main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read an integer
    li  $v0, 5          
    syscall
    move $t0, $v0       # save the input in $t1

    la  $t1, hexLookup       # Load address of hexLookup into $t1
    add $t1, $t1, $t0        # Calculate the address of the desired hex character
    lb  $a0, 0($t1)          # Load the hex character into $a0

    li $v0, 11       # Syscall to print character in $a0
    syscall

    li $v0, 10       # Load system call for exit
    syscall          # Make the system call